From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 19 Jun 2013 02:34:11 +0100
Subject: [PATCH v5] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1371547781-31097-2-git-send-email-gregory.clement@free-electrons.com>
References: <1371547781-31097-1-git-send-email-gregory.clement@free-electrons.com>
 <1371547781-31097-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1371605651.3495.141.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-06-18 at 11:29 +0200, Gregory CLEMENT wrote:
> This commit fixes the regression on Armada 370 (the kernal hang during
> boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> 
> When coming out of either a Wait for Interrupt (WFI) or a Wait for
> Event (WFE) IDLE states, a specific timing sensitivity exists between
> the retiring WFI/WFE instructions and the newly issued subsequent
> instructions. This sensitivity can result in a CPU hang scenario.  The
> workaround is to insert either a Data Synchronization Barrier (DSB) or
> Data Memory Barrier (DMB) command immediately after the WFI/WFE
> instruction.
> 
> This commit was based on the work of Lior Amsalem, but heavily
> modified to apply the errata fix dynamically according to the
> processor type thanks to the suggestions of Russell King and Nicolas
> Pitre.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm/Kconfig                 | 13 +++++++++++++
>  arch/arm/include/asm/glue-proc.h |  9 +++++++++
>  arch/arm/mm/proc-macros.S        |  5 +++++
>  arch/arm/mm/proc-v7.S            | 34 +++++++++++++++++++++++++++++++---
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..95cbe9d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1087,6 +1087,19 @@ if !MMU
>  source "arch/arm/Kconfig-nommu"
>  endif
>  
> +config PJ4B_ERRATA_4742
> +	bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
> +	depends on CPU_PJ4B && MACH_ARMADA_370
[...]

Shouldn't this be 'default y'?  This apppears to be consistent with
other ARM CPU workarounds, but it seems negligent not to enable them by
default on the affected CPUs.  Who really wants to take the risk?

Ben.

-- 
Ben Hutchings
Lowery's Law:
             If it jams, force it. If it breaks, it needed replacing anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/64ee66af/attachment.sig>
