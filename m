From: schwarzb@ipms.fraunhofer.de (Markus Schwarzenberg)
Date: Wed, 28 Oct 2009 16:59:49 +0100
Subject: smdk6400/S3C6400 failure on execution of init process
In-Reply-To: <20091028153916.GB2244@debian>
References: <20091028162037.22f2cb22@linpcd55> <20091028153916.GB2244@debian>
Message-ID: <20091028165949.593b4d04@linpcd55>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2009 21:09:16 +0530 Rabin Vincent <rabin@rab.in> wrote:

> On Wed, Oct 28, 2009 at 04:20:37PM +0100, Markus Schwarzenberg wrote:
> > 
> > booting linux-2.6.32-rc5 on our smdk6400 (S3C6400) fails somewhere in/after 
> > the asm call in arch/arm/kernel/sys_arm.c:kernel_execve, when the init 
> > process is to be run.
> > 
> > The preceding do_execve returned OK, which suggests that the /init file is 
> > found, executable etc. in rootfs. 
> > 
> > The failure happens for both booting from  sd-card as well as from initramfs.
> > I've tried several /init applications, from busybox to a simple wait(1); loop
> > all with the same behavior.
> > 
> > What's the best way to debug this?
> 
> As a first step, enable CONFIG_DEBUG_USER in your kernel and pass
> "user_debug=31" on the kernel command line.  You'll get more info about
> why init's being killed.

thanks, did this, the additional messages are (context see [*]):

  [1] endless-loop-no: obsolete system call 00000000.
  Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01) 

Still have to investigate how to interpret this...

--
Markus Schwarzenberg

[*]


mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
do_execve (/endless-loop-nonstatic-arm) succeeded
kernel_execve calling asm
mmc0: starting CMD18 arg 30868800 flags 000000b5
mmc0:     blksz 512 blocks 72 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc0:     36864 bytes transferred: 0
mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[1] endless-loop-no: obsolete system call 00000000.
Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01) 
Kernel panic - not syncing: Attempted to kill init!
Backtrace: 
[<c002a9f0>] (dump_backtrace+0x0/0x114) from [<c0275358>] (dump_stack+0x18/0x1c)
 r7:c781ff64 r6:c781d900 r5:c781d900 r4:c034201c
[<c0275340>] (dump_stack+0x0/0x1c) from [<c02753a8>] (panic+0x4c/0x11c)
[<c027535c>] (panic+0x0/0x11c) from [<c0048990>] (do_exit+0x74/0x5b4)
 r3:c032a428 r2:c781d900 r1:c781fc28 r0:c02df366
[<c004891c>] (do_exit+0x0/0x5b4) from [<c0048f54>] (do_group_exit+0x84/0xb8)
[<c0048ed0>] (do_group_exit+0x0/0xb8) from [<c0052cc8>] (get_signal_to_deliver+0x2b8/0x2e8)
 r4:00000004
[<c0052a10>] (get_signal_to_deliver+0x0/0x2e8) from [<c00291c0>] (do_notify_resume+0x64/0x5b8)
[<c002915c>] (do_notify_resume+0x0/0x5b8) from [<c0026f2c>] (work_pending+0x1c/0x20)
