From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Fri, 19 May 2017 11:58:03 +0900
Subject: [PATCH v2] printk: Use the main logbuf in NMI when logbuf_lock
 is available
In-Reply-To: <1493912763-24873-1-git-send-email-pmladek@suse.com>
References: <1493912763-24873-1-git-send-email-pmladek@suse.com>
Message-ID: <20170519025803.GA593@jagdpanzerIV.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr,

On (05/04/17 17:46), Petr Mladek wrote:
[..]
> +#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
> +#define PRINTK_NMI_DEFERRED_CONTEXT_MASK 0x40000000
> +#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
[..]
>  void printk_nmi_enter(void)
>  {
> -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	/*
> +	 * The size of the extra per-CPU buffer is limited. Use it only when
> +	 * the main one is locked. If this CPU is not in the safe context,
> +	 * the lock must be taken on another CPU and we could wait for it.
> +	 */
> +	if (raw_spin_is_locked(&logbuf_lock) &&
> +	    this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) {
> +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	} else {
> +		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> +	}
>  }
>  
>  void printk_nmi_exit(void)
>  {
> -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> +	this_cpu_and(printk_context,
> +		     ~(PRINTK_NMI_CONTEXT_MASK ||
> +		       PRINTK_NMI_DEFERRED_CONTEXT_MASK));
>  }

this corrupts `printk_context' on my system and causes all sorts of
problems later.

[   15.784390] BUG: using smp_processor_id() in preemptible [00000000] code: mount/240
[   15.827692] caller is debug_smp_processor_id+0x17/0x19
[   15.871130] Call Trace:
[   15.871130]  dump_stack+0x70/0x9a
[   15.871130]  check_preemption_disabled+0xce/0xe0
[   15.871131]  debug_smp_processor_id+0x17/0x19
[   15.871132]  vprintk_func+0x45/0x96
[   15.871132]  printk+0x43/0x4b
[   15.871132]  __ext4_msg+0x8c/0x99
[   15.871133]  ? trace_hardirqs_on+0xd/0xf
[   15.871133]  ext4_fill_super+0x26fd/0x29f9
[   15.871134]  mount_bdev+0x140/0x195
[   15.871134]  ? ext4_calculate_overhead+0x372/0x372
[   15.871135]  ext4_mount+0x15/0x17
[   15.871135]  mount_fs+0x14/0x74
[   15.871136]  vfs_kern_mount+0x6c/0x153
[   15.871136]  do_mount+0x8bb/0xaf3
[   15.871137]  ? strndup_user+0x3f/0x53
[   15.871137]  SyS_mount+0x77/0x9f
[   15.871138]  entry_SYSCALL_64_fastpath+0x18/0xad



the problem is that

	`PRINTK_NMI_CONTEXT_MASK || PRINTK_NMI_DEFERRED_CONTEXT_MASK' is 0x01

and thus

	printk_context & ~(PRINTK_NMI_CONTEXT_MASK || PRINTK_NMI_DEFERRED_CONTEXT_MASK)

never clears NMI bits:

	83 e0 fe             	and    $0xfffffffe,%eax

while

	printk_context & ~PRINTK_NMI_CONTEXT_MASK
	printk_context & ~PRINTK_NMI_DEFERRED_CONTEXT_MASK

does

	25 ff ff ff 7f       	and    $0x7fffffff,%eax
	25 ff ff ff bf       	and    $0xbfffffff,%eax


as a result vprintk_func() starts to take wrong branches.

adding a simple PRINTK_NMI_DEFERRED_CONTEXT_MASK & preemptible() checks

@@ -375,8 +375,14 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
         * Use the main logbuf when logbuf_lock is available in NMI.
         * But avoid calling console drivers that might have their own locks.
         */
-       if (this_cpu_read(printk_context) & PRINTK_NMI_DEFERRED_CONTEXT_MASK)
+       if (this_cpu_read(printk_context) & PRINTK_NMI_DEFERRED_CONTEXT_MASK) {
+               if (preemptible()) {
+                       WARN_ON_ONCE(1);
+               }
                return vprintk_deferred(fmt, args);
+       }


gives me


[    2.113725] WARNING: CPU: 1 PID: 1 at kernel/printk/printk_safe.c:380 vprintk_func+0x83/0x96
[    2.113727] Modules linked in:
[    2.113738] task: ffff880133160000 task.stack: ffffc90000014000
[    2.113741] RIP: 0010:vprintk_func+0x83/0x96
[    2.113743] RSP: 0018:ffffc90000017a08 EFLAGS: 00010247
[    2.113748] RAX: 0000000000000246 RBX: ffff88012fe25800 RCX: 00000000000000c9
[    2.113750] RDX: 00000000001e3f02 RSI: ffffc90000017a30 RDI: ffffffff817d6c24
[    2.113752] RBP: ffffc90000017a20 R08: 0000000000000001 R09: 0000000000000004
[    2.113755] R10: ffffc90000017a90 R11: 0000000000000000 R12: 0000000000000001
[    2.113757] R13: 0000000000000000 R14: ffffffff817d6c24 R15: 000000ffffffffff
[    2.113759] FS:  0000000000000000(0000) GS:ffff880137c80000(0000) knlGS:0000000000000000
[    2.113762] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.113764] CR2: 00007fad9d078cc4 CR3: 0000000001a0e000 CR4: 00000000000006e0
[    2.113766] Call Trace:
[    2.113771]  printk+0x43/0x4b
[    2.113775]  ? trace_hardirqs_on+0xd/0xf
[    2.113780]  ttm_mem_global_init+0x294/0x2e4
[    2.113785]  nouveau_ttm_mem_global_init+0x12/0x14
[    2.113789]  drm_global_item_ref+0x61/0xca
[    2.113792]  nouveau_ttm_global_init+0x4a/0xe5
[    2.113795]  nouveau_ttm_init+0x231/0x3e1
[    2.113798]  nouveau_drm_load+0x294/0x7ed
[    2.113801]  ? trace_hardirqs_on+0xd/0xf
[    2.113805]  drm_dev_register+0xee/0x1cf
[    2.113808]  drm_get_pci_dev+0xd5/0x143
[    2.113811]  nouveau_drm_probe+0x19b/0x1ba
[    2.113815]  ? __pm_runtime_resume+0x7a/0x87
[    2.113818]  pci_device_probe+0x92/0x106
[    2.113823]  driver_probe_device+0x136/0x292
[    2.113826]  ? set_debug_rodata+0x17/0x17
[    2.113829]  __driver_attach+0x73/0x95
[    2.113832]  ? driver_probe_device+0x292/0x292
[    2.113835]  bus_for_each_dev+0x6f/0x87
[    2.113838]  driver_attach+0x1e/0x20
[    2.113841]  bus_add_driver+0xf6/0x1e6
[    2.113843]  driver_register+0x88/0xbf
[    2.113846]  __pci_register_driver+0x60/0x63
[    2.113849]  ? ttm_init+0x62/0x62
[    2.113852]  drm_pci_init+0x4c/0xcd
[    2.113855]  ? ttm_init+0x62/0x62
[    2.113857]  ? set_debug_rodata+0x17/0x17
[    2.113860]  nouveau_drm_init+0x1e5/0x1e7
[    2.113863]  do_one_initcall+0x90/0x126
[    2.113866]  kernel_init_freeable+0x13e/0x1c7
[    2.113870]  ? rest_init+0x132/0x132
[    2.113873]  kernel_init+0xe/0xf0
[    2.113876]  ret_from_fork+0x2e/0x40
[    2.113879] Code: 89 f2 48 89 fe 48 89 df e8 b3 fd ff ff eb 2a 0f ba e0 1e 73 1f 65 8b 05 cc e6 f7 7e a9 ff ff ff 7f 75 0a 9c 58 0f ba e0 09 73 02 <0f> ff e8 2d f4 ff ff eb 05 e8 39 ee ff ff 5a 59 5b 5d c3 66 66 
[    2.114004] ---[ end trace 2b87962b417834f1 ]---

	-ss
