From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jun 2016 15:39:39 +0100
Subject: [PATCH v20 04/14] arm64/kexec: Add core kexec support
In-Reply-To: <57710B92.2080603@arm.com>
References: <cover.1466702804.git.geoff@infradead.org>
 <018ac873d87fbfc45185cdab91ebc8731f64f94c.1466702804.git.geoff@infradead.org>
 <57710B92.2080603@arm.com>
Message-ID: <20160627143939.GC6847@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 12:18:42PM +0100, James Morse wrote:
> On 23/06/16 18:54, Geoff Levand wrote:
> > "Can't kexec: secondary CPUs are stuck in the kernel.\n"
> 
> > +			return -EBUSY;
> > +		}
> > +
> 
> > +		if (num_online_cpus() > 1) {
> > +			if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> > +				/* any_cpu as we don't mind being preempted */
> > +				int any_cpu = raw_smp_processor_id();
> > +
> > +				if (cpu_ops[any_cpu]->cpu_die)
> > +					return 0;
> > +			}
> > +
> > +			pr_err("Can't kexec: no mechanism to offline secondary CPUs.\n");
> > +			return -EBUSY;
> > +		}
> 
> This if() {} hunk isn't necessary with the version of cpus_are_stuck_in_kernel()
> you have in patch 2. This logic is the '|| smp_spin_tables' part of that helper
> function. (hibernate needed it too)

I can make the changes locally but just to be clear I understand what
you meant, here's the diff on top of Geoff's patch:

----8<-------------------------

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 945ce326654c..bc96c8a7fc79 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -68,24 +68,9 @@ int machine_kexec_prepare(struct kimage *kimage)
 
 	kexec_image_info(kimage);
 
-	if (kimage->type != KEXEC_TYPE_CRASH) {
-		if (cpus_are_stuck_in_kernel()) {
-			pr_err("Can't kexec: failed CPUs are stuck in the kernel.\n");
-			return -EBUSY;
-		}
-
-		if (num_online_cpus() > 1) {
-			if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
-				/* any_cpu as we don't mind being preempted */
-				int any_cpu = raw_smp_processor_id();
-
-				if (cpu_ops[any_cpu]->cpu_die)
-					return 0;
-			}
-
-			pr_err("Can't kexec: no mechanism to offline secondary CPUs.\n");
-			return -EBUSY;
-		}
+	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
+		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
+		return -EBUSY;
 	}
 
 	return 0;
@@ -163,7 +148,7 @@ void machine_kexec(struct kimage *kimage)
 	/*
 	 * New cpus may have become stuck_in_kernel after we loaded the image.
 	 */
-	BUG_ON(cpus_are_stuck_in_kernel() && (num_online_cpus() > 1));
+	BUG_ON(cpus_are_stuck_in_kernel() || (num_online_cpus() > 1));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
