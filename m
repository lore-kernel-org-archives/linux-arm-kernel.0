From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Nov 2010 13:19:41 +0000
Subject: [PATCH v2 03/20] ARM: LPAE: use u32 instead of unsigned long
	for 32-bit ptes
In-Reply-To: <1289584840-18097-4-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <20101114131941.GA10871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 06:00:23PM +0000, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> When using 2-level paging, pte_t and pmd_t are typedefs for
> unsigned long but phys_addr_t is a typedef for u32.
> 
> This patch uses u32 for the page table entry types when
> phys_addr_t is not 64-bit, allowing the same conversion
> specifier to be used for physical addresses and page table
> entries regardless of LPAE.

However, code which prints the value of page table entries assumes that
they are unsigned long, and places where we store the raw pte value also
uses 'unsigned long'.

If we're going to make this change, we need to change more places than
this patch covers.  grep for pte_val to help find those places.
