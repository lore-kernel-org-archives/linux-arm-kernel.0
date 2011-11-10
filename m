From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2011 22:42:08 +0000
Subject: [PATCH v8 02/16] ARM: pgtable: Fix compiler warning in
 ioremap.c introduced by nopud
In-Reply-To: <1320682618-1182-3-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111110224208.GT12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 04:16:44PM +0000, Catalin Marinas wrote:
> With the arch/arm code conversion to pgtable-nopud.h, the section and
> supersection (un|re)map code triggers compiler warnings on UP systems.
> This is caused by pmd_offset() being given a pgd_t argument rather than
> a pud_t one. This patch makes the necessary conversion with the
> assumption that the pud is folded into the pgd. The page table setting
> code only loops over the pmd which is enough with the classic page
> tables. This code is not compiled when LPAE is enabled.

This should come before the nopud include, so that we don't introduce the
warnings in the first place.  The result should compile to the same code
with just this patch applied.
