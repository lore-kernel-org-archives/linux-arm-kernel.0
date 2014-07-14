From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 Jul 2014 08:58:35 +0100
Subject: [PATCH v3+1 5/5] ARM: DT: STi: STiH416: Add DT node for MiPHY365x
In-Reply-To: <53C0819E.4000202@cogentembedded.com>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <1404906074-31992-6-git-send-email-lee.jones@linaro.org>
 <20140711115406.GB2954@lee--X1>
 <53C0819E.4000202@cogentembedded.com>
Message-ID: <20140714075835.GJ2954@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Jul 2014, Sergei Shtylyov wrote:

> Hello.
> 
> On 07/11/2014 03:54 PM, Lee Jones wrote:
> 
> >The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> >devices. It has 2 ports which it can use for either; both SATA, both
> >PCIe or one of each in any configuration.
> 
> >Acked-by: Mark Rutland <mark.rutland@arm.com>
> >Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> >diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
> >index 4e2df66..c3c2ac6 100644
> >--- a/arch/arm/boot/dts/stih416-b2020.dts
> >+++ b/arch/arm/boot/dts/stih416-b2020.dts
> >@@ -12,4 +12,16 @@
> >  / {
> >  	model = "STiH416 B2020";
> >  	compatible = "st,stih416-b2020", "st,stih416";
> >+
> >+	soc {
> >+		miphy365x_phy: miphy365x at fe382000 {
> >+			phy_port0: port at fe382000 {
> 
>    I don't understand why are you creating the duplicate labels;
> doesn't 'dtc' complain about them?

I've never seen dtc complain about this:

  DTC     arch/arm/boot/dts/dra72-evm.dtb
  DTC     arch/arm/boot/dts/stih407-b2120.dtb
  DTC     arch/arm/boot/dts/stih415-b2000.dtb
  DTC     arch/arm/boot/dts/stih415-b2020.dtb
  DTC     arch/arm/boot/dts/stih416-b2000.dtb
  DTC     arch/arm/boot/dts/stih416-b2020.dtb
  DTC     arch/arm/boot/dts/stih416-b2020e.dtb
  DTC     arch/arm/boot/dts/armada-375-db.dtb

Probably because they're not actually 'duplicate' per say.  Rather
they are the same node split into different files.  I can remove the
labels if required though.

> You could instead refer to them
> as:
> 
> &miphy365x_phy {
> };

I dislike this formatting.  I find it convolutes the hierarchical
structure and makes DTS (and some DTSI) files hard to read i.e hides
parenthood etc.

[...]

> >+		miphy365x_phy: miphy365x at fe382000 {
> 
>    The ePAPR standard [1] says:
> 
> The name of a node should be somewhat generic, reflecting the
> function of the device and not its precise programming model.

Good point.  Will change to 'phy'.

> >+			compatible      = "st,miphy365x-phy";
> >+			st,syscfg  	= <&syscfg_rear>;
> >+			#address-cells	= <1>;
> >+			#size-cells	= <1>;
> >+			ranges;
> >+
> >+			phy_port0: port at fe382000 {
> >+				#phy-cells = <1>;
> 
>    If these are PHY devices, they should be named "phy", not "port".

Then what do you call the parent node?

I see it as:

phy {
        port {
        };
};

Or 

phy {
    channel {
    };
};

What does Kishon think?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
