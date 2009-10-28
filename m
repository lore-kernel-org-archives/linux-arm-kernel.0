From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 15:30:17 +0000
Subject: smdk6400/S3C6400 failure on execution of init process
In-Reply-To: <20091028162037.22f2cb22@linpcd55>
References: <20091028162037.22f2cb22@linpcd55>
Message-ID: <20091028153010.GE8096@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 04:20:37PM +0100, Markus Schwarzenberg wrote:
> 
> booting linux-2.6.32-rc5 on our smdk6400 (S3C6400) fails somewhere in/after 
> the asm call in arch/arm/kernel/sys_arm.c:kernel_execve, when the init 
> process is to be run.

Which is the last kernel version that ran this ok?
 
> The preceding do_execve returned OK, which suggests that the /init file is 
> found, executable etc. in rootfs. 
> 
> The failure happens for both booting from  sd-card as well as from initramfs.
> I've tried several /init applications, from busybox to a simple wait(1); loop
> all with the same behavior.
> 
> What's the best way to debug this?
> 
> Messages (first two lines from additional diagnostics in 
>           do_execve [**] / kernel_execve [*] ):

Does the kernel have vfp support compiled in?
 
>   do_execve (/endless-loop-nonstatic-arm) succeeded
>   kernel_execve calling asm
>   mmc0: starting CMD18 arg 30868800 flags 000000b5
>   mmc0:     blksz 512 blocks 72 flags 00000200 tsac 100 ms nsac 0
>   mmc0:     CMD12 arg 00000000 flags 0000049d
>   sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>   sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
>   sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>   mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>   mmc0:     36864 bytes transferred: 0
>   mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000

The SD card read seems to have gone ok.

>   Kernel panic - not syncing: Attempted to kill init!
>   Backtrace: 
>   [<c002a9f0>] (dump_backtrace+0x0/0x114) from [<c0275358>]
>   (dump_stack+0x18/0x1c)
>    r7:c781ff64 r6:c781d900 r5:c781d900 r4:c034201c
>   [<c0275340>] (dump_stack+0x0/0x1c) from [<c02753a8>] (panic+0x4c/0x11c)
>   [<c027535c>] (panic+0x0/0x11c) from [<c0048990>] (do_exit+0x74/0x5b4)
>    r3:c032a428 r2:c781d900 r1:c781fc28 r0:c02df366
>   [<c004891c>] (do_exit+0x0/0x5b4) from [<c0048f54>]
>   (do_group_exit+0x84/0xb8)
>   [<c0048ed0>] (do_group_exit+0x0/0xb8) from [<c0052cc8>]
>   (get_signal_to_deliver+0x2b8/0x2e8)
>    r4:00000004
>   [<c0052a10>] (get_signal_to_deliver+0x0/0x2e8) from [<c00291c0>]
>   (do_notify_resume+0x64/0x5b8)
>   [<c002915c>] (do_notify_resume+0x0/0x5b8) from [<c0026f2c>]
>   (work_pending+0x1c/0x20)
> 
> 
> Regards,
> 
> Markus Schwarzenberg
> 
> [*] additional messages generated in kernel_execve
> 
> --- linux-2.6.32-rc5.orig/arch/arm/kernel/sys_arm.c     2009-10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5/arch/arm/kernel/sys_arm.c  2009-10-28 16:11:25.000000000 +0100
> @@ -265,6 +265,7 @@
>         struct pt_regs regs;
>         int ret;
>  
> +       printk("kernel_execve %s\n", filename);
>         memset(&regs, 0, sizeof(struct pt_regs));
>         ret = do_execve((char *)filename, (char __user * __user *)argv,
>                         (char __user * __user *)envp, &regs);
> @@ -275,6 +276,7 @@
>          * Save argc to the register structure for userspace.
>          */
>         regs.ARM_r0 = ret;
> +       printk("kernel_execve calling asm\n");
>  
>         /*
>          * We were successful.  We won't be returning to our caller, but
> @@ -296,6 +298,7 @@
>                 : "r0", "r1", "r2", "r3", "ip", "lr", "memory");
>  
>   out:
> +       printk("kernel_execve return\n");
>         return ret;
>  }
>  EXPORT_SYMBOL(kernel_execve);
> 
> [**] additional messages generated in do_execve
> 
> --- linux-2.6.32-rc5.orig/fs/exec.c  2009-10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5/fs/exec.c  2009-10-28 10:20:46.000000000 +0100
> @@ -1362,6 +1362,7 @@
>         current->stack_start = current->mm->start_stack;
>  
>         /* execve succeeded */
> +       printk("do_execve (%s) succeeded\n", filename);
>         current->fs->in_exec = 0;
>         current->in_execve = 0;
>         acct_update_integrals(current);
> @@ -1392,6 +1393,7 @@
>         if (displaced)
>                 reset_files_struct(displaced);
>  out_ret:
> +       printk("do_execve (%s) had errors\n", filename);
>         return retval;
>  }
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
