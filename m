From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2016 20:23:17 +0000
Subject: [4.4-rt2 PATCH] ARM: highmem: take into account FIX_KMAP_BEGIN
 in switch_kmaps()
In-Reply-To: <20160120202139.GC2741@linutronix.de>
References: <1452867647-1410-1-git-send-email-grygorii.strashko@ti.com>
 <20160120202139.GC2741@linutronix.de>
Message-ID: <20160120202317.GV19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 09:21:39PM +0100, Sebastian Andrzej Siewior wrote:
> * Grygorii Strashko | 2016-01-15 16:20:47 [+0200]:
> 
> >--- a/arch/arm/mm/highmem.c
> >+++ b/arch/arm/mm/highmem.c
> >@@ -175,7 +180,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
> > 	 * Restore @next_p's kmap_atomic mappings
> > 	 */
> > 	for (i = 0; i < next_p->kmap_idx; i++) {
> >-		int idx = i + KM_TYPE_NR * smp_processor_id();
> >+		int idx = fixmap_idx(i);
> > 
> > 		if (!pte_none(next_p->kmap_pte[i]))
> > 			set_fixmap_pte(idx, next_p->kmap_pte[i]);
> 
> Grygorii, if you remove this chunk then it should apply upstream. Could
> you forward it upstream then please? So the -RT piece would shrink a
> little:)

Or I could commit my own patch which forms a proportion of this change.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
