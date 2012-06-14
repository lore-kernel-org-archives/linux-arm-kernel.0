From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 13 Jun 2012 23:57:56 -0300
Subject: MXS getting AUART to work with DT.
In-Reply-To: <4FD7EFFC.8010204@grid-net.com>
References: <4FD7EFFC.8010204@grid-net.com>
Message-ID: <CAOMZO5BDFD3hHt+HW_sdh-3hCEwgJJA9C0ecAJZSOUCw_725Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 10:42 PM, Subodh Nijsure <snijsure@grid-net.com> wrote:
> Hi,
>
> I am testing my mx28 hardware with arm-soc/for-next branch. I have made
> ?additions shown below to my dt file.
>
> What I see is only ttyAPP0 device gets created but not the ttyAPP1, do folks
> who know DT much better than I, see any issues with this DT definition
> below?

Would something like the patch below be needed?

---
 arch/arm/boot/dts/imx28.dtsi   |    5 +++++
 drivers/tty/serial/mxs-auart.c |    9 +++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..d524377 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -404,30 +404,35 @@
 			};

 			auart0: serial at 8006a000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
 				status = "disabled";
 			};

 			auart1: serial at 8006c000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x8006c000 0x2000>;
 				interrupts = <113 72 73>;
 				status = "disabled";
 			};

 			auart2: serial at 8006e000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x8006e000 0x2000>;
 				interrupts = <114 74 75>;
 				status = "disabled";
 			};

 			auart3: serial at 80070000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x80070000 0x2000>;
 				interrupts = <115 76 77>;
 				status = "disabled";
 			};

 			auart4: serial at 80072000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x80072000 0x2000>;
 				interrupts = <116 78 79>;
 				status = "disabled";
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec56d83..6540f28 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -33,6 +33,8 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/of.h>
+#include <linux/of_address.h>

 #include <asm/cacheflush.h>

@@ -769,12 +771,19 @@ static int __devexit mxs_auart_remove(struct
platform_device *pdev)
 	return 0;
 }

+static struct of_device_id mxs_auart_dt_ids[] = {
+	{.compatible = "fsl,mxs-auart", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_auart_of_match);
+
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
 	.remove = __devexit_p(mxs_auart_remove),
 	.driver = {
 		.name = "mxs-auart",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mxs_auart_dt_ids),
 	},
 };

-- 
1.7.1
