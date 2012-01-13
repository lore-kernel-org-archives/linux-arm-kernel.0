From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 Jan 2012 01:42:50 +0000
Subject: [PATCH 0/2] Full DT IRQ support for versatile
In-Reply-To: <CACxGe6v-gkW+pDP-2hTcf7WqeMBtx+H80Xymj7SqS8nqin9qUA@mail.gmail.com>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
 <CACxGe6v-gkW+pDP-2hTcf7WqeMBtx+H80Xymj7SqS8nqin9qUA@mail.gmail.com>
Message-ID: <20120113014250.GD14007@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 06:20:37PM -0700, Grant Likely wrote:
> On Thu, Jan 12, 2012 at 5:43 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > These patches move versatile over to instantiating both interrupt
> > controllers from the device tree. ?I've tested this in qemu for both DT
> > and non-DT platforms but only with an initramfs. ?I've seen interrupts
> > generated on both controllers for both boot methods.
> >
> > Grant, Rob, this makes use of irqdomain again as I'm not sure what the
> > replacement is going to look like yet. ?versatile works with DT in
> > mainline, but that's kind of lucky... ?I know there's been patches to
> > make irq_domain_add_simple() return the irq_domain and can rebase if
> > needed.
> 
> I posted the patches for finishing up irq_domain migration yesterday.
> irq_domain_add_simple() can trivially be changed to
> irq_domain_add_legacy. I'll try out these
> patches on top of my irqdomain/next branch

Excellent!  I've just grabbed your branch and given it a spin.  I fixed 
up my patches with the patch below and had to revert "irqdesc: 
Consolidate irq reservation logic" as I saw Rob mentioned as I was 
getting negative irq_desc's allocated but otherwise it works nicely!

I've also tested your tree with the irqdesc patch reverted on picoxcell 
and that's working nicely too!

Jamie

8<----

diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
index fd87b06..c4dac93 100644
--- a/arch/arm/plat-versatile/fpga-irq.c
+++ b/arch/arm/plat-versatile/fpga-irq.c
@@ -59,10 +59,9 @@ void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
 	f->chip.irq_ack = fpga_irq_mask;
 	f->chip.irq_mask = fpga_irq_mask;
 	f->chip.irq_unmask = fpga_irq_unmask;
-	f->domain.irq_base = f->irq_start;
-	f->domain.nr_irq = 32;
-	f->domain.ops = &irq_domain_simple_ops;
-	irq_domain_add(&f->domain);
+	if (!f->domain)
+		f->domain = irq_domain_add_legacy(NULL, 32, f->irq_start,
+						  0, &irq_domain_simple_ops);
 
 	if (parent_irq != -1) {
 		irq_set_handler_data(parent_irq, f);
@@ -103,7 +102,8 @@ int __init sic_of_init(struct device_node *np, struct device_node *parent)
 		err = sic_data->irq_start;
 		goto out_unmap;
 	}
-	sic_data->domain.of_node = of_node_get(np);
+	sic_data->domain = irq_domain_add_legacy(np, 32, sic_data->irq_start,
+						 0, &irq_domain_simple_ops);
 
 	fpga_irq_init(irq, ~0, sic_data);
 
diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
index a1391f3..5e300e9 100644
--- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
+++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
@@ -1,15 +1,14 @@
 #ifndef PLAT_FPGA_IRQ_H
 #define PLAT_FPGA_IRQ_H
 
-#include <linux/irqdomain.h>
-
 struct device_node;
+struct irq_domain;
 
 struct fpga_irq_data {
 	void __iomem *base;
 	unsigned int irq_start;
 	struct irq_chip chip;
-	struct irq_domain domain;
+	struct irq_domain *domain;
 };
 
 void fpga_irq_init(int, u32, struct fpga_irq_data *);
