From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Oct 2016 17:13:36 +0200
Subject: [RFC PATCH 0/5] Add an overlay manager to handle board capes
In-Reply-To: <CAL_JsqL9yWBj0yYE54XGi87YPGugGAACzr=CuW6dk5kk3EuyCA@mail.gmail.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <CAL_JsqL9yWBj0yYE54XGi87YPGugGAACzr=CuW6dk5kk3EuyCA@mail.gmail.com>
Message-ID: <4ca9db09-e52c-11ec-133b-8f193b9b7174@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-10-16 15:41, Rob Herring wrote:
> Please Cc the maintainers of drivers/of/.
>
> + Frank R, Hans, Dmitry S
>
> On Wed, Oct 26, 2016 at 9:57 AM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
>> Hi all,
>>
>> Many boards now come with dips and compatible capes; among others the
>> C.H.I.P, or Beaglebones. All these boards have a kernel implementing an
>> out-of-tree "cape manager" which is used to detected capes, retrieve
>> their description and apply a corresponding overlay. This series is an
>> attempt to start a discussion, with an implementation of such a manager
>> which is somehow generic (i.e. formats or cape detectors can be added).
>> Other use cases could make use of this manager to dynamically load dt
>> overlays based on some input / hw presence.
>
> I'd like to see an input source be the kernel command line and/or a DT
> chosen property. Another overlay manager was proposed not to long
> ago[1] as well. There's also the Allwinner tablet use case from Hans
> where i2c devices are probed and detected. That's not using overlays
> currently, but maybe could.

Actually I'm currently thinking in a different direction, which I
think will be good for the boards where some ICs are frequently
replaced by 2nd (and 3th and 4th) sources, rather then that we're
dealing with an extension connector with capes / daughter boards.

Although there is some overlap I'm starting to think that we need to
treat these 2 cases differently. Let me quickly copy and paste
the basic idea I've for the 2nd source touchscreen / accelerometer
chip case:

"""
The kernel actually already has a detect() method in struct i2c_driver,
we could use that (we would need to implement it in drivers which do not
have it yet). Note on second thought it seems it may be better to use
probe() for this, see below.

Then we could have something like this in dt:

&i2c0 {
     touchscreen1: gsl1680 at 40 {
         reg = <0x40>;
         compatible = "silead,gsl1680";
         enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
         status = "disabled";
     };

     touchscreen2: ektf2127 at 15 {
         reg = <0x15>;
         compatible = "elan,ektf2127";
         enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
         status = "disabled";
     };

     i2c-probe-stop-at-first-match-0 = <&touchscreen1>, <&touchscreen2>;
     i2c-probe-stop-at-first-match-1 = <&accelerometer1>, <&accelerometer2>;
}

Which would make the i2c subsys call detect (*) on each device, until
a device is found. Likewise we could have a "i2c-probe-all" property
which also walks a list of phandles but does not stop on the first
match.

...

*) Yes this sounds Linux specific, but it really is just "execute to-be-probed
device compatible specific detection method"
"""

This does not 100% solve all q8 issues (see the "Add Allwinner Q8 tablets
hardware manager" thread), but does solve quite a bit of the use-case
and this matches what many vendor os-images (typically android) are
actually doing for these kind of boards.

As for the bits this does not solve, those are mostly board specific details
which cannot be probed at all, and on x86 are typically solved in the device
driver by doing a dmi check to identify the board and then apply a board
specific workaround in the driver.

I've come to believe that we should similarly delegate dealing this to device
drivers in the devicetree case. Note that dt should still of course fully
describe the hardware for normal hardware, the driver would just need to care
about weird board quirks in certain exceptions.

A more interesting problem here is that dt does not have something like
DMI, there is the machine compatible, but that typically does not contain
board revision info (where as DMI often does). I believe that this is
actually something which should be fixed at the bootloader level
have it prepend a new machine compatible which contains revision info.

Hmm, if we make the bootloader prepend a new machine compatible which contains
revision info, we could then trigger quirks on this and in some cases avoid
the need for dealing with board quirks in the driver ...

Note this is all very specific to dealing with board (revision) variants,
for add-ons having the bootloader add info to the machine compatible does
not seem the right solution.

Regards,

Hans




>
> Another thing to consider is different sources of overlays. Besides in
> the filesystem, overlays could be built into the kernel (already
> supported), embedded in the dtb (as the other overlay mgr did) or we
> could extend FDT format to append them.
>
>> The proposed design is a library which can be used by detector drivers
>> to parse headers and load the corresponding overlay. Helpers are
>> provided for this purpose. The whole thing is divided into 3 entities:
>>
>> - The parser which is project-specific (to allow supporting headers
>>   already into the wild). It registers a function parsing an header's
>>   data and filling one or more strings which will be used to find
>>   matching dtbo on the fs.
>>
>> - The overlay manager helpers allowing to parse a header to retrieve
>>   the previously mentioned strings and to load a compatible overlay.
>>
>> - The detectors which are used to detect capes and get their description
>>   (to be parsed).
>
> What about things like power has to be turned on first to detect
> boards and read their ID? I think this needs to be tied into the
> driver model. Though, don't go sticking cape mgr nodes into DT. Maybe
> a driver gets bound to a connector node, but we've got to sort out
> connector bindings first.
>
>> An example of parser and detector is given, compatible with what's done
>> for the C.H.I.P. As the w1 framework is really bad (and we should
>> probably do something about that) the detector code is far from being
>> perfect; but that's not related to what we try to achieve here.
>>
>> The actual implementation has a limitation: the detectors cannot be
>> built-in the kernel image as they would likely detect capes at boot time
>> but will fail to get their corresponding dt overlays as the fs isn't
>> mounted yet. The only case this can work is when dt overlays are
>> built-in firmwares. This isn't an issue for the C.H.I.P. use case right
>> now. There was a discussion about making an helper to wait for the
>> rootfs to be mount but the answer was "this is the driver's problem".
>
> I thought there are firmware loading calls that will wait. I think
> this all needs to work asynchronously both for firmware loading and
> because w1 is really slow.
>
>> I'd like to get comments, specifically from people using custom cape
>> managers, to see if this could fill their needs (with I guess some
>> modifications).
>
> Having 2 would certainly give a better sense this is generic.
>
> Rob
>
> [1] https://patchwork.ozlabs.org/patch/667805/
>
