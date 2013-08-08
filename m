From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 8 Aug 2013 15:32:00 -0500
Subject: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <5203FC1A.3090903@wwwdotorg.org>
References: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
 <5203FC1A.3090903@wwwdotorg.org>
Message-ID: <1375993920.22740.9.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-08 at 14:14 -0600, Stephen Warren wrote:
> On 08/05/2013 02:43 PM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> > Add "syscon" to the "altr,sys-mgr" binding.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> > new file mode 100644
> > index 0000000..dc14922
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> > @@ -0,0 +1,48 @@
> > +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> > +  Storage Host Controller
> > +
> > +Required Properties:
> > +
> > +* compatible: should be
> > +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> > +	  specific extensions.
> > +
> > +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> > +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> > +  value is fixed at 3, which means parent_clock/4.
> 
> This feels like something that should be represented using the common
> clock API; a driver should query the rate of its input clock, and then
> calculate the MMC block's internal divider based on that (perhaps also
> call clk_set_rate() on the input clock?).

This means a change to the dw_mmc driver, which I can look into for the
next round? I have promised Pawel to consolidate the bindings for both
exynos and socfpga in the next round already. I will also look into
using the common clock API for the MMC as well. 

This patch is the only thing that is preventing from SD/MMC working for
SOCFPGA in the mainline, can I get your Ack if I look into doing this
for 3.13 for both the exynos and socfpga driver, and address your latter
comments?

> 
> > +Example:
> > +	dwmmc0 at ff704000 {
> > +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> > +		reg = <0xff704000 0x1000>;
> > +		interrupts = <0 139 4>;
> 
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		num-slots = <1>;
> > +		supports-highspeed;
> > +		fifo-depth = <0x400>;
> 
> Those properties aren't defined in this document anywhere. I guess this
> binding is meant to "inherit" from that described in
> "synopsis-dw-mshc.txt"? If so, that should be stated explicitly.

Yes, will state in v3.
> 
> A similar comment applies to the clocks properties in the *.dtsi changes.
> 
> > +		altr,dw-mshc-ciu-div = <3>;
> > +      		altr,dw-mshc-sdr-timing = <0 3>;
> 
> Indentation issue.

Will fix..

Dinh
> 
> 
