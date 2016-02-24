From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Feb 2016 13:40:16 +0000
Subject: [PATCH v3] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <1456272534-21692-1-git-send-email-ddaney.cavm@gmail.com>
References: <1456272534-21692-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160224134016.GH28310@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 04:08:54PM -0800, David Daney wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> instructions may cause the icache to become corrupted if it contains
> data for a non-current ASID.
> 
> This patch implements the workaround (which flushes the local icache
> when switching the mm) by using code patching.
> 
> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     | 11 +++++++++++
>  arch/arm64/include/asm/cpufeature.h    |  3 ++-
>  arch/arm64/kernel/cpu_errata.c         |  9 +++++++++
>  arch/arm64/mm/proc.S                   | 12 ++++++++++++
>  5 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 58b71dd..ba4b6ac 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -56,3 +56,4 @@ stable kernels.
>  |                |                 |                 |                         |
>  | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
> +| Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8cc6228..39f2203 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -432,6 +432,17 @@ config CAVIUM_ERRATUM_23154
>  
>  	  If unsure, say Y.
>  
> +config CAVIUM_ERRATUM_27456
> +	bool "Cavium erratum 27456: Broadcast TLBI instructions may cause the icache corruption"

Doesn't really make sense. Maybe just drop the "the"?

> +	default y
> +	help
> +	  On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> +	  instructions may cause the icache to become corrupted if it
> +	  contains data for a non-current ASID.  The fix is to flush
> +	  the icache when changing the mm context.

s/flush/invalidate/

Anyway, the rest of the patch looks fine. I still don't have a good idea
as to whether or not KVM is affected by this, but I guess that's your
problem, so:

Reviewed-by: Will Deacon <will.deacon@arm.com>

(and Catalin, if you pick this up, watch out for the conflicts in
cpufeature.h)

Will
