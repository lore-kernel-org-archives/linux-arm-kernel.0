From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 10 Jan 2013 12:01:44 +0000
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130110120144.GB29952@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 07:20:38PM -0500, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
> 
> This provides helper methods to coordinate between CPUs coming down
> and CPUs going up, as well as documentation on the used algorithms,
> so that cluster teardown and setup
> operations are not done for a cluster simultaneously.
> 
> For use in the power_down() implementation:
>   * __bL_cpu_going_down(unsigned int cluster, unsigned int cpu)
>   * __bL_outbound_enter_critical(unsigned int cluster)
>   * __bL_outbound_leave_critical(unsigned int cluster)
>   * __bL_cpu_down(unsigned int cluster, unsigned int cpu)
> 
> The power_up_setup() helper should do platform-specific setup in
> preparation for turning the CPU on, such as invalidating local caches
> or entering coherency.  It must be assembler for now, since it must
> run before the MMU can be switched on.  It is passed the affinity level
> which should be initialized.
> 
> Because the bL_cluster_sync_struct content is looked-up and modified
> with the cache enabled or disabled depending on the code path, it is
> crucial to always ensure proper cache maintenance to update main memory
> right away.  Therefore, any cached write must be followed by a cache clean
> operation and any cached read must be preceded by a cache invalidate
> operation on the accessed memory.
> 
> To avoid races where a reader would invalidate the cache and discard the
> latest update from a writer before that writer had a chance to clean it
> to RAM, we simply use cache flush (clean+invalidate) operations
> everywhere.
> 
> Also, in order to prevent a cached writer from interfering with an
> adjacent non-cached writer, we ensure each state variable is located to
> a separate cache line.
> 
> Thanks to Nicolas Pitre and Achin Gupta for the help with this
> patch.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  .../arm/big.LITTLE/cluster-pm-race-avoidance.txt   | 498 +++++++++++++++++++++
>  arch/arm/common/bL_entry.c                         | 160 +++++++
>  arch/arm/common/bL_head.S                          |  88 +++-
>  arch/arm/include/asm/bL_entry.h                    |  62 +++
>  4 files changed, 806 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/arm/big.LITTLE/cluster-pm-race-avoidance.txt

[...]

> diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c

[...]

> +int __init bL_cluster_sync_init(void (*power_up_setup)(void))

The addition of the affinity level parameter for power_up_setup means
that this prototype is not correct.

This is not a functional change, since that function is only called from
assembler anyway, but it will help avoid confusion.

This could fixed by folding the following changes into the patch.

Cheers
---Dave

diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
index 1ea4ec9..05cfdd3 100644
--- a/arch/arm/common/bL_entry.c
+++ b/arch/arm/common/bL_entry.c
@@ -245,7 +245,8 @@ int __bL_cluster_state(unsigned int cluster)
 
 extern unsigned long bL_power_up_setup_phys;
 
-int __init bL_cluster_sync_init(void (*power_up_setup)(void))
+int __init bL_cluster_sync_init(
+	void (*power_up_setup)(unsigned int affinity_level))
 {
 	unsigned int i, j, mpidr, this_cluster;
 
diff --git a/arch/arm/include/asm/bL_entry.h b/arch/arm/include/asm/bL_entry.h
index 167394d..c9c29b2 100644
--- a/arch/arm/include/asm/bL_entry.h
+++ b/arch/arm/include/asm/bL_entry.h
@@ -183,7 +183,8 @@ void __bL_outbound_leave_critical(unsigned int cluster, int state);
 bool __bL_outbound_enter_critical(unsigned int this_cpu, unsigned int cluster);
 int __bL_cluster_state(unsigned int cluster);
 
-int __init bL_cluster_sync_init(void (*power_up_setup)(void));
+int __init bL_cluster_sync_init(
+	void (*power_up_setup)(unsigned int affinity_level));
 
 #endif /* ! __ASSEMBLY__ */
 #endif
