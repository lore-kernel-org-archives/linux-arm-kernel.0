From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 8 Sep 2015 10:58:09 -0400 (EDT)
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <20150908080316.GU21084@n2100.arm.linux.org.uk>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
 <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
 <1713935.2YV1sNJUyb@wuerfel>
 <alpine.LFD.2.20.1509071152510.22877@knanqh.ubzr>
 <20150908001042.GT21084@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1509072139050.22877@knanqh.ubzr>
 <20150908080316.GU21084@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1509081036060.22877@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Sep 2015, Russell King - ARM Linux wrote:

> On Mon, Sep 07, 2015 at 10:01:41PM -0400, Nicolas Pitre wrote:
> 
[...]
> > This is passed to iotable_init(), then to create_mapping(). There you 
> > have:
> > 
> >         if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
> >             md->virtual >= PAGE_OFFSET &&
> >             (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
> >                 pr_warn("BUG: mapping for 0x%08llx at 0x%08lx out of vmalloc space\n",
> >                         (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
> >         }
> > 
> > So you must have hit the above warning somehow. Incidentally, this 
> > IRQ_STAT entry is the only one that happened to be outside the vmalloc 
> > area. By moving VMALLOC_END from 0xff000000 to 0xff800000 the warning 
> > will be gone.
> 
> No, there are other legacy platforms which have mappings above that.

... for that particular map_desc array instance I mean.

WRT other legacy platforms: if the above warning didn't bother anyone 
for the last 4 years, then it won't be such an issue either if the 
current proposal doesn't solve them all.  That's not the primary purpose 
of this change anyway. In those cases, the appropriate fix, like it is 
today, should consist in some adjustment of those virtual addresses to 
bring them inside the vmalloc area.

Your original concern was whether extending the vmalloc area upward 
would clash with something else, and the short answer is no.


Nicolas
