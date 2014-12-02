From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Dec 2014 16:45:24 +0100
Subject: [PATCH 3/9] clk: sunxi: Add prcm mod0 clock driver
In-Reply-To: <54787A8A.6040209@redhat.com>
References: <20141126211318.GN25249@lukather> <5476E3A5.4000708@redhat.com>
 <CAGb2v652m0bCdPWFF4LWwjcrCJZvnLibFPw8xXJ3Q-Ge+_-p7g@mail.gmail.com>
 <5476F8AB.2000601@redhat.com> <20141127190509.GR25249@lukather>
 <54787A8A.6040209@redhat.com>
Message-ID: <20141202154524.GD30256@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 02:37:14PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/27/2014 08:05 PM, Maxime Ripard wrote:
> >Hi,
> >
> >On Thu, Nov 27, 2014 at 11:10:51AM +0100, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 11/27/2014 10:28 AM, Chen-Yu Tsai wrote:
> >>>Hi,
> >>>
> >>>On Thu, Nov 27, 2014 at 4:41 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >><snip>
> >>
> >>>>I notice that you've not responded to my proposal to simple make the clock
> >>>>node a child node of the clocks node in the dt, that should work nicely, and
> >>>>avoid the need for any kernel level changes to support it, I'm beginning to
> >>>>think that that is probably the best solution.
> >>>
> >>>Would that not cause an overlap of the io regions, and cause one of them
> >>>to fail? AFAIK the OF subsystem doesn't like overlapping resources.
> >>
> >>No the overlap check is done by the platform dev resource code, and of_clk_declare
> >>does not use that. So the overlap would be there, but not an issue (in theory
> >>I did not test this).
> >
> >An overlap is always an issue.
> >
> >>Thinking more about this, I believe that using the MFD framework for the prcm seems
> >>like a mistake to me. It gains us nothing, since we have no irq to de-multiplex or
> >>some such. We're not using MFD for the CMU, why use it for CMU2 (which the prcm
> >>effectively is) ?
> >
> >Because the PRCM is much more than that. It also handles the power
> >domains for example.
> 
> Ok, so thinking more about this, I'm still convinced that the MFD
> framework is only getting in the way here.

You still haven't said of what exactly it's getting in the way of.

> But I can see having things represented in devicetree properly, with
> the clocks, etc. as child nodes of the prcm being something which we
> want.

Clocks and reset are the only thing set so far, because we need
reference to them from the DT itself, nothing more.

We could very much have more devices instatiated from the MFD itself.

> So since all we are using the MFD for is to instantiate platform
> devices under the prcm nodes, and assign an io resource for the regs
> to them, why not simply make the prcm node itself a simple-bus.

No, this is really not a bus. It shouldn't be described at all as
such. It is a device, that has multiple functionnalities in the system
=> MFD. It really is that simple.

> This does everything the MFD prcm driver currently does, without
> actually needing a specific kernel driver, and as added bonus this
> will move the definition of the mfd function reg offsets out of the
> kernel and into the devicetree where they belong in the first place.

Which was nacked in the first place because such offsets are not
supposed to be in the DT.

Really, we have something that work here, there's no need to refactor
it.

> Please see the attached patches, I've tested this on sun6i, if we go
> this route we should make the same change on sun8i (I can make the
> change, but not test it).
> 
> Regards,
> 
> Hans

> From 6756574293a1f291a8dcc29427b27f32f83acb2d Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Fri, 28 Nov 2014 13:48:58 +0100
> Subject: [PATCH v2 1/2] ARM: dts: sun6i: Change prcm node into a simple-bus
> 
> The prcm node's purpose is to group the various prcm sub-devices together,
> it does not need any special handling beyond that, there is no need to
> handle shared resources like a shared (multiplexed) interrupt or a shared
> i2c bus.
> 
> As such there really is no need to have a separate compatible for it, using
> simple-bus for it works fine. This also allows us to specify the register
> offsets of the various child-devices directly into the dts, rather then having
> to specify them in the OS implementation, putting the register offsets where
> the belong.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 29e6438..4b8541f 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -846,11 +846,15 @@
>  		};
>  
>  		prcm at 01f01400 {
> -			compatible = "allwinner,sun6i-a31-prcm";
> +			compatible = "simple-bus";

And this breaks the SMP bringup code.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/8815facd/attachment.sig>
