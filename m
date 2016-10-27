From: phh@phh.me (Pierre-Hugues Husson)
Date: Thu, 27 Oct 2016 14:57:25 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <99dde1e0-26f0-cc7b-36bf-1181c47296f9@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <CAJ-oXjQbOkrkNToEXYmPUZOgYBGbxQREZ4NL4bMcZmG=KP2vQQ@mail.gmail.com>
 <99dde1e0-26f0-cc7b-36bf-1181c47296f9@redhat.com>
Message-ID: <CAJ-oXjTfRDvSKs9zZBxt1V2MR5C+XnsqfZBRTWwRrJXx-_7r=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-27 11:14 GMT+02:00 Hans de Goede <hdegoede@redhat.com>:
> In my experience with these cheap boards, there is a mix of auto-probing +
> device / revision specific os-image modifications. I keep coming back to
> the touchscreen controller firmware (but also the orientation), for the
> gsl1680 controller I need at least 2 different firmware files (per gsl1680
> revision) to make all q8 tablets I have working. This is simply not solved
> by the vendor android code, they just shove the right firmware into the
> os-image. Likewise for the touchscreen orientation (x-mirored, y-mirored,
> etc) too is just a hard-coded setting in the os-image.
Reading your patch, it looks like to handle the two different firmware
files, you're simply adding a command-line switch, there is no
detection involved.
Am I understanding correctly?
If this is the case, two things:
1. I'm not too sure having the user choose this via cmdline is the
right way. I think I'd rather have it set by userspace. (though that's
not a strong opinion).
Or if cmdline is being changed... how about having DTS (or just an
overlay on top of it) being changed instead?

2. This could still be declared by DTS. For instance, assuming your
i2c-probe-stop-at-first-match:
&i2c0 {
        touchscreen1: gsl1680 at 40 {
                reg = <0x40>;
                compatible = "silead,gsl1680";
                enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
                touchscreen-size = <1024 600>;
                touchscreen-fw = "gsl1680-a082-q8-700.fw";
                filter-names = "touchscreen_variant";
                filter-0 = "none", "gsl1680-a082-q8-700";
                id = <0xa0820000>;
                status = "disabled";
        };
        touchscreen2: gsl1680 at 40 {
                reg = <0x40>;
                compatible = "silead,gsl1680";
                enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
                touchscreen-size = <480 800>;
                touchscreen-fw = "gsl1680-a082-q8-a70.fw";
                filter-names = "touchscreen_variant";
                filter-0 = "gsl1680-a082-q8-a70";
                id = <0xa0820000>;
               status = "disabled";
        };
        touchscreen2: gsl1680 at 40 {
                reg = <0x40>;
                compatible = "silead,gsl1680";
                enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
                touchscreen-size = <960 640>;
                touchscreen-fw = "gsl1680-b482-q8-d702.fw";
                filter-names = "touchscreen_variant";
                filter-0 = "gsl1680-b482-q8-d702";
                id = <0xb4820000>;
               status = "disabled";
        };
        i2c-probe-stop-at-first-match = <&touchscreen1>,
<&touchscreen2>, <&touchscreen3>;
}

With "none" value being the value when the "touchscreen_variant"
option is not defined in cmdline.

Please note that I'm not too sure whether SILEAD_REG_ID represents an
OTP which can be changed by OEM, or if it's more of a hardware
revision. Depending on this, this would either fit into a id =
<0xa0820000> DTS line, or a compatible = "silead,gsl1680_a082",
"silead,gsl1680"; DTS line.

> Sofar I've only seen this with one type of touchscreen so an easy cop-out
> would be to add an "optional-vddio-supply" to the the bindings for the
> specific touchscreen use and put all the necessary logic in the driver.
>
> This does require propagating the learned need for the regulator
> from the drivers detect() callback to probe() or alternatively I'm
> thinking we should just use probe() instead of detect()to begin with,
> that will save a lot of duplication with things
> like code for enable gpio-s and regulators.
>
> So assuming we go for the cop-out option for 3. (I'm ok with that),
> this would be a pretty clean solution adding just the 2 new:
> i2c-probe-stop-at-first-match and i2c-probe-all properties to
> the i2c-bus bindings. One problem here is that we may want to have
> multiple i2c-probe-stop-at-first-match phandle lists on a single bus
> (e.g. try 3 touchscreens + 6 accelerometers on the same bus, stop at
> first touchscreen / first accelerometer), anyone have any ideas for
> that?
How about something like:

&i2c1 {
    touchscreen1....
    touchscreen2....
    touchscreen3....
    accelerometer1....
    accelerometer2....
    accelerometer3....
    accelerometer4....

    select-one {
       compatible = "i2c-select;
       group-names = "touchscreen", "accelerometer";
       group-0 = <&touchscreen1>, <&touchscreen2>, <&touchscreen3>;
       group-1 = <&accelerometer1>, <&accelerometer2>,
<&accelerometer3>, <&accelerometer4>;
    };
};

>> When it comes to detection, I've witnessed various things.
>> It can be kernel-side or bootloader-side "global setting" reading (like an
>> ADC/resistor value, or an OTP), it can be bootloader doing the
>> "brute-force", or it can be the kernel doing all the probes.
>>
>> For instance, as of today, on a Spreadtrum ODM tree, the bootloader will
>> detect the screen by testing all knowns screens, the screen-drivers declare
>> a get_id function, and the bootloader probes until the get_id matches the id
>> declared by the screen driver.
>> And then the bootloader tells the kernel, via cmdline, which screen is
>> actually there (but auto-detection is also coded in kernel).
>> Finally all possible sensors/touchscreen/camera are declared in DTS, and
>> probe will filter-out N/C ones in the kernel.
>>
>> Now the big difference between my experience and what Hans is trying to
>> do, is that I've always worked with devices with "safely" queriable IDs,
>> either on i2c or dsi. I've never encountered SPI. This makes probing
>> inherently more dangerous, but I believe the question roughly remains the
>> same.
>
>
> I'm dealing with i2c too, Mark mistakenly used SPI in his reply,
> which I think is what got you thinking I've SPI.
Right, so let's concentrate on reasonable bus-es first then. (I can
think of I2C and DSI)

> See above, I think that we can make this work by delegating the actual
> detection to the driver (so each compatible can have a different detect
> method / code).
> So with this we can remove a big part of drivers/misc/q8-hardwaremgr.c, but
> not all
> of it. We still need board specific code somewhere to deal with things like
> picking
> the right touchscreen firmware and touchscreen orientation. This is all
> somewhat
> gsl1680 specific.
> I actually have the same problem on x86 where the ACPI description of the
> device
> basically says: "There is a gsl1680 at this bus at this address" and does
> not say
> anything about firmware / orientation (again this is simply hardcoded
> in the os-image these devices ship with).
>
> For x86 my plan is to have an array of configs in the driver and select the
> right
> one based on DMI strings, which is in essence putting board specific info in
> the
> driver.
>
> I can imagine mirroring this for ARM, and have an array of configs in the
> driver
> there too (for cases where cannot simply hardcode everything in dt only) and
> have
> some board specific code (activated by of_machine_is_compatible()) to select
> the
> right config.
I do believe this can all be done in DTS, and at the moment, what
you're describing seem to happen often enough to be worth writing
generic code for.
But then, I can't really tell which makes the most sense between
source-based and devicetree-based.
I prefer doing it in device-tree, since it means that any OEM can have
his device supported by only providing DTB, and won't need to provide
kernel patches.

> 2) miscellaneous extra config on top of figuring out which ICs are
> connected,
> basically the kind of stuff many vendors simply hard-code in their device
> specific os-image. This one is much more difficult to deal with and I think
> we need to figure this out on a case by case basis. This will require board
> specific code (just like the kernel has tons of DMI string activated board
> specific code on x86) and what is the best code for this place to live will
> be a case by case thing too.

With things like mount-matrix devicetree property, the goal is to have
such informations in the DTS.
I'm not seeing every cases should be handled in DTS, but ATM I see no
good reason.
