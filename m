From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 27 Apr 2017 18:03:35 +0100
Subject: [PATCH] arm64: cpufeature: use static_branch_enable_cpuslocked()
In-Reply-To: <20170427163546.GA30972@e107814-lin.cambridge.arm.com>
References: <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
 <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
 <20170426103236.GI27156@leverpostej>
 <20170427082719.3wyru4bk67kdmflb@linutronix.de>
 <20170427095744.GB31337@leverpostej>
 <alpine.DEB.2.20.1704271200420.4607@nanos>
 <20170427123056.GD31337@leverpostej> <20170427154806.GA6646@leverpostej>
 <20170427163546.GA30972@e107814-lin.cambridge.arm.com>
Message-ID: <2e321402-7042-9d5b-aa85-52b0e6f1e20c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/17 17:35, Suzuki K Poulose wrote:
> rom f3b0809224e4915197d3ae4a38ebe7f210e74abf Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Thu, 27 Apr 2017 16:48:06 +0100
> Subject: [PATCH] arm64: cpufeature: use static_branch_enable_cpuslocked()
>

Build break alert. There are some issues with patch below.

>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki Poulose <suzuki,poulose@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  5 +++--
>  arch/arm64/kernel/cpu_errata.c      | 13 ++++++++++++-
>  arch/arm64/kernel/cpufeature.c      |  5 ++++-
>  arch/arm64/kernel/smp.c             |  7 +++----
>  4 files changed, 22 insertions(+), 8 deletions(-)
>


>  void __init enable_errata_workarounds(void)
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 94b8f7f..62bdab4 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -966,6 +966,7 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
>  			cap_set_elf_hwcap(hwcaps);
>  }
>
> +/* Should be called with CPU hotplug lock held */
>  void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>  			    const char *info)
>  {
> @@ -1092,7 +1093,9 @@ void check_local_cpu_capabilities(void)
>
>  static void __init setup_feature_capabilities(void)
>  {
> -	update_cpu_capabilities(arm64_features, "detected feature:");
> +	get_online_cpus();
> +	update_cpu_capabilities(arm6_features, "detected feature:");

s/arm6_features/arm64_features

And we need the following hunk:

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 62bdab4..19c359a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1086,7 +1086,7 @@ void check_local_cpu_capabilities(void)
          * advertised capabilities.
          */
         if (!sys_caps_initialised)
-               update_cpu_errata_workarounds();
+               update_secondary_cpu_errata_workarounds();
         else
                 verify_local_cpu_capabilities();
  }

Sorry about that.

Suzuki
