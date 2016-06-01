From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 1 Jun 2016 10:39:42 +0800
Subject: [PATCH 2/2] arm64: mm: dump: log span level
In-Reply-To: <1464702542-24394-3-git-send-email-mark.rutland@arm.com>
References: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
 <1464702542-24394-3-git-send-email-mark.rutland@arm.com>
Message-ID: <20160601023940.GA14411@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 02:49:02PM +0100, Mark Rutland wrote:
> The page table dump code logs spans of entries at the same level
> (pgd/pud/pmd/pte) which have the same attributes. While we log the
> (decoded) attributes, we don't log the level, which leaves the output
> ambiguous and/or confusing in some cases.
>
> For example:
>
> 0xffff800800000000-0xffff800980000000           6G       RW NX SHD AF        BLK UXN MEM/NORMAL
>
> If using 4K pages, this may describe a span of 6 1G block entries at the
> PGD/PUD level, or 3072 2M block entries at the PMD level.
>
> This patch adds the page table level to each output line, removing this
> ambiguity. For the example above, this will produce:
>
> 0xffffffc800000000-0xffffffc980000000           6G PUD       RW NX SHD AF        BLK UXN MEM/NORMAL
>
> When 3 level tables are in use, and we use the asm-generic/nopud.h
> definitions, the dump code treats each entry in the PGD as a 1 element
> table at the PUD level, and logs spans as being PUDs, which can be
> confusing. To counteract this, the "PUD" mnemonic is replaced with "PGD"
> when CONFIG_PGTABLE_LEVELS <= 3. Likewise for "PMD" when
> CONFIG_PGTABLE_LEVELS <= 2.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Huang Shijie <shijie.huang@arm.com>
Tested-by: Huang Shijie <shijie.huang@arm.com>

thanks
Huang Shijie
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
