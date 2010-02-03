From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 2 Feb 2010 23:42:25 -0800
Subject: [PATCH 1/1] mmp2: add handling on PMIC IRQ
In-Reply-To: <771cded01002022321k2897ca97j85701e39f8f5fac9@mail.gmail.com>
References: <771cded01001262208p2da963dbhf51a245606741bfc@mail.gmail.com>
	<f17812d71002021614n4d9838dh1e2ad6e6be2843c5@mail.gmail.com>
	<771cded01002022231k5c02110ak75aee6a96d8746ac@mail.gmail.com>
	<771cded01002022321k2897ca97j85701e39f8f5fac9@mail.gmail.com>
Message-ID: <f17812d71002022342h7c69fd69kb327a7938e83ec47@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2010 at 11:21 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Wed, Feb 3, 2010 at 1:31 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> On Tue, Feb 2, 2010 at 7:14 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> I don't think this is probably the right way to go. There could be two
>>> improvements:
>>>
>>> 1. move mfpr register manipulation into a dedicated function, e.g.
>>> ? ?mmp2_clear_pmic_int() within mmp2.c
>>>
>>> 2. invent a pmic_mask_ack_irq() to replace the default one at
>>> ? run-time, so to save the time that every 2nd level interrupt
>>> ? handling has to go through the if (.... == IRQ_MMP2_PMIC) thing,
>>> ? provided it does look like an ack operation to me.
>>>
>>
>> Update this patch. The fix is in below.
>> 1. add mmp2_clear_pmic_int()
>> 2. append pmic_irq_demux2() for handling PMIC irq.
>>
>> Thanks
>> Haojian
>>
>
> Update the patch. The fix is in below.
> 1. add pmic_irq_ack().
> 2. remove mask_ack() in irq_chip. Since we have some special ack() to do.
>

point 2) could be a separate patch, so I've modified basically the patch into
follows:

commit 8350feaecaced13caac3aaf5fb7c353f2aac4e22
Author: Haojian Zhuang <haojian.zhuang@marvell.com>
Date:   Wed Feb 3 10:01:18 2010 -0500

    [ARM] mmp2: add handling on PMIC IRQ

    Since PMIC INT pin is a special pin of CPU, the status of PMIC INT pin needs
    to be cleared after PMIC IRQ occured. Now append the clear operation in
    irq chip handler.

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 18c037f..b4a0ba0 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -3,6 +3,7 @@
 struct sys_timer;

 extern void timer_init(int irq);
+extern void mmp2_clear_pmic_int(void);

 extern struct sys_timer pxa168_timer;
 extern struct sys_timer pxa910_timer;
diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index 3ae1c54..b187c02 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -42,6 +42,12 @@ static struct irq_chip icu_irq_chip = {
 	.unmask		= icu_unmask_irq,
 };

+static void pmic_irq_ack(unsigned int irq)
+{
+	if (irq == IRQ_MMP2_PMIC)
+		mmp2_clear_pmic_int();
+}
+
 #define SECOND_IRQ_MASK(_name_, irq_base, prefix)			\
 static void _name_##_mask_irq(unsigned int irq)				\
 {									\
@@ -82,7 +88,6 @@ SECOND_IRQ_DEMUX(_name_, irq_base, prefix)				\
 static struct irq_chip _name_##_irq_chip = {				\
 	.name		= #_name_,					\
 	.mask		= _name_##_mask_irq,				\
-	.mask_ack	= _name_##_mask_irq,				\
 	.unmask		= _name_##_unmask_irq,				\
 }

@@ -126,6 +131,11 @@ void __init mmp2_init_icu(void)
 		}
 	}

+	/* NOTE: IRQ_MMP2_PMIC requires the PMIC MFPR register
+	 * to be written to clear the interrupt
+	 */
+	pmic_irq_chip.ack = pmic_irq_ack;
+
 	init_mux_irq(&pmic_irq_chip, IRQ_MMP2_PMIC_BASE, 2);
 	init_mux_irq(&rtc_irq_chip, IRQ_MMP2_RTC_BASE, 2);
 	init_mux_irq(&twsi_irq_chip, IRQ_MMP2_TWSI_BASE, 5);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 0f1c441..72eb9da 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -37,6 +37,16 @@ static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 	MFP_ADDR_END,
 };

+void mmp2_clear_pmic_int(void)
+{
+	unsigned long mfpr_pmic, data;
+
+	mfpr_pmic = APB_VIRT_BASE + 0x1e000 + 0x2c4;
+	data = __raw_readl(mfpr_pmic);
+	__raw_writel(data | (1 << 6), mfpr_pmic);
+	__raw_writel(data, mfpr_pmic);
+}
+
 static void __init mmp2_init_gpio(void)
 {
 	int i;

And another patch to fix 2):

    [ARM] mmp2: fix incorrect calling of chip->mask_ack() for 2nd
level cascaded IRQs

    The irq_chip is not yet registered, so no default irq_chip.mask_ack(),
    which we have to handle it correctly manually here.

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index b187c02..cb18221 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -102,7 +102,11 @@ static void init_mux_irq(struct irq_chip *chip,
int start, int num)
 	int irq;

 	for (irq = start; num > 0; irq++, num--) {
-		chip->mask_ack(irq);
+		/* mask and clear the IRQ */
+		chip->mask(irq);
+		if (chip->ack)
+			chip->ack(irq);
+
 		set_irq_chip(irq, chip);
 		set_irq_flags(irq, IRQF_VALID);
 		set_irq_handler(irq, handle_level_irq);

Pushed to 'mmp2'.
