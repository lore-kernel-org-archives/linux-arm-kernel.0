From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 21 Oct 2010 03:52:09 +0200
Subject: at91sam9g20 hangs at ohci-hcd
In-Reply-To: <4CBDAA96.5060107@googlemail.com>
References: <4CBDAA96.5060107@googlemail.com>
Message-ID: <20101021015209.GB18622@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	IIRC it could be that the controler was used in the bootloader and not
	stop before jump to linux

Best Regards,
J.
On 16:26 Tue 19 Oct     , Dennis Borgmann wrote:
> Hello linux-arm list!
> 
> I am using an at91sam9g20-CPU on an "eddy-Board Version 2.5" from a
> company called "Systembase" - see http://www.embeddedmodule.com
> 
> I am booting my system via u-boot http://www.denx.de/wiki/U-Boot
> 
> The problem that I see is, that the kernel won't boot up to a login
> prompt, it simply hangs at the point, where it loads the USB driver
> 'ohci-hcd'. The last output I get from the kernel booting messages are
> appended below at the end of this mail.
> 
> After searching the internet for two days now, I have given up the idea
> to solve the problem on my own. The problem seems to be known to the
> linux community, as I can find a link on this:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=11041
> 
> People are talking about an endless loop involving modprobe at a certain
> point and the solution for them is to revert a previous commit to their
> code repository. This has been going on in 2008. Now, we have 2010 and I
> would suggest this problem being solved. But still I cannot get the
> board running.
> 
> If I switch to an older release of the board - version 2.1, which
> contains an at91sam9260 - everything works fine. The problem appears
> with at91sam9g20.
> 
> I am building my system with buildroot - http://buildroot.uclibc.org/ -
> , tried already several kernels (2.6.25.20, 2.6.27.54, 2.6.33.7 and
> 2.6.34.3) but none of them worked. I also tried giving buildroot a
> kernel path from this webpage:
> 
> http://maxim.org.za/at91_26.html
> 
> For a first test, I chose version 2.6.33, which did not solve my problem
> either.
> 
> The code seems to hang in ohci-at91.c (for example located here:
> linux-2.6.33.7/drivers/usb/host/ ) in function 'static void
> at91_start_hc(struct platform_device *pdev)' . It can get up to line 69
> ( 'writel(0, &regs->control);' ), but this call does not return. I found
> this out by giving the code several printk's.
> 
> There is no difference, if I compile the driver as module or directly
> into the kernel. Either it hangs on boot-time or it hangs, when I do
> 'modprobe ohci-hcd'.
> 
> I don't know any more things to do. Could you give me hint, where to
> search for my problem? It would be nice to be able to use kernel 2.6.34
> due to wireless demands.
> 
> Kind regards from Germany,
> Dennis
> 
> Here is the output of the kernel at boot-time until it hangs:
> 
> [    0.000000] Initializing cgroup subsys
> cpuset
> [    0.000000] Linux version 2.6.33.7 (dborgmann at countach) (gcc version
> 4.3.5 (0
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ),
> cr=00053177
> [    0.000000] CPU: VIVT data cache, VIVT instruction
> cache
> [    0.000000] Machine: Atmel
> AT91SAM9260-EK
> [    0.000000] Memory policy: ECC disabled, Data cache
> writeback
> [    0.000000] Clocks: PLLA overclocked, 792
> MHz
> [    0.000000] Clocks: CPU 396 MHz, master 132 MHz, main 18.432
> MHz
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pa8
> [    0.000000] Kernel command line: root=/dev/ram rw
> console=ttyS0,115200,mem=3
> [    0.000000] PID hash table entries: 128 (order: -3, 512
> bytes)
> [    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384
> bytes)
> [    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192
> bytes)
> [    0.000000] allocated 163840 bytes of
> page_cgroup
> [    0.000000] please try 'cgroup_disable=memory' option if you don't
> want memos
> [    0.000000] Memory: 32MB = 32MB
> total
> [    0.000000] Memory: 28332KB available (3108K code, 519K data, 112K
> init, 0K )
> [    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0,
> CPUs=1, 1
> [    0.000000] Hierarchical RCU
> implementation.
> [    0.000000]
> NR_IRQS:192
> [    0.000000] AT91: 96 gpio irqs in 3
> banks
> [    0.000000] Console: colour dummy device
> 80x30
> [    0.000000] console [ttyS0]
> enabled
> [    0.130000] Calibrating delay loop... 197.83 BogoMIPS
> (lpj=989184)
> [    0.340000] Mount-cache hash table entries:
> 512
> [    0.340000] Initializing cgroup subsys
> ns
> [    0.350000] Initializing cgroup subsys
> cpuacct
> [    0.350000] Initializing cgroup subsys
> memory
> [    0.360000] Initializing cgroup subsys
> freezer
> [    0.360000] CPU: Testing write buffer coherency:
> ok
> [    0.380000] bio: create slab <bio-0> at
> 0
> [    0.390000] SCSI subsystem
> initialized
> [    0.390000] usbcore: registered new interface driver
> usbfs
> [    0.400000] usbcore: registered new interface driver
> hub
> [    0.400000] usbcore: registered new device driver
> usb
> [    0.410000] Advanced Linux Sound Architecture Driver Version
> 1.0.21.
> [    0.420000] Switching to clocksource
> pit
> [    0.430000] Slow work thread pool: Starting
> up
> [    0.440000] Slow work thread pool:
> Ready
> [    0.440000] FS-Cache:
> Loaded
> [    0.440000] CacheFiles:
> Loaded
> [    0.450000] NetWinder Floating Point Emulator V0.97 (double
> precision)
> [    0.470000] NTFS driver 2.1.29 [Flags:
> R/W].
> [    0.480000] ROMFS MTD (C) 2007 Red Hat,
> Inc.
> [    0.480000] msgmni has been set to
> 55
> [    0.490000] io scheduler noop
> registered
> [    0.490000] io scheduler cfq registered
> (default)
> [    0.970000] atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a
> ATMEL_SERL
> [    0.980000] atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq = 6) is a
> ATMEL_SERL
> [    0.990000] atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a
> ATMEL_SERL
> [    1.010000] brd: module
> loaded
> [    1.010000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
