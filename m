From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 13 Jan 2014 13:26:25 +0100
Subject: [PATCH 2/2] pwm: imx: support polarity inversion
In-Reply-To: <11504930.fjG2AZiQ4e@wuerfel>
References: <1389608988-10981-1-git-send-email-LW@KARO-electronics.de>
 <1389608988-10981-3-git-send-email-LW@KARO-electronics.de>
 <11504930.fjG2AZiQ4e@wuerfel>
Message-ID: <20140113132625.4409abfc@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Arnd Bergmann wrote:
> On Monday 13 January 2014 11:29:48 Lothar Wa?mann wrote:
> 
> > diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> > index 01c0499..e3647a8 100644
> > --- a/arch/arm/boot/dts/imx50.dtsi
> > +++ b/arch/arm/boot/dts/imx50.dtsi
> > @@ -273,7 +273,7 @@
> >  			};
> >  
> >  			pwm1: pwm at 53fb4000 {
> > -				#pwm-cells = <2>;
> > +				#pwm-cells = <3>;
> >  				compatible = "fsl,imx50-pwm", "fsl,imx27-pwm";
> >  				reg = <0x53fb4000 0x4000>;
> >  				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> ...
> > @@ -271,6 +293,13 @@ static int imx_pwm_probe(struct platform_device *pdev)
> >  		return PTR_ERR(imx->mmio_base);
> >  
> >  	data = of_id->data;
> > +	if (data->output_polarity) {
> > +		dev_info(&pdev->dev, "PWM supports inversion\n");
> > +		imx_pwm_ops.set_polarity = imx_pwm_set_polarity;
> > +		imx->chip.of_xlate = of_pwm_xlate_with_flags;
> > +		imx->chip.of_pwm_n_cells = 3;
> > +	}
> > +
> >  	imx->config = data->config;
> >  	imx->set_enable = data->set_enable;
> 
> This looks like you are breaking compatibility with the binding,
> which requires #pwm-cells to be <2>. You can extend the binding
> to allow both <2> and <3>, but then you have to not only document
> that change in the binding, but also ensure that the pwm driver
> is able to use either variant.
> 
Good point. I'll try to change the driver to cope with either binding,
so the changes to the dts files of the current users will not be
necessary.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
