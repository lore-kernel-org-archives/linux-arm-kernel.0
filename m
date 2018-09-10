From: ran.wang_1@nxp.com (Ran Wang)
Date: Mon, 10 Sep 2018 08:44:55 +0000
Subject: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
In-Reply-To: <c19f11e200258297dbe5a61392a4bbc1e937d7c3.camel@buserror.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
 <c19f11e200258297dbe5a61392a4bbc1e937d7c3.camel@buserror.net>
Message-ID: <AM5PR0402MB28655442E42632DDAF22B769F1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On 2018/9/8 4:23, Scott Wood wrote:
> 
> On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> > +Optional properties:
> > + - big-endian : Indicate RCPM registers is big-endian. A RCPM node
> > +   that doesn't have this property will be regarded as little-endian.
> 
> You've just broken all the existing powerpc device trees that are big-endian
> and have no big-endian property.

Yes, powerpc RCPM driver (arch/powerpc/sysdev/fsl_rcpm.c) will not refer
to big-endian. However, I think if Layerscape RCPM driver use different compatible
id (such as ' fsl,qoriq-rcpm-2.2'), it might be safe. Is that OK?

> > + - <property 'compatible' string of consumer device> : This string
> > +   is referred by RCPM driver to judge if the consumer (such as flex timer)
> > +   is able to be regards as wakeup source or not, such as
> > + 'fsl,ls1012a-
> > ftm'.
> > +   Further, this property will carry the bit mask info to control
> > +   coresponding wake up source.
> 
> What will you do if there are multiple instances of a device with the same
> compatible, and different wakeup bits?  

You got me! This is a problem in current version. Well, we have to decouple wake up
source IP and RCPM driver. That's why I add a plat_pm driver to prevent wake up IP
knowing any information of RCPM. So in current context, one idea come to me is to
redesign property ' fsl,ls1012a-ftm = <0x20000>;', change to 'fsl,ls1012a-ftm = <&ftm0 0x20000>;'
What do you say? And could you tell me which API I can use to check if that device's
name is ftm0 (for example we want to find a node ftm0: ftm at 29d000)?

>Plus, it's an awkward design in
> general, and you don't describe what the value actually means (bits in which
> register?). 

Yes, I admit my design looks ugly and not flexible and extensible enough. However, for above reason, 
do you have any good idea, please? :)

As to the register information, I can explain here in details (will add to commit
message of next version): There is a RCPM HW block which has register named IPPDEXPCR.
It controls whether prevent certain IP (such as timer, usb, etc) from entering low
power mode when system suspended. So it's necessary to program it if we want one
of those IP work as a wakeup source. However, different Layerscape SoCs have different bit vs.
IP mapping  layout. So I have to record this information in device tree and fetched by RCPM driver
directly.

Do I need to list all SoC's mapping information in this binding doc for reference?

>What was wrong with the existing binding?  

There was one version of RCPM patch which requiring property 'fsl,#rcpm-wakeup-cells' but was not
accepted by upstream finally. Now we will no need it any longer due to new design allow case of multiple
RCPM devices existing case.

>Alternatively, use the clock bindings.

Sorry I didn't get your point.

> > -
> > -Example:
> > -	lpuart0: serial at 2950000 {
> > -		compatible = "fsl,ls1021a-lpuart";
> > -		reg = <0x0 0x2950000 0x0 0x1000>;
> > -		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks = <&sysclk>;
> > -		clock-names = "ipg";
> > -		fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
> > +		big-endian;
> > +		fsl,ls1012a-ftm = <0x20000>;
> > +		fsl,pfe = <0xf0000020>;
> 
> fsl,pfe is not documented.

pfe patch is not upstream yet, will remove it.

Regards,
Ran

> -Scott
