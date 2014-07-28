From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 28 Jul 2014 11:06:54 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
Message-ID: <20140728100654.GC24078@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sun, Jul 27, 2014 at 03:34:48AM +0100, Olof Johansson wrote:
> On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > From: Graeme Gregory <graeme.gregory@linaro.org>
> >
> > Add documentation for the guidelines of how to use ACPI
> > on ARM64.
>
> As the most vocal participant against ACPI being adopted, I would have
> appreciated a cc on this patch set -- it's not like you were going for
> a minimal set of cc recipients already. It makes it seem like you're
> trying to sneak it past me for comments. Not cool. I know that's
> probably not your intent, but still.
>
> Some comments below. Overall the doc looks pretty good, but the
> details about _DSD and clocks are somewhat worrisome.
>
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  Documentation/arm64/arm-acpi.txt |  240 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 240 insertions(+)
> >  create mode 100644 Documentation/arm64/arm-acpi.txt
> >
> > diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
> > new file mode 100644
> > index 0000000..12cd550
> > --- /dev/null
> > +++ b/Documentation/arm64/arm-acpi.txt
> > @@ -0,0 +1,240 @@
> > +ACPI on ARMv8 Servers
> > +---------------------
> > +
> > +ACPI will be used for ARMv8 general purpose servers designed to follow
>
> "ACPI might be used"    or     "can be used"
>
> > +the SBSA specification (currently available to people with an ARM login at
> > +http://silver.arm.com)
> > +
> > +The implemented ACPI version is 5.1 + errata as released by the UEFI Forum,
> > +which is available at <http://www.uefi.org/acpi/specs>.
>
> The implemented version where? The kernel implements that version?
> Worth clarifying.
>
> > +If the machine does not meet these requirements then it is likely that Device
> > +Tree (DT) is more suitable for the hardware.
>
> This is should be a very clear statement that is currently vague
> w.r.t. which requirements are met or not, especially based on the
> sentence above.
>
> > +Relationship with Device Tree
> > +-----------------------------
> > +
> > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> > +exclusive with DT support at compile time.
> > +
> > +At boot time the kernel will only use one description method depending on
> > +parameters passed from the bootloader.
>
> Possibly overriden by kernel bootargs. And as debated for quite a
> while earlier this year, acpi should still default to off -- if a DT
> and ACPI are both passed in, DT should at this time be given priority.

Why? I really don't see the logic in doing that.

Currently the kernel can only boot using DT, so DT will be used even if
ACPI is present. In the presence of ACPI support in the kernel, ACPI
would be used on said systems.

>From the discussions at the last Linaro Connect, this was seen as
important for virtual machines which want to provide ACPI services to
guests while still being able to boot DT-only kernels. I'll leave it to
Grant, Rob, and Christoffer to cover that.

> (Where can I learn more about how the boot loaders currently handle
> this? Do some of them pass in both DT and ACPI on some platforms, for
> example?)

All will pass in some form of DT. If booted through UEFI, the DT will be
augmented with data about the UEFI memory map (and if no DT is provided,
a /chosen only DT will eb created by the EFI stub).

A kernel with ACPI support will query EFI for ACPI tables, and if found
use them.

> > +Regardless of whether DT or ACPI is used, the kernel must always be capable
> > +of booting with either scheme.
>
> It should always be possible to compile out ACPI. There will be plenty
> of platforms that will not implement it, so disabling CONFIG_ACPI
> needs to be possible.

A better description would be that the two must never be mutually
exclusive. It must always be possible to have a kernel which supports
both, and code must never assume the absence of the other.

At run time, the kernel will decide to use one for system description
and use that.

[...]

> > +Device Enumeration
> > +------------------
> > +
> > +Device descriptions in ACPI should use standard recognised ACPI interfaces.
> > +These are far simpler than the information provided via Device Tree. Drivers
> > +should take into account this simplicity and work with sensible defaults.
> > +
> > +On no account should a Device Tree attempt to be replicated in ASL using such
> > +constructs as Name(KEY0, "Value1") type constructs. Additional driver specific
> > +data should be passed in the appropriate _DSM (ACPI Section 9.14.1) method or
> > +_DSD (ACPI Section 6.2.5). This data should be rare and not OS specific.
>
> I see these two sentences as contradictory, given that the _DSD doc
> linked below contains examples that mirror over several properties,
> such as "linux,default-trigger" and other LED-specific properties.
> (section 2.4.2 in the below doc). "default-state" seems to come from
> DT too?

Urrgh. Those should never been placed in the ACPI spec. It's bad enough
in DT.

> Care to elaborate and explain what the intention here is? This could
> worst case turn into quite a mess.
>
> Given that ACPI can present completely different data based on what OS
> is running, it's quite common to indeed have OS specific data in
> there. How does that relate to this document and these practices?
>
> > +Common _DSD bindings should be submitted to ASWG to be included in the
> > +document :-
> > +
> > +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm
>
> So, for these that are a mirror of the device tree bindings, there
> needs to be a wording here around reviewing the DT binding first so we
> don't get diverging bindings.

We shouldn't work on the assumption that the two should be identical.
ACPI already has standard mechanisms for describing certain linkages
that are divergent from DT.

This really needs higher-level thought, and I'd hoped that things
wouldn't blindly be copied one way or the other.

[...]

> > +values before the kernel is executed. If a driver requires to know rates of
> > +clocks set by firmware then they can be passed to kernel using _DSD.
> > +
> > +example :-
> > +
> > +Device (CLK0) {
> > +       ...
> > +
> > +       Name (_DSD, Package() {
> > +               ToUUID("XXXXX"),
> > +               Package() {
> > +                       Package(2) {"#clock-cells", 0},
>
> Clock-cells? What do they mean here? Is this specified in the ACPI
> standards? I had to register to get access to it, and didn't feel like
> doing that right now. I guess it's not _all_ that open a spec. :(

Yeah, this is complete nonsense.

If people are going to blindly copy elements from DT into ACPI without
actually understanding them, then ACPI is clearly no better than DT.

[...]

> > +static int device_probe(stuct platform_device *pdev)
> > +{
> > +       ...
> > +       acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> > +       struct device_node node = pdev->dev.of_node;
> > +       ...
> > +
> > +       if (node)
> > +               ret = device_probe_dt(pdev);
> > +       else if (handle)
> > +               ret = device_probe_acpi(pdev);
> > +       else
> > +               /* other initialisation */
> > +               ...
> > +       /* Continue with any generic probe operations */
> > +       ...
> > +}
>
> This looks good to me, and it's also my preferred way of ACPI-enabling
> drivers. I guess we might discuss this at KS since it was a proposed
> topic there, and others will object. :)

This is almost precisely the form of probe I want to see (it would be
nicer IMO to have separate entry points for ACPI / DT / platform data
that can all call a common probe core, but this isn't too far off).

>
> > +
> > +DO keep the MODULE_DEVICE_TABLE entries together in the driver to make it clear
> > +the different names the driver is probed for, both from DT and from ACPI.
> > +
> > +module device tables :-
> > +
> > +static struct of_device_id virtio_mmio_match[] = {
> > +        { .compatible = "virtio,mmio", },
> > +        {},
> > +};
> > +MODULE_DEVICE_TABLE(of, virtio_mmio_match);
> > +
> > +static const struct acpi_device_id virtio_mmio_acpi_match[] = {
> > +        { "LNRO0005", },
> > +        { }
>
> No comma here, but a comma on DT. Probably make them equivalent for
> consistency (including space between the braces).

The comma on the DT form should probably be dropped. The NULL sentinel's
only job is to delimit the list, so it never makes sense to place
something after it.

Cheers,
Mark.
