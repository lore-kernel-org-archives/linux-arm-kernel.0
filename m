From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Aug 2018 15:50:53 +0100
Subject: [RESEND PATCH v10 1/6] arm: arm64: introduce
 CONFIG_HAVE_MEMBLOCK_PFN_VALID
In-Reply-To: <1530867675-9018-2-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-2-git-send-email-hejianet@gmail.com>
Message-ID: <20180817145052.aizhi6n66vxblriq@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 05:01:10PM +0800, Jia He wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..26d75f4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -778,6 +778,10 @@ config ARCH_SELECT_MEMORY_MODEL
>  config HAVE_ARCH_PFN_VALID
>  	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>  
> +config HAVE_MEMBLOCK_PFN_VALID
> +	def_bool y
> +	depends on HAVE_ARCH_PFN_VALID
> +
>  config HW_PERF_EVENTS
>  	def_bool y
>  	depends on ARM_PMU
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 94af022..28fcf54 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
>  config HAVE_MEMBLOCK_PHYS_MAP
>  	bool
>  
> +config HAVE_MEMBLOCK_PFN_VALID
> +	bool

Since you defined HAVE_MEMBLOCK_PFN_VALID here, do we need to define it
in the arch code as well? If kept it in the mm/Kconfig only, you could
just select it in the arch HAVE_ARCH_PFN_VALID entry:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d0a53cc6293a..cd230c77e122 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -787,6 +787,7 @@ config ARCH_FLATMEM_ENABLE
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	select HAVE_MEMBLOCK_PFN_VALID
 
 config HW_PERF_EVENTS
 	def_bool y

(similarly for arch/arm)

-- 
Catalin
