From: Dongsheng.Wang@freescale.com (Dongsheng.Wang at freescale.com)
Date: Tue, 21 Apr 2015 05:18:52 +0000
Subject: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for FTM0
 be used as alarm timer.
In-Reply-To: <20150401132400.GF11403@leverpostej>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
 <1427888858-29636-5-git-send-email-bhupesh.sharma@freescale.com>
 <20150401132400.GF11403@leverpostej>
Message-ID: <BN1PR03MB1881AD322072E34DAC380259DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Wednesday, April 01, 2015 9:24 PM
> To: Sharma Bhupesh-B45370
> Cc: arnd at arndb.de; linux-arm-kernel at lists.infradead.org; Marc Zyngier;
> bhupesh.linux at gmail.com; Catalin Marinas; Yoder Stuart-B08248; olof at lixom.net;
> Will Deacon; Wang Dongsheng-B40534
> Subject: Re: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for FTM0
> be used as alarm timer.
> 
> On Wed, Apr 01, 2015 at 12:47:34PM +0100, Bhupesh Sharma wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Only FTM0 can be used as an alarm timer, so add a "fsl,ftm-alarm"
> > compatible string to describe FTM0 alarm mode.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > Reviewed-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > ---
> >  .../devicetree/bindings/timer/fsl,ftm-timer.txt    |   46 ++++++++++++++-----
> -
> >  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> Shouldn't there be a corresponding driver update?
> 
> There wasn't one in this series.
> 

Hi Bhupesh, would you paste the driver link to here? Thanks very much.

> >
> > diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > index aa8c402..a372ed7 100644
> > --- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > @@ -2,12 +2,18 @@ Freescale FlexTimer Module (FTM) Timer
> >
> >  Required properties:
> >
> > -- compatible : should be "fsl,ftm-timer"
> > +- compatible : should be "fsl,ftm-timer" & "fsl,ftm-alarm".
> > +  (a) "fsl,ftm-timer", for FlexTimer compatible as normal timer.
> > +  (b) "fsl,ftm-alarm", for FlexTimer compatible when FTM0 as an ALARM timer.
> 
> 
> Lets not be redundant here. This would be better as:
> 
> - compatible: should contain one of:
>   * "fsl,ftm-timer" for a FlexTimer usable as a normal timer.
>   * "fsl,ftm-alarm" for a FlexTimer usable as an ALARM timer.
> 

Looks better, thanks.

> I don't think FTM0 is useful to mention here; it sounds like that's just the
> name of an instance on a particular design.
> 
> What exactly is the difference between a "normal" timer and an "alarm"
> timer?
>

Only FTM0 can be used as alarm timer.
 
> > +
> >  - reg : Specifies base physical address and size of the register sets for the
> >    clock event device and clock source device.
> > +
> >  - interrupts : Should be the clock event device interrupt.
> > +
> >  - clocks : The clocks provided by the SoC to drive the timer, must contain an
> >    entry for each entry in clock-names.
> > +
> >  - clock-names : Must include the following entries:
> >    o "ftm-evt"
> >    o "ftm-src"
> > @@ -16,16 +22,28 @@ Required properties:
> >  - big-endian: One boolean property, the big endian mode will be in use if it
> is
> >    present, or the little endian mode will be in use for all the device
> registers.
> >
> > -Example:
> > -ftm: ftm at 400b8000 {
> > -	compatible = "fsl,ftm-timer";
> > -	reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
> > -	interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
> > -	clock-names = "ftm-evt", "ftm-src",
> > -		"ftm-evt-counter-en", "ftm-src-counter-en";
> > -	clocks = <&clks VF610_CLK_FTM2>,
> > -		<&clks VF610_CLK_FTM3>,
> > -		<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
> > -		<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
> > -	big-endian;
> > -};
> > +Example 1: In this example, The FlexTimer module (FTM) is a two-to-eight,
> > +	   channel timer that supports input capture, output compare, and
> > +	   the generation of PWM signals to control electric motor and power
> > +	   management applications.
> > +
> > +	ftm: ftm at 400b8000 {
> > +		compatible = "fsl,ftm-timer";
> > +		reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
> > +		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
> > +		clock-names = "ftm-evt", "ftm-src",
> > +			"ftm-evt-counter-en", "ftm-src-counter-en";
> > +		clocks = <&clks VF610_CLK_FTM2>,
> > +			<&clks VF610_CLK_FTM3>,
> > +			<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
> > +			<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
> > +		big-endian;
> > +	};
> > +
> > +Example 2: In this example, FTM0 only be used as an alarm timer.
> 
> Do you mean that FTM0 is the only instance usable as an alarm timer, or that the
> FTM0 instance can only be used as an alarm timer?
> 

Ditto.

> > +
> > +	ftm0: ftm0 at 2800000 {
> > +		compatible = "fsl,ftm-alarm";
> > +		reg = <0x0 0x2800000 0x0 0x10000>;
> > +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> 
> Missing properties?
> 

The FTM0 alarm timer only need "compatible", "reg" and "interrupts" properties.
I miss something about the properties?

Regards,
-Dongsheng
