From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 17 Aug 2015 10:00:53 -0700
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <1439576885-15621-3-git-send-email-rric@kernel.org>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
Message-ID: <55D21345.3040903@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2015 11:28 AM, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
>
> This patch implements Cavium ThunderX erratum 23154.
>
> The gicv3 of ThunderX requires a modified version for reading the IAR
> status to ensure data synchronization. Since this is in the fast-path
> and called with each interrupt, runtime patching is used using jump
> label patching for smallest overhead (no-op). This is the same
> technique as used for tracepoints.
>
> v4:
>   * simplify code to only use cpus_have_cap() in gicv3_enable_quirks()
>
> v3:
>   * fix erratum to be dependend from midr
>   * use arm64 errata framework
>
> v2:
>   * implement code in a single asm() to keep instruction sequence
>   * added comment to the code that explains the erratum
>   * apply workaround also if running as guest, thus check MIDR
>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>   arch/arm64/Kconfig                  | 11 ++++++++++
>   arch/arm64/include/asm/cpufeature.h |  3 ++-
>   arch/arm64/include/asm/cputype.h    | 18 +++++++++-------
>   arch/arm64/kernel/cpu_errata.c      |  9 ++++++++
>   drivers/irqchip/irq-gic-v3.c        | 42 ++++++++++++++++++++++++++++++++++++-
>   5 files changed, 74 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0f6edb14b7e4..4f866a4c6536 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -417,6 +417,17 @@ config ARM64_ERRATUM_845719
>
>   	  If unsure, say Y.
>
> +config CAVIUM_ERRATUM_23154
> +	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
> +	depends on ARCH_THUNDER

None of the other errata depend on a specific ARCH_*.  I think we should 
remove this 'depends on', so that a generic kernel can be configured to 
work on Thunder without having to first select ARCH_THUNDER.

David Daney


> +	default y
> +	help
> +	  The gicv3 of ThunderX requires a modified version for
> +	  reading the IAR status to ensure data synchronization
> +	  (access to icc_iar1_el1 is not sync'ed before and after).
> +
> +	  If unsure, say Y.
> +
>   endmenu
>
>
>
