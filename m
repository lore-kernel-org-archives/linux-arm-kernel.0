From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 09:03:17 +0100
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <alpine.LFD.2.20.1509072139050.22877@knanqh.ubzr>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
 <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
 <1713935.2YV1sNJUyb@wuerfel>
 <alpine.LFD.2.20.1509071152510.22877@knanqh.ubzr>
 <20150908001042.GT21084@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1509072139050.22877@knanqh.ubzr>
Message-ID: <20150908080316.GU21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 10:01:41PM -0400, Nicolas Pitre wrote:
> On Tue, 8 Sep 2015, Russell King - ARM Linux wrote:
> 
> > On Mon, Sep 07, 2015 at 03:40:36PM -0400, Nicolas Pitre wrote:
> > > On Mon, 7 Sep 2015, Arnd Bergmann wrote:
> > > 
> > > > On Thursday 03 September 2015 21:24:00 Nicolas Pitre wrote:
> > > > > If 768MB targets were common place then it could be worth changing the 
> > > > > default vmalloc size to accommodate this memory size and testing all the 
> > > > > other targets to make sure no regressions are introduced.  But given it 
> > > > > is easy to change the default via the kernel cmdline, and that you lose 
> > > > > only 8 MB otherwise, I don't think it is worth the trouble and/or the 
> > > > > risk.
> > > > 
> > > > Agreed.
> > > 
> > > Well... I think there is a better solution.
> > 
> > Doesn't this clash with things like:
> > 
> > #define UNCACHEABLE_ADDR        0xff000000      /* IRQ_STAT */
> > 
> > ?
> 
> It looks like the move might actually "fix" it.  That UNCACHEABLE_ADDR 
> is mapped with:
> 
> static struct map_desc ebsa110_io_desc[] __initdata = {
>         /*
>          * sparse external-decode ISAIO space
>          */
>         {       /* IRQ_STAT/IRQ_MCLR */
>                 .virtual        = (unsigned long)IRQ_STAT,
>                 .pfn            = __phys_to_pfn(TRICK4_PHYS),
>                 .length         = TRICK4_SIZE,
>                 .type           = MT_DEVICE
>         },
> [...]
> };
> 
> This is passed to iotable_init(), then to create_mapping(). There you 
> have:
> 
>         if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
>             md->virtual >= PAGE_OFFSET &&
>             (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
>                 pr_warn("BUG: mapping for 0x%08llx at 0x%08lx out of vmalloc space\n",
>                         (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
>         }
> 
> So you must have hit the above warning somehow. Incidentally, this 
> IRQ_STAT entry is the only one that happened to be outside the vmalloc 
> area. By moving VMALLOC_END from 0xff000000 to 0xff800000 the warning 
> will be gone.

No, there are other legacy platforms which have mappings above that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
