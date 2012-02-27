From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Feb 2012 08:37:03 -0600
Subject: [PATCH] ARM: integrator: convert to sparse irqs
In-Reply-To: <CACRpkdag3BsubBgTiNM35e97OmjHpzAseEz0WK3oo5rQ5i8S_g@mail.gmail.com>
References: <1330104737-22782-1-git-send-email-linus.walleij@linaro.org>
 <20120224191541.GB21556@game.jcrosoft.org>
 <CACRpkdbjeAmD=AsybOEkYFMUEyvfwONawdDGtfwMhBhrKyg2hQ@mail.gmail.com>
 <4F4AFB95.9040204@gmail.com>
 <CACRpkdag3BsubBgTiNM35e97OmjHpzAseEz0WK3oo5rQ5i8S_g@mail.gmail.com>
Message-ID: <4F4B950F.3020803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2012 01:44 AM, Linus Walleij wrote:
> On Mon, Feb 27, 2012 at 4:42 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 02/26/2012 03:45 AM, Linus Walleij wrote:
>>> On Fri, Feb 24, 2012 at 8:15 PM, Jean-Christophe PLAGNIOL-VILLARD
>>> <plagnioj@jcrosoft.com> wrote:
>>>> On 18:32 Fri 24 Feb     , Linus Walleij wrote:
>>>
>>>>> -#define NR_IRQS                         47
>>>>> +#define NR_IRQS_INTEGRATOR_AP                34
>>>>> +#define NR_IRQS_INTEGRATOR_CP                47
>>>>
>>>> why do you need to specified both?
>>>
>>> They are two totally different machines and should never have had that
>>> common roof of NR_IRQS = max(AP,CP), it's just not elegant.
>>>
>>> Maybe I'm a bit pedantic but I want to set the .nr_irqs for each machine so that
>>> it corresponds exactly to what it actually has, instead of using a roof value.
>>> I think it improves readability and understanding.
>>
>> Really, you want to get rid of the value altogether. Each irq_chip
>> should allocate its irq_descs and then you don't need to set .nr_irqs.
> 
> OK can you point to a machine that does it the right way and
> I'll fix.
> 
> Or do I need the irq domains lib to go in first to do that in a
> good/non-awkward way?
> 

You just need something like this. It doesn't really need a domain until
DT support is done and this will still be needed in the non-DT case.

Rob

diff --git a/arch/arm/plat-versatile/fpga-irq.c
b/arch/arm/plat-versatile/fpga-irq.c
index f0cc8e1..3e66b20 100644
--- a/arch/arm/plat-versatile/fpga-irq.c
+++ b/arch/arm/plat-versatile/fpga-irq.c
@@ -49,6 +49,7 @@ static void fpga_irq_handle(unsigned int irq, struct
irq_desc *desc)
 void __init fpga_irq_init(int parent_irq, u32 valid, struct
fpga_irq_data *f)
 {
 	unsigned int i;
+	int irq_cnt = fls(valid);

 	f->chip.irq_ack = fpga_irq_mask;
 	f->chip.irq_mask = fpga_irq_mask;
@@ -59,7 +60,9 @@ void __init fpga_irq_init(int parent_irq, u32 valid,
struct fpga_irq_data *f)
 		irq_set_chained_handler(parent_irq, fpga_irq_handle);
 	}

-	for (i = 0; i < 32; i++) {
+	irq_alloc_descs(f->irq_start, 0, irq_cnt, numa_node_id());
+
+	for (i = 0; i < irq_cnt; i++) {
 		if (valid & (1 << i)) {
 			unsigned int irq = f->irq_start + i;
