From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Oct 2013 10:57:51 +0100
Subject: [PATCH V2] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware
In-Reply-To: <1380112289-19572-1-git-send-email-steve.capper@linaro.org>
References: <1380112289-19572-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20131011095751.GU25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 01:31:29PM +0100, Steve Capper wrote:
> The memory pinning code in uaccess_with_memcpy.c does not check
> for HugeTLB or THP pmds, and will enter an infinite loop should
> a __copy_to_user or __clear_user occur against a huge page.

This patch causes a build error with certain configuration options:

arch/arm/lib/uaccess_with_memcpy.c: In function 'pin_page_for_write':
arch/arm/lib/uaccess_with_memcpy.c:57:2: error: implicit declaration of function 'pmd_thp_or_huge'
arch/arm/lib/uaccess_with_memcpy.c:60:3: error: implicit declaration of function 'pmd_hugewillfault'

found via a randconfig build, configuration:

http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=6265

> ---
>  arch/arm/include/asm/pgtable-3level.h |  3 +++
>  arch/arm/lib/uaccess_with_memcpy.c    | 41 ++++++++++++++++++++++++++++++++---
>  2 files changed, 41 insertions(+), 3 deletions(-)

As the macros are in pgtable-3level.h, this won't work with any configuration
using the 2level header file.
