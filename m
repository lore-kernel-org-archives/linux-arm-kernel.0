From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2012 10:08:35 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <20121107095635.GV28327@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
 <20121106220458.GP28327@n2100.arm.linux.org.uk>
 <20121107095106.GA23305@mudshark.cambridge.arm.com>
 <20121107095635.GV28327@n2100.arm.linux.org.uk>
Message-ID: <20121107100835.GB23305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 09:56:35AM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 07, 2012 at 09:51:06AM +0000, Will Deacon wrote:
> > Wouldn't the L2 flush in this case be included with the code that turns off
> > caching? For reboot, that's currently done in __sort_restart -- the cache
> > flush in setup_mm_for_reboot is just to ensure that the idmap tables are
> > visible to the hardware walker iirc.
> 
> Good point - but it does raise another issue.  Why do we do this flush and
> TLB invalidate afterwards in setup_mm_for_reboot() ?  It makes sense if
> we change existing page tables, but we don't anymore, we're just switching
> them, and cpu_switch_mm() will do whatever's necessary to make the new
> page tables visible.  So I think we can get rid of that flusing in there.

Hmm, I'm not sure about that. Looking at cpu_v7_switch_mm (the 2-level
version) for example, we set the ASID and then set the new TTBR. There's no
flushing of page tables like we get in set_pte and no TLB flushing either.

Now, given that the idmap_pgd is populated as an early_initcall, I really
doubt we need that flush_cache_all but the TLB invalidate is surely
required?

Will
