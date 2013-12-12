From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 12 Dec 2013 15:13:05 +0800
Subject: [PATCH 1/3] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1386792029-23148-1-git-send-email-broonie@kernel.org>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
Message-ID: <52A96201.509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-12 4:00, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement any topology discovery support since that should be based on
> information from firmware, it merely implements the scaffolding for
> integration of topology support in the architecture.
> 
> The goal is to separate the architecture hookup for providing topology
> information from the DT parsing in order to ease review and avoid
> blocking the architecture code (which will be built on by other work)
> with the DT code review by providing something something simple
> and basic.
> 
> A following patch will implement support for parsing the DT topology
> bindings for ARM, similar patches will be needed for ACPI.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/Kconfig                |   8 +++
>  arch/arm64/include/asm/topology.h |  42 +++++++++++++
>  arch/arm64/kernel/Makefile        |   1 +
>  arch/arm64/kernel/smp.c           |  12 ++++
>  arch/arm64/kernel/topology.c      | 124 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 187 insertions(+)
>  create mode 100644 arch/arm64/include/asm/topology.h
>  create mode 100644 arch/arm64/kernel/topology.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d4dd22ee4b7..c0975fea9bfe 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -154,6 +154,14 @@ config SMP
>  
>  	  If you don't know what to do here, say N.
>  
> +config ARM_CPU_TOPOLOGY
> +	bool "Support CPU topology definition"
> +	depends on SMP
> +	default y
> +	help
> +	  Support CPU topology definition, based on configuration
> +	  provided by the firmware.
> +

The scheduler already used topology and cache sharing when
CONFIG_SCHED_MC and/or CONFIG_SCHED_SMT are enable. can you
add these configs for arm64 so the scheduler can use it?
something like:

+config SCHED_MC
+       bool "Multi-core scheduler support"
+       depends on ARM64_CPU_TOPOLOGY
+       help
+         Multi-core scheduler support improves the CPU scheduler's decision
+         making when dealing with multi-core CPU chips at a cost of slightly
+         increased overhead in some places. If unsure say N here.
+
+config SCHED_SMT
+       bool "SMT scheduler support"
+       depends on ARM64_CPU_TOPOLOGY
+       help
+         Improves the CPU scheduler's decision making when dealing with
+         MultiThreading at a cost of slightly increased overhead in some
+         places. If unsure say N here.
+

Thanks
Hanjun
