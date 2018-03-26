From: liwei213@huawei.com (liwei (CM))
Date: Mon, 26 Mar 2018 10:26:10 +0000
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2OCAyLzVdIGR0LWJpbmRpbmdzOiBz?=
 =?utf-8?Q?csi:_ufs:_add_document_for_hisi-ufs?=
In-Reply-To: <CAK8P3a3NdHLDf2vOMyZ1qcWNW1Jg5T47qR0qWhWEeDn+90S4ug@mail.gmail.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA584ED@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a3NdHLDf2vOMyZ1qcWNW1Jg5T47qR0qWhWEeDn+90S4ug@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA58798@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2018?3?26? 17:14
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept); Yaniv Gardi
??: Re: ??: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Fri, Mar 23, 2018 at 3:22 AM, liwei (CM) <liwei213@huawei.com> wrote:
>> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> new file mode 100644
>> index 000000000000..0d21b57496cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> @@ -0,0 +1,37 @@
>> +* Hisilicon Universal Flash Storage (UFS) Host Controller
>> +
>> +UFS nodes are defined to describe on-chip UFS hardware macro.
>> +Each UFS Host Controller should have its own node.
>> +
>> +Required properties:
>> +- compatible        : compatible list, contains one of the following -
>> +                                       "hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
>> +                                       host controller present on Hi36xx chipset.
>> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
>> +- interrupt-parent  : interrupt device
>> +- interrupts        : interrupt number
>> +- clocks               : List of phandle and clock specifier pairs
>> +- clock-names       : List of clock input name strings sorted in the same
>> +                                       order as the clocks property.
>> +"ref_clk", "phy_clk" is optional
>
> The clock names sound generic enough, should we have both in the generic binding?
>
> Do you mean that add a "phy_clk" to ufshcd-pltfrm 's bindings?
> At present, it seems that in the implementation of generic code, apart 
> from "ref_clk" may have special processing, other clk will not have special processing and simply parse and enable; Referring to ufs-qcom binding, I think "phy_clk" can be named "iface_clk", this "iface_clk" exists in ufshcd-pltfrm bindings;If so, "ref_clk", "iface_clk" are both in the generic binding,we will remove them here. Is that okay?

I'm looking at the generic binding again, and it seems we never quite managed to fix some minor problems with it. See below for a possible way to clarify it.

phy_clk is actually given to the phy. But as previously mentioned , we do not have a separate phy to configure ; The clks in the patch you give appear to be unsuitable for describing this .
Here we can't describe phy_clk in the node "ufsphy1: ufsphy at fc597000" like qcom. So can we put it here in our own binding like this?

>> +- resets            : reset node register, one reset the clk and the other reset the controller
>> +- reset-names       : describe reset node register
>
> This looks incomplete. What is the name of the reset line supposed to be?
> I'd also suggest you document it in the ufshcd binding instead.
>
> The "rst" corresponds to reset the whole UFS IP, and " arst " only reset the APB/AXI bus. Discussed with our soc colleagues that "arst" is assert by default and needs to deassert .
> But I think it may be difficult to add this to common code, or it may 
> not be necessary; Other manufacturers may not need to do this soc init because they probably already done in the bootloader phase. Even if they need to do it, it's probably different from us.
> We need to make sure that our ufs works even if not do soc init during the bootloader phase.

In the suggested patch below, I have documented one "rst" line that is used to reset the ufshcd device. The second reset line as I understand now is used in a rather nonstandard way and gets asserted only while setting up the additional registers for your glue logic, so that one seems better left documented in your own binding.

Yes, the second reset line is used in a rather nonstandard way , if rst will into the common document, ,I will left the second reset line documented in our own binding.

I've added a "jedec,ufshci-3.0" compatible string, which appears to be the latest version of the ufshci itself, and I've documented four clocks that are already used by the qualcomm variant of the platform device. Please have a look at the below, and see if we need additional changes or clarifications. With this, most of your binding can get folded into the common document, so you just need to explain the private compatible string, the larger register area, and the additional reset line.

      Arnd

commit a945e9bc823521253c9ff5a061f22a2aa7fd335e
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Mar 26 11:07:46 2018 +0200

    ufshcd: clarify some parts of the documentation

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index c39dfef76a18..bc90a7d8385b 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -4,8 +4,10 @@ UFSHC nodes are defined to describe on-chip UFS host controllers.
 Each UFS controller instance should have its own node.

 Required properties:
-- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
-                         also list one or more of the following:
+- compatible           : must contain "jedec,ufs-1.1", "jedec,ufs-2.0",
+                         or "jedec,ufshci-3.0", and may also list one
+                         or more of the following, as well as others
+                         specified in derived bindings:
                                          "qcom,msm8994-ufshc"
                                          "qcom,msm8996-ufshc"
                                          "qcom,ufshc"
@@ -32,7 +34,20 @@ Optional properties:

 - clocks                : List of phandle and clock specifier pairs
 - clock-names           : List of clock input name strings sorted in the same
-                          order as the clocks property.
+                          order as the clocks property. Standard
clocks include:
+       "core_clk"      : The clock associated with the ufshcd IP block
+       "ref_clk"       : The reference clock for the external
interface to the device,
+                         typically operating at 19.2 MHz.
+       "iface_clk"     : The clock for the CPU-side interface to the
ufshcd memory
+                         mapped registers
+       "bus_clk"       : The interface clock for bus master data
transfers on to
+                         main memory.
+
+- resets               : List of specifiers of associated reset lines
+- reset-names          : An idenfifier for each reset line. The name
"rst" should
+                         be used for the line that resets the ufshci
block during
+                         startup.
+
 - freq-table-hz                : Array of <min max> operating
frequencies stored in the same
                           order as the clocks property. If this property is not
                          defined or a value in the array is "0" then it is assumed @@ -63,6 +78,8 @@ Example:

                clocks = <&core 0>, <&ref 0>, <&iface 0>;
                clock-names = "core_clk", "ref_clk", "iface_clk";
+               resets = <&reset 0 1>;
+               reset-names = "rst";
                freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
                phys = <&ufsphy1>;
                phy-names = "ufsphy";
