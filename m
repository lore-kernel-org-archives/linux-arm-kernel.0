From: hrhaan@gmail.com (Harro Haan)
Date: Sat, 23 Nov 2013 18:27:36 +0100
Subject: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <CAErSpo7c1KiOKqpM1+v6GM09Mspge=Yq9orwXVYjZZjsQssCHA@mail.gmail.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
 <1379319655-20210-4-git-send-email-xobs@kosagi.com>
 <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FD55@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU2ifxfprYsgcQs+Kkgu37+diXHJS6DEqs4d51+U3F4sLQ@mail.gmail.com>
 <52792C5E.6030008@writeme.com>
 <CAErSpo7c1KiOKqpM1+v6GM09Mspge=Yq9orwXVYjZZjsQssCHA@mail.gmail.com>
Message-ID: <CAB5oZtAKmgeAYCgbVAUyjFF+=P4n728M3qD16-FG7mz_9WJooA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2013 21:28, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Nov 5, 2013 at 10:35 AM, Sinan Akman <sinan@writeme.com> wrote:
>>   Tim, Sean what is the status of this patch ? Is it part of any tree
>> already ? I'd like to test few things.
>
> This patch is in my "next" branch and will be merged into Linus' tree
> during the v3.13 merge window (probably next week).  It's also in the
> linux-next tree.
>
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=next&id=bb38919ec56e0758c3ae56dfc091dcde1391353e

Does anybody know how to test this on a SabreSD board?

I have added the following to imx6qdl-sabresd.dtsi:
---------------------
@@ -166,10 +166,21 @@

 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;

+	pcie {
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12      0x80000000
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19      0x80000000
+				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20 0x80000000
+				MX6QDL_PAD_KEY_COL4__GPIO4_IO14     0x80000000
+			>;
+		};
+	};
+
 	hog {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
 				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
@@ -185,10 +196,20 @@
 			>;
 		};
 	};
 };

+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio7 12 0>;
+	power-on-gpio = <&gpio3 19 0>;
+	wake-up-gpio = <&gpio5 20 0>;
+	disable-gpio = <&gpio4 14 0>;
+	status = "okay";
+};
+
 &ldb {
 	status = "okay";

 	lvds-channel at 1 {
 		fsl,data-mapping = "spwg";
---------------------

But during booting it says:
imx6q-pcie 1ffc000.pcie: phy link never came up

Thanks in advance,

Harro

Note: the e1000e network card does work with the FSL imx_3.0.35 kernel
