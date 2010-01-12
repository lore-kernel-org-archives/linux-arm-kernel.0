From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Jan 2010 08:19:35 +0800
Subject: [PATCH 05/16] [ARM] pxa/cm-x270: avoid direct access of GPIO/MFP
	registers
In-Reply-To: <4B4B418E.6050909@compulab.co.il>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
	<1263218664-11546-6-git-send-email-eric.y.miao@gmail.com>
	<4B4B418E.6050909@compulab.co.il>
Message-ID: <f17812d71001111619p292b0f78nb6bc08b6b66dd8b4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 11:19 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Eric Miao wrote:
>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> ---
>> ?arch/arm/mach-pxa/cm-x270.c | ? 62 ++++++++++++++++++++++++++++++------------
>> ?1 files changed, 44 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
>> index 425efbc..ce503f4 100644
>> --- a/arch/arm/mach-pxa/cm-x270.c
>> +++ b/arch/arm/mach-pxa/cm-x270.c
>> @@ -178,31 +178,57 @@ static struct resource cmx270_2700G_resource[] = {
>>
>> ?static unsigned long save_lcd_regs[10];
>
> This can be dropped as well.
>

Thanks, patch updated as follows:

    [ARM] pxa/cm-x270: avoid direct access of GPIO/MFP registers

    Cc: Mike Rapoport <mike@compulab.co.il>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index 425efbc..a9926bb 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -176,33 +176,57 @@ static struct resource cmx270_2700G_resource[] = {
 	},
 };

-static unsigned long save_lcd_regs[10];
+static unsigned long cmx270_marathon_on[] = {
+	GPIO58_GPIO,
+	GPIO59_GPIO,
+	GPIO60_GPIO,
+	GPIO61_GPIO,
+	GPIO62_GPIO,
+	GPIO63_GPIO,
+	GPIO64_GPIO,
+	GPIO65_GPIO,
+	GPIO66_GPIO,
+	GPIO67_GPIO,
+	GPIO68_GPIO,
+	GPIO69_GPIO,
+	GPIO70_GPIO,
+	GPIO71_GPIO,
+	GPIO72_GPIO,
+	GPIO73_GPIO,
+	GPIO74_GPIO,
+	GPIO75_GPIO,
+	GPIO76_GPIO,
+	GPIO77_GPIO,
+};
+
+static unsigned long cmx270_marathon_off[] = {
+	GPIOxx_LCD_TFT_16BPP,
+};

 static int cmx270_marathon_probe(struct fb_info *fb)
 {
-	/* save PXA-270 pin settings before enabling 2700G */
-	save_lcd_regs[0] = GPDR1;
-	save_lcd_regs[1] = GPDR2;
-	save_lcd_regs[2] = GAFR1_U;
-	save_lcd_regs[3] = GAFR2_L;
-	save_lcd_regs[4] = GAFR2_U;
-
-	/* Disable PXA-270 on-chip controller driving pins */
-	GPDR1 &= ~(0xfc000000);
-	GPDR2 &= ~(0x00c03fff);
-	GAFR1_U &= ~(0xfff00000);
-	GAFR2_L &= ~(0x0fffffff);
-	GAFR2_U &= ~(0x0000f000);
+	int gpio, err;
+
+	for (gpio = 58; gpio <= 77; gpio++) {
+		err = gpio_request(gpio, "LCD");
+		if (err)
+			return err;
+		gpio_direction_input(gpio);
+	}
+
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(cmx270_marathon_on));
 	return 0;
 }

 static int cmx270_marathon_remove(struct fb_info *fb)
 {
-	GPDR1 =   save_lcd_regs[0];
-	GPDR2 =   save_lcd_regs[1];
-	GAFR1_U = save_lcd_regs[2];
-	GAFR2_L = save_lcd_regs[3];
-	GAFR2_U = save_lcd_regs[4];
+	int gpio;
+
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(cmx270_marathon_off));
+
+	for (gpio = 58; gpio <= 77; gpio++)
+		gpio_free(gpio);
+
 	return 0;
 }
