From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 9 Jan 2012 10:03:12 +0100
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <4F072843.6050306@ti.com>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <4F072843.6050306@ti.com>
Message-ID: <20120109090311.GA10040@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit wrote:
> Hi Thierry,
> 
> On 1/6/2012 3:28 PM, Thierry Reding wrote:
> >The irq_domain_add() function needs the number of interrupts in the
> >domain to properly initialize them. In addition the allocated domain
> >is now returned by the irq_domain_{add,generate}_simple() helpers.
> 
> [...]
> 
> >diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> >index d587560..bf67781 100644
> >--- a/arch/arm/mach-omap2/board-generic.c
> >+++ b/arch/arm/mach-omap2/board-generic.c
> >@@ -66,8 +66,11 @@ static struct of_device_id intc_match[] __initdata = {
> >  static void __init omap_generic_init(void)
> >  {
> >  	struct device_node *node = of_find_matching_node(NULL, intc_match);
> >-	if (node)
> >-		irq_domain_add_simple(node, 0);
> >+	if (node) {
> >+		struct irq_domain *domain;
> >+		domain = irq_domain_add_simple(node, 0, INTCPS_NR_IRQS);
> 
> The number of interrupts will depend on the OMAP generation. That
> one is just valid for the 3430 INTC controller.
> Since the previous code was using zero, I guess that using 0 there
> should be fine.
> 
> Moreover, that piece of code should not exist anymore on 3.3 if the
> series I sent last month to leverage Rob's DT interrupt init is
> merged [1].
> 
> I've just ping Rob and Grant on that series to get a status.

Okay, so I guess we should wait for you patch to go in first and I'll update
this patch on top of that. I assume we can coordinate things in linux-next?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120109/1b0fd953/attachment.sig>
