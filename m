From: Pavel.Tatashin@microsoft.com (Pasha Tatashin)
Date: Thu, 16 Aug 2018 19:02:42 +0000
Subject: [RESEND PATCH v10 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
In-Reply-To: <20180815153456.974798c62dd5a5e4628db8f5@linux-foundation.org>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <20180815153456.974798c62dd5a5e4628db8f5@linux-foundation.org>
Message-ID: <20180816190241.o6ctjypmbd65jdpl@xakep.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-08-15 15:34:56, Andrew Morton wrote:
> On Fri,  6 Jul 2018 17:01:09 +0800 Jia He <hejianet@gmail.com> wrote:
> 
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
> 
> This patchset is basically unreviewed at this stage.  Could people
> please find some time to check it carefully?

Working on it.

Pavel
