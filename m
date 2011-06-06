From: zecke@selfish.org (Holger Freyther)
Date: Mon, 06 Jun 2011 17:10:49 +0200
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <alpine.LFD.2.02.1106061650210.13964@ionos>
References: <4DECCADE.6080100@selfish.org> <4DECD8C0.6010908@freyther.de>
	<alpine.LFD.2.02.1106061650210.13964@ionos>
Message-ID: <4DECEDF9.4010202@selfish.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2011 04:54 PM, Thomas Gleixner wrote:

>> I resorted to printf debugging, it is IRQ 56 which is the IRQ_GPIOBNK0.. so I
>> wonder if this IRQ should end up in the GC GPIO code at all?
> 
> That depends on davinci_soc_info.intc_irq_num.
> 
> #define DAVINCI_N_AINTC_IRQ     64
> #define DA830_N_CP_INTC_IRQ     96
> #define TNETV107X_N_CP_INTC_IRQ                 96
> 
> No idea which one applies to your machine, but for all in tree boards
> 56 is in the range of intc interrupts.

It should be the DAVINCI_N_AINTC_IRQ (dm6446.c:davinci_soc_info_dm644x), I
have commented out the AINTC code in davinci_gpio_irq_setup and my crash is
gone, so without knowing the code at all I assume one should not end where we
end up.. or at least not with the parameters.

I have instrumented the GC IRQ code and I get:
IRQ40:
	Interrupt is 40 32
	RegBase is 0xfec48000 offset 28

IRQ56:
	Interrupt is 56...
	RegBase is 0x5ffffbff offset 28

and both interrupts should be on REG1.. so for IRQ56 it looks like this method
is entered with bogus data. Again, I have no idea about the underlying code,
but could there be an issue with chained irq and the GC IRC code?


going to dig deeper..
	holger




diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 31a9db7..fc505c3 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -74,6 +74,13 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 void irq_gc_mask_clr_bit(struct irq_data *d)
 {
        struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+
+       if (d->irq > 31) {
+               printk(KERN_ERR "Interrupt is %d %d\n", d->irq, gc->irq_base);
+               printk(KERN_ERR "RegBase is 0x%p offset %lu\n", gc->reg_base,
+		       cur_regs(d)->mask);
+       }
+
        u32 mask = 1 << (d->irq - gc->irq_base);

        irq_gc_lock(gc);
