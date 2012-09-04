From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 04 Sep 2012 14:05:20 +0100
Subject: [PATCH 10/11] ARM: vexpress: Add config bus components and
 clocks to DTs
In-Reply-To: <5045FAEC.6030906@gmail.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-11-git-send-email-pawel.moll@arm.com>
 <5045FAEC.6030906@gmail.com>
Message-ID: <1346763920.2605.81.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-04 at 13:58 +0100, Rob Herring wrote:
> > -			sysctl at 020000 {
> > +			v2m_sysctl: sysctl at 020000 {
> >  				compatible = "arm,sp810", "arm,primecell";
> >  				reg = <0x020000 0x1000>;
> > +				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_osc_clk0>;
> > +				clock-names = "refclk", "timclk", "apb_pclk";
> 
> See Documentation/devicetree/bindings/arm/primecell.txt
> 
> apb_pclk should be first in the list.

Hm. Why, if you don't mind me asking? The amba_get_enable_pclk()
explicitly asks for "apb_pclk" id:

struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");

Now, let's have a look at MMCI:

                        mmci at 050000 {
                                compatible = "arm,pl180", "arm,primecell";
                                reg = <0x050000 0x1000>;
                                interrupts = <9 10>;
+                               cd-gpios = <&v2m_sysreg 0 0>;
+                               wp-gpios = <&v2m_sysreg 1 0>;
+                               max-frequency = <12000000>;
+                               vmmc-supply = <&v2m_fixed_3v3>;
+                               clocks = <&v2m_clk_24mhz>, <&v2m_osc_clk0>;
+                               clock-names = "mclk", "apb_pclk";
                        };

and mmci_probe() does:

        host->clk = clk_get(&dev->dev, NULL);
        if (IS_ERR(host->clk)) {
                ret = PTR_ERR(host->clk);
                host->clk = NULL;
                goto host_free;
        }       

Now, if I put "apb_pclk" first, before "mclk", the driver will get the
wrong clock.

Pawe?
