From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2011 12:56:35 +0100
Subject: [PATCH v7 08/16] ARM: LPAE: Page table maintenance for the
	3-level format
In-Reply-To: <1312988619-16804-9-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111023115635.GA17912@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:31PM +0100, Catalin Marinas wrote:
> This patch modifies the pgd/pmd/pte manipulation functions to support
> the 3-level page table format. Since there is no need for an 'ext'
> argument to cpu_set_pte_ext(), this patch conditionally defines a
> different prototype for this function when CONFIG_ARM_LPAE.

This has a really large number of ifdefs.  You've split the 2 and 3
level page table stuff into two different header files already,
conditionalized on CONFIG_ARM_LPAE, yet we still end up with lots of
junk in the common header file conditionalized on that symbol.  Can't
we find a way to restructure pgtable.h to sort this out more cleanly?

Do we really need to change the set_pte_ext() prototype as well - do
we _really_ need ifdefs around its declaration, and every usage of it
as well?  Can't we just leave the 3rd argument as zero?
