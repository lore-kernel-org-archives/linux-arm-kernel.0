From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Thu, 27 Oct 2016 19:27:03 +0300
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <4cfdd415-1965-7be9-b204-86a9931683a6@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <CAJ-oXjQbOkrkNToEXYmPUZOgYBGbxQREZ4NL4bMcZmG=KP2vQQ@mail.gmail.com>
 <99dde1e0-26f0-cc7b-36bf-1181c47296f9@redhat.com>
 <CAJ-oXjTfRDvSKs9zZBxt1V2MR5C+XnsqfZBRTWwRrJXx-_7r=Q@mail.gmail.com>
 <4cfdd415-1965-7be9-b204-86a9931683a6@redhat.com>
Message-ID: <82D85C4C-008C-49FA-B88E-E784F72F3060@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Nice to see other people coming up with similar problems.
It?s not a new thing at all, hacks like this have been around
since for ever (but safely tucked away in product specific areas).

> On Oct 27, 2016, at 17:53 , Hans de Goede <hdegoede@redhat.com> wrote:
> 
> Hi,
> 
> On 27-10-16 14:57, Pierre-Hugues Husson wrote:
>> 2016-10-27 11:14 GMT+02:00 Hans de Goede <hdegoede@redhat.com>:
>>> In my experience with these cheap boards, there is a mix of auto-probing +
>>> device / revision specific os-image modifications. I keep coming back to
>>> the touchscreen controller firmware (but also the orientation), for the
>>> gsl1680 controller I need at least 2 different firmware files (per gsl1680
>>> revision) to make all q8 tablets I have working. This is simply not solved
>>> by the vendor android code, they just shove the right firmware into the
>>> os-image. Likewise for the touchscreen orientation (x-mirored, y-mirored,
>>> etc) too is just a hard-coded setting in the os-image.
>> Reading your patch, it looks like to handle the two different firmware
>> files, you're simply adding a command-line switch, there is no
>> detection involved.
>> Am I understanding correctly?
> 
> No, the firmware-name (and matching resolution as different firmwares
> report different axis-ranges for the same digitizer) is selected
> primarily by the touchscreen_variant which sets: touchscreen_fw_name,
> touchscreen_width and touchscreen_height.
> 
> The touchscreen_variant module option defaults to -1 which means "auto",
> when it is auto it gets set based on the touchscreen / accelerometer
> combination (which more or less uniquely identifies boards sofar),
> likewise all the other touchscreen module options default to -1,
> but can be overridden from the commandline.
> 
> The intention is for things to just work, the commandline options are
> there as a fallback.
> 
>> If this is the case, two things:
>> 1. I'm not too sure having the user choose this via cmdline is the
>> right way. I think I'd rather have it set by userspace. (though that's
>> not a strong opinion).
>> Or if cmdline is being changed... how about having DTS (or just an
>> overlay on top of it) being changed instead?
>> 
>> 2. This could still be declared by DTS. For instance, assuming your
>> i2c-probe-stop-at-first-match:
>> &i2c0 {
>>        touchscreen1: gsl1680 at 40 {
>>                reg = <0x40>;
>>                compatible = "silead,gsl1680";
>>                enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>>                touchscreen-size = <1024 600>;
>>                touchscreen-fw = "gsl1680-a082-q8-700.fw";
>>                filter-names = "touchscreen_variant";
>>                filter-0 = "none", "gsl1680-a082-q8-700";
>>                id = <0xa0820000>;
>>                status = "disabled";
>>        };
>>        touchscreen2: gsl1680 at 40 {
>>                reg = <0x40>;
>>                compatible = "silead,gsl1680";
>>                enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>>                touchscreen-size = <480 800>;
>>                touchscreen-fw = "gsl1680-a082-q8-a70.fw";
>>                filter-names = "touchscreen_variant";
>>                filter-0 = "gsl1680-a082-q8-a70";
>>                id = <0xa0820000>;
>>               status = "disabled";
>>        };
>>        touchscreen2: gsl1680 at 40 {
>>                reg = <0x40>;
>>                compatible = "silead,gsl1680";
>>                enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>>                touchscreen-size = <960 640>;
>>                touchscreen-fw = "gsl1680-b482-q8-d702.fw";
>>                filter-names = "touchscreen_variant";
>>                filter-0 = "gsl1680-b482-q8-d702";
>>                id = <0xb4820000>;
>>               status = "disabled";
>>        };
>>        i2c-probe-stop-at-first-match = <&touchscreen1>,
>> <&touchscreen2>, <&touchscreen3>;
>> }
>> 
>> With "none" value being the value when the "touchscreen_variant"
>> option is not defined in cmdline.
>> 
>> Please note that I'm not too sure whether SILEAD_REG_ID represents an
>> OTP which can be changed by OEM, or if it's more of a hardware
>> revision. Depending on this, this would either fit into a id =
>> <0xa0820000> DTS line, or a compatible = "silead,gsl1680_a082",
>> "silead,gsl1680"; DTS line.
>> 
>>> Sofar I've only seen this with one type of touchscreen so an easy cop-out
>>> would be to add an "optional-vddio-supply" to the the bindings for the
>>> specific touchscreen use and put all the necessary logic in the driver.
>>> 
>>> This does require propagating the learned need for the regulator
>>> from the drivers detect() callback to probe() or alternatively I'm
>>> thinking we should just use probe() instead of detect()to begin with,
>>> that will save a lot of duplication with things
>>> like code for enable gpio-s and regulators.
>>> 
>>> So assuming we go for the cop-out option for 3. (I'm ok with that),
>>> this would be a pretty clean solution adding just the 2 new:
>>> i2c-probe-stop-at-first-match and i2c-probe-all properties to
>>> the i2c-bus bindings. One problem here is that we may want to have
>>> multiple i2c-probe-stop-at-first-match phandle lists on a single bus
>>> (e.g. try 3 touchscreens + 6 accelerometers on the same bus, stop at
>>> first touchscreen / first accelerometer), anyone have any ideas for
>>> that?
>> How about something like:
>> 
>> &i2c1 {
>>    touchscreen1....
>>    touchscreen2....
>>    touchscreen3....
>>    accelerometer1....
>>    accelerometer2....
>>    accelerometer3....
>>    accelerometer4....
>> 
>>    select-one {
>>       compatible = "i2c-select;
>>       group-names = "touchscreen", "accelerometer";
>>       group-0 = <&touchscreen1>, <&touchscreen2>, <&touchscreen3>;
>>       group-1 = <&accelerometer1>, <&accelerometer2>,
>> <&accelerometer3>, <&accelerometer4>;
>>    };
>> };
> 
> We could just have:
> 
> 	i2c-probe-stop-at-first-match-0 = <&touchscreen1>, <&touchscreen2>, <&touchscreen3>;
> 	i2c-probe-stop-at-first-match-1 = <&accelerometer1>, <&accelerometer2>;
> 
> And have the i2c bus code look for an i2c-probe-stop-at-first-match-[i++] property
> until it is not found. Having a child-node with its own compatible for this
> feels wrong, as it uses a hierarchy where there really is none.
> 

>>>> When it comes to detection, I've witnessed various things.
>>>> It can be kernel-side or bootloader-side "global setting" reading (like an
>>>> ADC/resistor value, or an OTP), it can be bootloader doing the
>>>> "brute-force", or it can be the kernel doing all the probes.
>>>> 
>>>> For instance, as of today, on a Spreadtrum ODM tree, the bootloader will
>>>> detect the screen by testing all knowns screens, the screen-drivers declare
>>>> a get_id function, and the bootloader probes until the get_id matches the id
>>>> declared by the screen driver.
>>>> And then the bootloader tells the kernel, via cmdline, which screen is
>>>> actually there (but auto-detection is also coded in kernel).
>>>> Finally all possible sensors/touchscreen/camera are declared in DTS, and
>>>> probe will filter-out N/C ones in the kernel.
>>>> 
>>>> Now the big difference between my experience and what Hans is trying to
>>>> do, is that I've always worked with devices with "safely" queriable IDs,
>>>> either on i2c or dsi. I've never encountered SPI. This makes probing
>>>> inherently more dangerous, but I believe the question roughly remains the
>>>> same.
>>> 
>>> 
>>> I'm dealing with i2c too, Mark mistakenly used SPI in his reply,
>>> which I think is what got you thinking I've SPI.
>> Right, so let's concentrate on reasonable bus-es first then. (I can
>> think of I2C and DSI)
>> 
>>> See above, I think that we can make this work by delegating the actual
>>> detection to the driver (so each compatible can have a different detect
>>> method / code).
>>> So with this we can remove a big part of drivers/misc/q8-hardwaremgr.c, but
>>> not all
>>> of it. We still need board specific code somewhere to deal with things like
>>> picking
>>> the right touchscreen firmware and touchscreen orientation. This is all
>>> somewhat
>>> gsl1680 specific.
>>> I actually have the same problem on x86 where the ACPI description of the
>>> device
>>> basically says: "There is a gsl1680 at this bus at this address" and does
>>> not say
>>> anything about firmware / orientation (again this is simply hardcoded
>>> in the os-image these devices ship with).
>>> 
>>> For x86 my plan is to have an array of configs in the driver and select the
>>> right
>>> one based on DMI strings, which is in essence putting board specific info in
>>> the
>>> driver.
>>> 
>>> I can imagine mirroring this for ARM, and have an array of configs in the
>>> driver
>>> there too (for cases where cannot simply hardcode everything in dt only) and
>>> have
>>> some board specific code (activated by of_machine_is_compatible()) to select
>>> the
>>> right config.
>> I do believe this can all be done in DTS
> 
> Well x86 does not have DTS.
> 

Says who? :)

x86 _can_ have DT and there?s no problem using it at all.
For custom boards no one wants to go through the insane ACPI limitations.

FWIW all the x86 mobile parts used it (but are now RIP).

>> and at the moment, what
>> you're describing seem to happen often enough to be worth writing
>> generic code for.
> 
> Let me quote some of the auto-code currently in q8-hardwaremgr.c :
> 
>                /*
>                 * These accelerometer based heuristics select the best
>                 * default based on known q8 tablets.
>                 */
>                switch (data->accelerometer.model) {
>                case da280:
>                        if (data->accelerometer.addr == 0x27)
>                                ; /* No-op */
>                        else if (data->has_rda599x)
>                                data->touchscreen_invert_x = 1;
>                        else
>                                data->touchscreen_invert_y = 1;
>                        break;
>                case dmard09:
>                        data->touchscreen_invert_x = 1;
>                        break;
>                case mxc6225:
>                        data->touchscreen_variant = 1;
>                        break;
>                }
> 
> (Non set data->touchscreen_foo are left at 0).
> 
> So this would require us to be able to filter (to use your example)
> on if another i2c device is found and on which address it is found,
> that does not even take the rda559x check into account and is
> going to cause interesting ordering issues, how do we know when
> we can actually do the filtering if some of the variables we are
> filtering on are set by other auto-detected paths. Which auto-detect /
> i2c-probe-stop-at-first-match list do we execute first ? Worse
> actually for accelerometer orientation I will likely need to
> set the mount-matrix based on the detected touchscreen ...
> 
> The rda559x here is a sdio wifi chip, which is also connected to the
> i2c, and currently is detected through i2c to be able to separately
> identify 2 q8 boards which share the same touchscreen + accelerometer
> combination and who knows what other checks I or other people can
> come up with to differentiate board variants which do not have
> a simple eeprom to uniquely id them.
> 
> So as said before, no this cannot be all done in dt without
> adding a turing complete language to dt, and that is just to
> select which touchscreen_variant to use.
> 
> Then there also the probem of the combinatorial explosion having
> not only 2 firmware files but also invert-x and invert-y flags causes:
> We have 2 revisions with each 2 different firmware-files (more actually
> but I've reduced the set since some firmwares are compatible) with each
> both the x- and / or y axis as normal or inverted, for a total of:
> 2 (revision) * 2 (firmware-files) * 2 (x-inverted or not) * 2 (y...) = 16
> touchscreen variants, which means dt nodes for touchscreen1 to touchscreen16
> and that is just the silead gsl1680, some of these tablets also have
> elan or zeitec touchscreen controllers.
> 

There is a combinatorial explosion, but only a finite number of _known_ 
board versions.

> Now imagine what happens if a new board comes out which needs a 3th firmware
> file... I hope you can understand this is not a route I want to go.
> 
> Another problem is that if a user encounters the need for a new firmware
> variant he can now not easily try this (where as before we had
> module options to separately override firmware-name, the size, etc.
> 
> As written in my previous mail, this is all rather gsl1680 specific,
> and esp. being able to override the firmware-name, the size, etc.
> through module options is going to be useful (to ask endusers to test
> stuff without recompiling) on x86 too. So we will likely want to add
> most of the necessary stuff to the silead driver anyways.
> 
>> But then, I can't really tell which makes the most sense between
>> source-based and devicetree-based.
>> I prefer doing it in device-tree, since it means that any OEM can have
>> his device supported by only providing DTB, and won't need to provide
>> kernel patches.
> 
> If the OEM provides a DTB the OEM can just directly have the right
> parameters in there without relying on any auto-detection, this is
> already supported and the e.g. gsl1680 driver already happily
> works on several tablets where there is not so much hardware
> variance.
> 
> Even if the OEM needs to deal with e.g. different touchscreens on
> different board revisions, hopefully the simple auto-detect code will
> be enough, and he does not need e.g. different firmware-name settings
> for otherwise the same touchscreen controller. If that is not the
> case then he the OEM will have to provide a separate static
> (non probing) DTB per variant.
> 
>>> 2) miscellaneous extra config on top of figuring out which ICs are
>>> connected,
>>> basically the kind of stuff many vendors simply hard-code in their device
>>> specific os-image. This one is much more difficult to deal with and I think
>>> we need to figure this out on a case by case basis. This will require board
>>> specific code (just like the kernel has tons of DMI string activated board
>>> specific code on x86) and what is the best code for this place to live will
>>> be a case by case thing too.
>> 
>> With things like mount-matrix devicetree property, the goal is to have
>> such informations in the DTS.
> 
> Right and all the info I'm talking about can already be in the DTS and
> is already specified this way for various existing boards, this is
> obviously how we want things to work, this is the normal case /
> the straight code path.
> 
> Now lets get back to your mount-matrix example, the problem here is 2 board
> variants where the same accelerometer is used, but on a newer revision
> of the board it is mounted with a different orientation and otherwise
> almost nothing is changed on the board, certainly not something as
> useful as an id eeprom.
> 
> Lets assume that we can however still somehow differ the 2 revisions,
> then try to imagine how many different ways there are to differ
> between 2 board revisions if there is no easy way to do so,
> some crazy examples:
> -The 2nd revision has an external loopback on unused audio out / in
> pins for testing purposes, we could play + record sound and do
> a (rough) waveform match to see if the loopback is present
> -On the 2nd revision a pin from a pin compatible part which
> allows putting it in fully compatible mode, or allow new features
> mode, is now hooked up to a gpio instead of hardwired to compatible
> mode, we could change the device to new features mode and try
> to read/modify/write some register bit on the chip which is only
> writable in this mode
> -Etc.
> 
> Now try to design a way to express this in dt and we're back to
> needing a turing complete language (with a library for accessing
> various busses) again.
> 

No, not turing complete. This is going to require a little bit more
digging up but I think we can handle this with the method I described.

> Regards,
> 
> Hans

Regards

? Pantelis

P.S. Damn too much content to read.
