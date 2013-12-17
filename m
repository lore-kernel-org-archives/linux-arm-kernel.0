From: geoff@infradead.org (Geoff Levand)
Date: Mon, 16 Dec 2013 16:20:59 -0800
Subject: [PATCH 2/5] arm64: Fix the soft_restart routine
In-Reply-To: <20131213164646.GN19177@mudshark.cambridge.arm.com>
References: <cover.1386879684.git.geoff@infradead.org>
 <fbf47d394de6bd7332b00bc706a9f38cd7a68327.1386879684.git.geoff@infradead.org>
 <20131213164646.GN19177@mudshark.cambridge.arm.com>
Message-ID: <1387239659.1002.152.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, 2013-12-13 at 16:46 +0000, Will Deacon wrote:
> On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> > +	/*
> > +	 * cpu_reset turns the MMU off, so must be called at its identity
> > +	 * mapped physical address.
> > +	 */
> > +
> > +	(*(void(*)(unsigned long))virt_to_phys(cpu_reset))(addr);
> 
> This isn't right; although cpu_reset *does* need to run from the idmap,
> actually the idmap only includes __turn_mmu_on. You just get lucky because
> its section-mapped and happens to include the code you want.

OK, I think this is different from fixing the call in soft_restart(), so
I'll make a separate patch for this.

I can see a few ways to do it but am not sure of the ramifications
of each.  Should we put cpu_reset into the idmap at startup when we add
__turn_mmu_on, or add cpu_reset on demand from say setup_mm_for_reboot()?

If the former, is all we need something like this?

@@ -438,6 +438,9 @@ __create_page_tables:
 	adr	x3, __turn_mmu_on		// virtual/physical address
 	create_pgd_entry x25, x0, x3, x5, x6
 	create_block_map x0, x7, x3, x5, x5, idmap=1
+	adr	x3, cpu_reset			// virtual/physical address
+	create_pgd_entry x25, x0, x3, x5, x6
+	create_block_map x0, x7, x3, x5, x5, idmap=1

> The cast is also cleaner if you define a phys_reset_t type, like we do for
> arch/arm/.

I'll send out an updated fix.

-Geoff
