From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Nov 2011 11:17:12 +0000
Subject: [PATCH v8 09/16] ARM: LPAE: MMU setup for the 3-level page
 table format
In-Reply-To: <20111110223842.GS12913@n2100.arm.linux.org.uk>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-10-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1111101707250.3307@xanadu.home>
 <20111110223842.GS12913@n2100.arm.linux.org.uk>
Message-ID: <20111111111712.GD23243@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 10:38:42PM +0000, Russell King - ARM Linux wrote:
> There's also the question about whether the kernel is ready to deal with
> split page tables.  I don't believe it is, because there are situations
> where we walk the current page table for kernel addresses.
> 
> So, I think trying to reduce the L1 page table size and set the hardware
> in this way may cause instability at the present time.

The init_mm.pgd still has the same size and that's the master copy that
keeps kernel addresses. Level 1 entries in user pgd still point to the
init_mm pmd entries as copied from init_mm.pgd. Address below
PAGE_OFFSET are accessible via TTBR0 as before.

The only thing the patch does is making sure that TTBR1 is used for
kernel translations beyond PAGE_OFFSET and the real advantage comes when
the kernel space is 1GB allowing the hardware to skip one translation
table.

Please note that the code does not make any assumption that there are
separate page tables for the kernel, pgd_alloc() actually makes sure
that the pgd entries for PAGE_OFFSET are the same across all mm's.

-- 
Catalin
