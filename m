From: manuel.lauss@gmail.com (Manuel Lauss)
Date: Mon, 16 Feb 2015 13:58:18 +0100
Subject: [alsa-devel] [PATCH] ASoC: wm8731: let codec to manage clock by
 itself
In-Reply-To: <20150216103122.GA1091@opensource.wolfsonmicro.com>
References: <1423121713-19434-1-git-send-email-voice.shen@atmel.com>
 <54DC62EA.5030503@atmel.com>
 <20150216103122.GA1091@opensource.wolfsonmicro.com>
Message-ID: <CAOLZvyFS2fCry_cyeoZ_iXzVy8Yw5nnqvqT+Qth0m_CuDBzSMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 11:31 AM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Thu, Feb 12, 2015 at 04:23:06PM +0800, Bo Shen wrote:
>> Hi All,
>>
>> On 02/05/2015 03:35 PM, Bo Shen wrote:
>>> Let the wm8731 codec to manage clock by itself.
>>>
>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>> ---
>>>
>>>   sound/soc/codecs/wm8731.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>
>> Any comments for this patch (aka ping?)
>
> I preferred the idea of having the clock as optional and from the
> discussion on the last patch it didn't look too tricky to

me too

> achieve. OTOH I think the Atmel system is the only one that uses
> both this CODEC and common clock so it doesn't look like this
> would cause any problems, but might be nice for this not to be
> one more thing for someone to fix up when moving a system to
> common clock.

Not quite, there's one MIPS platform I maintain which needs a patch
like the one below (tested):

diff --git a/arch/mips/alchemy/devboards/db1200.c
b/arch/mips/alchemy/devboards/db1200.c
index 8c13675..aa01ab2 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -19,6 +19,8 @@
  */

 #include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -862,6 +864,12 @@ int __init db1200_dev_setup(void)
     irq_set_status_flags(DB1200_PC1_INSERT_INT, IRQ_NOAUTOEN);
     irq_set_status_flags(DB1200_PC1_EJECT_INT, IRQ_NOAUTOEN);

+    /* register the 12MHz crystal for the WM8731 I2S codec */
+    c = clk_register_fixed_rate(NULL, "wm8731xtal", NULL,
+                    CLK_IS_ROOT, 12000000);
+    if (!IS_ERR(c))
+        clk_register_clkdev(c, "mclk", "0-001b");
+
     i2c_register_board_info(0, db1200_i2c_devs,
                 ARRAY_SIZE(db1200_i2c_devs));
     spi_register_board_info(db1200_spi_devs,
diff --git a/arch/mips/alchemy/devboards/db1300.c
b/arch/mips/alchemy/devboards/db1300.c
index 1c64fdb..1aa01c8 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -5,6 +5,8 @@
  */

 #include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -799,6 +801,12 @@ int __init db1300_dev_setup(void)
     if (platform_driver_register(&db1300_wm97xx_driver))
         pr_warn("DB1300: failed to init touch pen irq support!\n");

+    /* register the 12MHz crystal for the WM8731 I2S codec */
+    c = clk_register_fixed_rate(NULL, "wm8731xtal", NULL,
+                    CLK_IS_ROOT, 12000000);
+    if (!IS_ERR(c))
+        clk_register_clkdev(c, "mclk", "0-001b");
+
     /* Audio PSC clock is supplied by codecs (PSC1, 2) */
     __raw_writel(PSC_SEL_CLK_SERCLK,
         (void __iomem *)KSEG1ADDR(AU1300_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
