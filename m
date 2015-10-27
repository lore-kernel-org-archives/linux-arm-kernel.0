From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 27 Oct 2015 18:25:04 +0000
Subject: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
In-Reply-To: <20151027163441.GK3091@leverpostej>
References: <1445650280-9966-1-git-send-email-German.Rivera@freescale.com>
 <20151027163441.GK3091@leverpostej>
Message-ID: <CY1PR0301MB07480A8EC25BB6987883AE5687220@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think that comment "Currently supported enable-method is psci v0.2" is a statement of
intent, not what is available currently.   And the only plan I am aware of is PSCI
with UEFI based firmware.

U-boot is a key firmware platform for us and has no PSCI implementation available.

So, we need this.  The device tree simply describes the hardware that is
there and that's what this patch exposes.

If down the road all firmware provides a PSCI based reset interface then
we will naturally use that.  But we need something in the meantime to
let us reboot the system.

Thanks,
Stuart

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, October 27, 2015 11:35 AM
> To: Rivera Jose-B46482
> Cc: robh+dt at kernel.org; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Sharma Bhupesh-B45370; Yoder Stuart-B08248; Li Yang-Leo-R58472
> Subject: Re: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
> 
> On Fri, Oct 23, 2015 at 08:31:20PM -0500, J. German Rivera wrote:
> > Added sys-reboot node to the FSL's LS2085A SoC DT to leverage
> > the ARM-generic reboot mechanism for this SoC. This mechanism
> > is enabled through CONFIG_POWER_RESET_SYSCON.
> 
> Per the comments in arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi, the
> platform has PSCI 0.2+, and therefore already has system reset
> functionality.
> 
> Given that, why is this necessary?
> 
> Thanks,
> Mark.
> 
> > Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-
> ls2085a.dtsi
> > index e281ceb..6f82163 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > @@ -131,6 +131,18 @@
> >  		interrupts = <1 9 0x4>;
> >  	};
> >
> > +	rst_ccsr: rstccsr at 1E60000 {
> > +	        compatible = "syscon";
> > +		reg = <0x0 0x1E60000 0x0 0x10000>;
> > +	};
> > +
> > +	reboot at 65024000 {
> > +		compatible ="syscon-reboot";
> > +		regmap = <&rst_ccsr>;
> > +		offset = <0x0>;
> > +		mask = <0x2>;
> > +	};
> > +
> >  	timer {
> >  		compatible = "arm,armv8-timer";
> >  		interrupts = <1 13 0x8>, /* Physical Secure PPI, active-low */
> > --
> > 2.3.3
> >
