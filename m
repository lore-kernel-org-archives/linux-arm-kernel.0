From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Sep 2018 15:44:47 +0100
Subject: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
In-Reply-To: <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
Message-ID: <20180907144447.GD12788@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
> On 22 August 2018 at 05:07, Jia He <hejianet@gmail.com> wrote:
> > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> > where possible") optimized the loop in memmap_init_zone(). But it causes
> > possible panic bug. So Daniel Vacek reverted it later.
> >
> > But as suggested by Daniel Vacek, it is fine to using memblock to skip
> > gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> >
> > More from what Daniel said:
> > "On arm and arm64, memblock is used by default. But generic version of
> > pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> > not always return the next valid one but skips more resulting in some
> > valid frames to be skipped (as if they were invalid). And that's why
> > kernel was eventually crashing on some !arm machines."
> >
> > About the performance consideration:
> > As said by James in b92df1de5,
> > "I have tested this patch on a virtual model of a Samurai CPU with a
> > sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> > Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> >
> > Besides we can remain memblock_next_valid_pfn, there is still some room
> > for improvement. After this set, I can see the time overhead of memmap_init
> > is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> > memory, pagesize 64k). I believe arm server will benefit more if memory is
> > larger than TBs
> >
> 
> OK so we can summarize the benefits of this series as follows:
> - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
> - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
> *milliseconds*
> 
> Google was not very helpful in figuring out what a Samurai CPU is and
> why we should care about the boot time of Linux running on a virtual
> model of it, and the 15 ms speedup is not that compelling either.
> 
> Apologies to Jia that it took 11 revisions to reach this conclusion,
> but in /my/ opinion, tweaking the fragile memblock/pfn handling code
> for this reason is totally unjustified, and we're better off
> disregarding these patches.

Oh, we're talking about a *simulator* for the significant boot time
improvement here? I didn't realise that, so I agree that the premise of
this patch set looks pretty questionable given how much "fun" we've had
with the memmap on arm and arm64.

Will
