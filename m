From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Oct 2016 11:14:05 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <CAJ-oXjQbOkrkNToEXYmPUZOgYBGbxQREZ4NL4bMcZmG=KP2vQQ@mail.gmail.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <CAJ-oXjQbOkrkNToEXYmPUZOgYBGbxQREZ4NL4bMcZmG=KP2vQQ@mail.gmail.com>
Message-ID: <99dde1e0-26f0-cc7b-36bf-1181c47296f9@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-10-16 01:45, Pierre-Hugues Husson wrote:
> Hi,
>
> 2016-10-26 13:46 GMT+02:00 Hans de Goede <hdegoede at redhat.com <mailto:hdegoede@redhat.com>>:
>
>> And as I tried to explain before, for this specific use-case describing
>> all this board specific knowledge in a generic manner in dt is simply
>> impossible, unless we add a turing complete language to dt aka aml.
>
>
> You keep saying this is a "specific use-case", but I don't agree.
> Most of cheap phone and tablets SoC manufacturer's Linux variant that I know of have (rather stupid) auto-detection methods.

True.

> Not every phone manufacturer use it, because some have proper and constant supply chain, but still, that's not always the case.
> For instance you might look at this dts: https://github.com/Dee-UK/RK3288_Lollipop_Kernel/commit/9e056a10b0a773d285e8d2ae819e7c2451816492#diff-b25e1abc92522c85e9ef28704bf9284aR410
> This DTS is meant, like what you do, to be compatible with as many devices as possible at once.
> So it declares 4 different PMICs (and no they will never all be there at the same time), and two different accelerometers, 3 audio codecs, and two touchscreens.
> Or you can look at CodeAurora (Qualcomm public opensource tree) DTSs and see that a standard DTS support at least three different panels ( see https://github.com/omnirom/android_kernel_oppo_msm8974/blob/27080b724f4cf281d598e7830abc5fc1292b5803/arch/arm/boot/dts/msm8974-mtp.dtsi#L15 )
> And that's the fairly clean examples. Some SoC kernels are still using good old platform_data detection methods.
>
> Thus I believe that having a board-specific driver is not a good thing, because we would get many of those.

In my experience with these cheap boards, there is a mix of auto-probing +
device / revision specific os-image modifications. I keep coming back to
the touchscreen controller firmware (but also the orientation), for the
gsl1680 controller I need at least 2 different firmware files (per gsl1680
revision) to make all q8 tablets I have working. This is simply not solved
by the vendor android code, they just shove the right firmware into the
os-image. Likewise for the touchscreen orientation (x-mirored, y-mirored,
etc) too is just a hard-coded setting in the os-image.

Thinking more about this, we may be able to come up with a generic way to
deal with i2c device detection, just like many vendor os-images are doing.

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

	i2c-probe-stop-at-first-match = <&touchscreen1>, <&touchscreen2>;
}

Which would make the i2c subsys call detect (*) on each device, until
a device is found. Likewise we could have a "i2c-probe-all" property
which also walks a list of phandles but does not stop on the first
match.

Mark would something like this scheme work for you ?

Note that things are not this simple though, there are multiple challenges
with this approach:

1) pinctrl, even the detect() method of the driver may need to use
e.g. some gpios so we would need to activate pinctrl as normally the
kernel device core would do this before calling probe(). This is solvable,
but I wonder if we need to mention anything about this in the bindings
docs ? Note this would be solved by just instantiating the client / device
and then try probe().

2) Note the enable-gpios, those will need to be handled in the detect()
method, but this requires a device to be instantiated to call devm_get_...
on, likewise for other resources.

Alternatively the probe code could know about this (as part of the
i2c-probe-stop-at-first-match binding) and enable it before probing ?

3) Optional regulators, I've one q8 tablet where the touchscreen is
powered by a separate regulator, currently my hardware-mgr simply
first tries to probe all possible models with the regulator disabled
(and stops at -ETIMEDOUT which means the i2c bus is stuck and further
  probing without enabling the regulator is useless).

How do we deal with this? This is a tricky one do we do this in
the code which walks over the i2c-probe-stop-at-first-match list,
or do we punt this to the driver?

Sofar I've only seen this with one type of touchscreen so an easy cop-out
would be to add an "optional-vddio-supply" to the the bindings for the
specific touchscreen use and put all the necessary logic in the driver.

This does require propagating the learned need for the regulator
from the drivers detect() callback to probe() or alternatively I'm
thinking we should just use probe() instead of detect()to begin with,
that will save a lot of duplication with things
like code for enable gpio-s and regulators.

So assuming we go for the cop-out option for 3. (I'm ok with that),
this would be a pretty clean solution adding just the 2 new:
i2c-probe-stop-at-first-match and i2c-probe-all properties to
the i2c-bus bindings. One problem here is that we may want to have
multiple i2c-probe-stop-at-first-match phandle lists on a single bus
(e.g. try 3 touchscreens + 6 accelerometers on the same bus, stop at
first touchscreen / first accelerometer), anyone have any ideas for
that?


*) Yes this sounds Linux specific, but it really is just "execute to-be-probed
device compatible specific detection method"


> When it comes to detection, I've witnessed various things.
> It can be kernel-side or bootloader-side "global setting" reading (like an ADC/resistor value, or an OTP), it can be bootloader doing the "brute-force", or it can be the kernel doing all the probes.
>
> For instance, as of today, on a Spreadtrum ODM tree, the bootloader will detect the screen by testing all knowns screens, the screen-drivers declare a get_id function, and the bootloader probes until the get_id matches the id declared by the screen driver.
> And then the bootloader tells the kernel, via cmdline, which screen is actually there (but auto-detection is also coded in kernel).
> Finally all possible sensors/touchscreen/camera are declared in DTS, and probe will filter-out N/C ones in the kernel.
>
> Now the big difference between my experience and what Hans is trying to do, is that I've always worked with devices with "safely" queriable IDs, either on i2c or dsi. I've never encountered SPI. This makes probing inherently more dangerous, but I believe the question roughly remains the same.

I'm dealing with i2c too, Mark mistakenly used SPI in his reply,
which I think is what got you thinking I've SPI.

> I understand Mark's will of taking care of this "earlier" (either bootloader or a later kernel-loader (pxa-impedance-matcher)), but I feel like this is only giving the problem to someone else.

Big ack to this, moving this to the bootloader is not solving the
problem, it just moves the problem elsewhere.

> I think that those auto-detection methods should be declared in a device-tree, though as Hans noted, this might end to be a turing-complete language.

See above, I think that we can make this work by delegating the actual
detection to the driver (so each compatible can have a different detect method / code).

So with this we can remove a big part of drivers/misc/q8-hardwaremgr.c, but not all
of it. We still need board specific code somewhere to deal with things like picking
the right touchscreen firmware and touchscreen orientation. This is all somewhat
gsl1680 specific.

I actually have the same problem on x86 where the ACPI description of the device
basically says: "There is a gsl1680 at this bus at this address" and does not say
anything about firmware / orientation (again this is simply hardcoded
in the os-image these devices ship with).

For x86 my plan is to have an array of configs in the driver and select the right
one based on DMI strings, which is in essence putting board specific info in the
driver.

I can imagine mirroring this for ARM, and have an array of configs in the driver
there too (for cases where cannot simply hardcode everything in dt only) and have
some board specific code (activated by of_machine_is_compatible()) to select the
right config.

> In my experience, I have never encountered a device requiring more than ordered probes, but backward compatibility was expected. (i.e. if IDs couldn't help distinguish two devices, the manufacturer would add another way to identify)
>
> As to whether this is bootloader's job or kernel's job, I don't have a really strong opinion.
> On one side, the kernel has all the drivers and probe functions, this would need little work to make this work.
> On the other side, if the "rules" are something like "read bus XXX, address YYY, expect ZZZ", the bootloader can handle it as well. But I don't think it is a good idea to have the bootloader know all the gsensor/screen/camera/... drivers (even if they are partial drivers dedicated to detection only)

Ack I to really believe this belongs in the kernel. Thank you for your reply,
it has made me realized that there are 2 problems here:

1) auto-detect of i2c-devices from a fixed list of i2c devices the board may
have, for this we really need 2 bits: a) generic mechanism to describe this,
call the driver detect methods b) hardware (compatible) specific detection
routines. b) really belongs in the driver, and since things like sensor
drivers (another good example btw) do not belong in the bootloader we
really need this bit in the kernel.

If we can get some consensus on this I'm willing to work on this
(as time allows, this is a spare time project). At least up to feature parity
with my current hard-coded q8-hardwaremgr.c, which in hind-sight indeed is
ugly as the detect code really belongs in the driver (I've been copy and
pasting about 10 - 30 lines from each driver into q8-hardwaremgr.c).

2) miscellaneous extra config on top of figuring out which ICs are connected,
basically the kind of stuff many vendors simply hard-code in their device
specific os-image. This one is much more difficult to deal with and I think
we need to figure this out on a case by case basis. This will require board
specific code (just like the kernel has tons of DMI string activated board
specific code on x86) and what is the best code for this place to live will
be a case by case thing too.

Regards,

Hans
