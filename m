From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 23 Nov 2015 12:59:53 +0800
Subject: [PATCH RESEND 1/8] arm: dts: berlin2q: add watchdog nodes
In-Reply-To: <564F8062.8070609@gmail.com>
References: <1447672194-483-1-git-send-email-jszhang@marvell.com>
 <1447672194-483-2-git-send-email-jszhang@marvell.com>
 <564E3549.2050700@gmail.com>	<20151120113414.1aa1e48e@xhacker>
 <564F8062.8070609@gmail.com>
Message-ID: <20151123125953.5c30a0ef@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015 21:19:46 +0100
Sebastian Hesselbarth wrote:

> On 20.11.2015 04:34, Jisheng Zhang wrote:
> > On Thu, 19 Nov 2015 21:47:05 +0100
> > Sebastian Hesselbarth wrote:  
> >> On 16.11.2015 12:09, Jisheng Zhang wrote:  
> >>> The Marvell Berlin BG2Q has 3 watchdogs which are compatible with the
> >>> snps,dw-wdt driver sit in the sysmgr domain. This patch adds the
> >>> corresponding device tree nodes.
> >>>
> >>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> >>> ---
> >>>  arch/arm/boot/dts/berlin2q.dtsi | 24 ++++++++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> >>> index a3ecde5..fac4315 100644
> >>> --- a/arch/arm/boot/dts/berlin2q.dtsi
> >>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> >>> @@ -483,6 +483,30 @@
> >>>  			ranges = <0 0xfc0000 0x10000>;
> >>>  			interrupt-parent = <&sic>;
> >>>  
> >>> +			wdt0: watchdog at 1000 {
> >>> +				compatible = "snps,dw-wdt";
> >>> +				reg = <0x1000 0x100>;
> >>> +				clocks = <&refclk>;
> >>> +				interrupts = <0>;
> >>> +				status = "disabled";    
> >>
> >> as the watchdogs are internal and cannot be clock gated
> >> at all, how about we remove the status = "disabled" and
> >> make them always available?  
> > 
> > there are two issues here:
> > 
> > 1. the dw-wdt can't support multiple variants now. I have rewrite the driver
> > with watchdog core supplied framework, but the patch isn't sent out and
> > may be need time to clean up and review.  
> 
> Ok.
> 
> > 2. not all dw-wdt devices are available and functional. This depends on
> > board design and configuration.  
> 
> I understand that "board design and configuration" may hinder the wdt
> to issue a hard reset. But all others are able to issue a soft reset
> or just an interrupt, right?
> 
> So, I still don't see why we should disable wdt nodes by default
> except for the driver issue above.
> 
> > So IMHO status=disabled and patch5-8 is necessary, what do you think?  
> 
> No. I'd agree to enable wdt0 by default and leave wdt[1,2] disabled
> because of the driver issue. Patches 5-8 only enable wdt0 anyway.

That's fine.

> 
> As soon as the driver issue is resolved, we enable all wdt nodes
> unconditionally.

I will submit patch for the wdt driver and hope it will be merged
in v4.5.

Thanks,
Jisheng

> 
> Sebastian
> 
> >> I have applied patches 1-4 with the status property removed.
> >> This also renders patches 5-8 useless.
> >>
> >> So, for now tentatively
> >>
> >> Appled to berlin/dt and berlin64/dt respectivly
> >>
> >> with status property removed.
> >>
> >> Sebastian
> >>  
> >   
> 
