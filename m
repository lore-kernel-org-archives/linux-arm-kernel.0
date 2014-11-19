From: francesco@dolcini.it (Francesco Dolcini)
Date: Wed, 19 Nov 2014 17:01:08 +0100
Subject: ARM: mvebu: ethernet packets corruption and I/O coherency
In-Reply-To: <20141118153035.757fe0fc@free-electrons.com>
References: <20141118142520.GD24819@dev0.local>
 <20141118153035.757fe0fc@free-electrons.com>
Message-ID: <20141119160108.GJ24819@dev0.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas and all

On Tue, Nov 18, 2014 at 03:30:35PM +0100, Thomas Petazzoni wrote:
> It could indeed be related. I have marked the relevant patches in the 
> "ARM: mvebu: no I/O coherency on non-SMP and related updates" series as
> to be backported to stable up to v3.8, so when they get accepted, I'll
> take care of backporting them.

I prepared and tested this small patch to fix the problem on kernel
3.13.11 and it seems to fix my ethernet packet corruption problem.
Do you think it is fine?

Do you think that this bug on I/O cache coherency could also trigger some
sporadic random OOPS and kernel panic? I got an OOPS with a broken LR in
skb_segment() and a kernel panic in put_page(), but I was never able to
reproduce any of them.

Thanks,
Francesco


--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -124,6 +124,12 @@
 {
 	struct device_node *np;
 
+	if (!is_smp())
+	{
+	    pr_info("Coherency fabric disabled\n");
+	    return 0;
+	}
+
 	np = of_find_matching_node(NULL, of_coherency_table);
 	if (np) {
 		struct resource res;
@@ -150,6 +156,9 @@
 {
 	struct device_node *np;
 
+	if (!is_smp())
+	    return 0;
+
 	np = of_find_matching_node(NULL, of_coherency_table);
 	if (np) {
 		bus_register_notifier(&platform_bus_type,
