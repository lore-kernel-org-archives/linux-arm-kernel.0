From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 May 2015 23:24:19 +0200
Subject: [linux-sunxi] Re: [RFC 7/7] ARM: dts: sun9i: Add secure SRAM
 node used for MCPM SMP hotplug
In-Reply-To: <CAGb2v67+F_cnjHXgGwbewPODG=mLMPGaZCzvvLfXL=A3huceew@mail.gmail.com>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431583811-25780-8-git-send-email-wens@csie.org>
 <20150520100831.GE4004@lukather>
 <CAGb2v67+F_cnjHXgGwbewPODG=mLMPGaZCzvvLfXL=A3huceew@mail.gmail.com>
Message-ID: <20150525212419.GO8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 24, 2015 at 11:55:22PM +0800, Chen-Yu Tsai wrote:
> On Wed, May 20, 2015 at 6:08 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, May 14, 2015 at 02:10:11PM +0800, Chen-Yu Tsai wrote:
> >> The A80 stores some magic flags in a portion of the secure SRAM. The
> >> BROM jumps directly to the software entry point set by the SMP code
> >> if the flags are set. This is required for CPU0 hotplugging.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun9i-a80.dtsi | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> >> index 1507bd2a88f0..0695215634d4 100644
> >> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> >> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> >> @@ -366,6 +366,26 @@
> >>                */
> >>               ranges = <0 0 0 0x20000000>;
> >>
> >> +             sram_b: sram at 00020000 {
> >> +                     /* 256 KiB secure SRAM at 0x20000 */
> >> +                     compatible = "mmio-sram";
> >> +                     reg = <0x00020000 0x40000>;
> >> +
> >
> > We should probably add a property to that SRAM to tell the driver not
> > to access it if we're not booted in secure mode.
> 
> (CC-ing Heiko...)
> 
> That kind of puts architecture (ARM) dependent code into a platform
> driver. Furthermore, AFAIK there isn't a safe way to check if we're
> in secure mode or not. Checking SCR raises an undefined instruction
> exception in non-secure mode. Can the kernel handle that? I really
> don't understand this bit well.

That's a very good question. I'm pretty sure the kernel can know that,
since it actually prints the execution mode, and must be able to know
whether it can use the virtualization extensions or not I assume.

> > Otherwise, bad things might happen.
> 
> The kernel (or rather the bootloader) boots in secure mode by default,
> and we don't have any bootloader support to boot into non-secure mode
> ATM.

That's not really true. We do have some U-Boot patches, and U-Boot
might very well be setup to boot into HYP, even though it doesn't do
anything else.

And even so, the fact that we have no implementation yet doesn't mean
that we won't have one in a few month. So just sweeping it under the
carpet doesn't seem to be a very good solution.

> Couldn't we have the bootloader mark the SRAM as disabled when
> booting into non-secure when we add that support?

It actually changes the kernel requirements to be able to
boot. Changing that is not an option, especially since it's something
that: 1) isn't dynamic in any way, 2) will possibly break the kernel
if not done, 3) require synchronisation between the bootloader and the
kernel when a new secure SRAM is added to the DT, and require an
upgrade of the bootloader, 4) we might not be able to replace the
bootloader in the first place.

All of these issues make it look like a rather bad solution :/

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150525/4c32b379/attachment.sig>
