From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 11:47:07 +0100
Subject: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
In-Reply-To: <20180905145755.cc89819d446f311e4b8e8f95@linux-foundation.org>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <20180905145755.cc89819d446f311e4b8e8f95@linux-foundation.org>
Message-ID: <20180906104707.GL3592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 02:57:55PM -0700, Andrew Morton wrote:
> On Wed, 22 Aug 2018 11:07:14 +0800 Jia He <hejianet@gmail.com> wrote:
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
> Thanks.  I switched to v11.  It would be nice to see some confirmation
> from ARM people please?

I'll take a look...

Will
