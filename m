From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Apr 2013 16:03:45 -0400 (EDT)
Subject: [PATCH v6 3/4] ARM: Enable selection of SMP operations at boot
 time
In-Reply-To: <1365167495-18508-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.LFD.2.03.1304091600330.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Stefano Stabellini wrote:

> From: Jon Medhurst <tixy@linaro.org>
> 
> Add a new 'smp_init' hook to machine_desc so platforms can specify a
> function to be used to setup smp ops instead of having a statically
> defined value.
> 
> If smp_init is set, use it instead of psci_smp_ops or mdesc->smp.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/include/asm/mach/arch.h |    3 +++
>  arch/arm/kernel/setup.c          |    4 +++-
>  2 files changed, 6 insertions(+), 1 deletions(-)

Please use this version instead.  The runtime hook may now indicate if 
it did initialize smp_ops or not.

----- >8
From: Jon Medhurst <tixy@linaro.org>
Date: Thu, 13 Dec 2012 13:23:13 +0000
Subject: [PATCH] ARM: Enable selection of SMP operations at boot time

Add a new 'smp_init' hook to machine_desc so platforms can specify a
function to be used to setup smp ops instead of having a statically
defined value.  The hook must return true when smp_ops are initialized.
If false the static mdesc->smp_ops will be used by default.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 308ad7d6f9..af8c54c6c6 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -16,8 +16,10 @@ struct pt_regs;
 struct smp_operations;
 #ifdef CONFIG_SMP
 #define smp_ops(ops) (&(ops))
+#define smp_init_ops(ops) (&(ops))
 #else
 #define smp_ops(ops) (struct smp_operations *)NULL
+#define smp_init_ops(ops) (bool (*)(void))NULL
 #endif
 
 struct machine_desc {
@@ -41,6 +43,7 @@ struct machine_desc {
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	char			restart_mode;	/* default restart mode	*/
 	struct smp_operations	*smp;		/* SMP operations	*/
+	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2e3e..cf4b08c0f9 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -768,7 +768,8 @@ void __init setup_arch(char **cmdline_p)
 	arm_dt_init_cpu_maps();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
-		smp_set_ops(mdesc->smp);
+		if (!mdesc->smp_init || !mdesc->smp_init())
+			smp_set_ops(mdesc->smp);
 		smp_init_cpus();
 	}
 #endif
