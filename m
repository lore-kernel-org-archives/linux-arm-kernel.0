From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sat, 14 May 2011 22:43:53 +0200
Subject: Kernel oops with undefined instruction when accessing memory
	on an	AT91 custom system
In-Reply-To: <4DCEADB5.9010905@usask.ca>
References: <4DCEADB5.9010905@usask.ca>
Message-ID: <4DCEE989.4000401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicholas Kinar a ?crit :
> Hello,
> 
> I've recently designed an embedded system with an AT91SAM9RL processor. 
> This is an ARM9 processor.  The hardware of the embedded system is 
> similar to the AT91SAM9RL-EK evaluation kit with board support already 
> in the Linux kernel 
> (linux-kernel/linux-2.6.37/arch/arm/mach-at91/board-sam9rlek.c). There 
> is 64 MB of physical memory.  I've used AT91bootstrap to bypass the 
> crystals and I've provided an external clock signal (12.0 MHz) as the 
> main input clock.  The external clock signal is fine, and is the same 
> frequency as the crystal on the AT91SAM9RL-EK board.
> 
> I've downloaded and built the memtest suite found here 
> (http://www.arm.linux.org.uk/developer/stresstests.php).  I've been 
> building both the Linux kernel (linux-2.6.37) and the memtest suite 
> using the arm-linux-gcc compiler shipped with buildroot.2011.02.  The 
> specs of this particular compiler can be found below:
> 
> arm-linux-gcc -v
> Using built-in specs.
> Target: arm-unknown-linux-uclibcgnueabi
> Configured with: 
> /media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/toolchain/gcc-4.3.5/configure 
> --prefix=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr 
> --build=x86_64-unknown-linux-gnu --host=x86_64-unknown-linux-gnu 
> --target=arm-unknown-linux-uclibcgnueabi --enable-languages=c,c++ 
> --with-sysroot=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr/arm-unknown-linux-uclibcgnueabi/sysroot 
> --with-build-time-tools=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr/arm-unknown-linux-uclibcgnueabi/bin 
> --disable-__cxa_atexit --enable-target-optspace --with-gnu-ld 
> --disable-libssp --disable-multilib --disable-tls --disable-shared 
> --with-gmp=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr 
> --with-mpfr=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr 
> --enable-threads --disable-decimal-float --with-float=soft 
> --with-abi=aapcs-linux --with-arch=armv5te --with-tune=arm926ej-s 
> --with-pkgversion='Buildroot 2011.02' 
> --with-bugurl=http://bugs.buildroot.net/ : (reconfigured) 
> /media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/toolchain/gcc-4.3.5/configure 
> --prefix=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr 
> --build=x86_64-unknown-linux-gnu --host=x86_64-unknown-linux-gnu 
> --target=arm-unknown-linux-uclibcgnueabi --enable-languages=c,c++ 
> --with-sysroot=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr/arm-unknown-linux-uclibcgnueabi/sysroot 
> --with-build-time-tools=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr/arm-unknown-linux-uclibcgnueabi/bin 
> --disable-__cxa_atexit --enable-target-optspace --with-gnu-ld 
> --disable-libssp --disable-multilib --disable-tls --disable-shared 
> --with-gmp=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr 
> --with-mpfr=/media/RESEARCH/DEVICE-CODE/buildroot-heat-probe/buildroot-2011.02/output/host/usr 
> --enable-threads --disable-decimal-float --with-float=soft 
> --with-abi=aapcs-linux --with-arch=armv5te --with-tune=arm926ej-s 
> --with-pkgversion='Buildroot 2011.02' 
> --with-bugurl=http://bugs.buildroot.net/
> Thread model: posix
> gcc version 4.3.5 (Buildroot 2011.02)
> 
> 
> When running the memtest program on the embedded ARM system, I receive 
> the following kernel oops that complains about an undefined 
> instruction.  I've tested SDRAM memory using "bare-metal" non-Linux 
> programs loaded over JTAG, and it seems that I can successfully write 
> and read any values into all memory addresses.
> 
> I've had a number of random kernel oops when trying to use the AT91 mmc 
> driver with an SD card, but when running the memtest program, I receive 
> the following undefined instruction (that often repeats in a similar and 
> continuous fashion):
> 
> # ./mtest
> Starting test run with 8 megabyte heap.
> Setting up 2048 4096kB pages for test...Internal error: Oops - undefined 
> instruction: 0 [#1]
> last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
> Modules linked in:
> CPU: 0    Not tainted  (2.6.37 #15)
> PC is at v5tj_early_abort+0x0/0x38
> LR is at __dabt_usr+0x38/0x60
> pc : [<c0028d20>]    lr : [<c0021c58>]    psr: 00000093
> sp : c3ae5fb0  ip : 00012008  fp : 00011664
> r10: 00011638  r9 : 00011630  r8 : 00011644
> r7 : 00011634  r6 : 00011678  r5 : 00011670  r4 : ffffffff
> r3 : 80000010  r2 : 00008e78  r1 : 4019a008  r0 : 00053177
> Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005317f  Table: 23090000  DAC: 00000015
> Process mtest (pid: 873, stack limit = 0xc3ae4270)
> Stack: (0xc3ae5fb0 to 0xc3ae6000)
> 5fa0:                                     4019a008 000002a8 002a8000 
> 00001000
> 5fc0: 0001166c 00011670 00011678 00011634 00011644 00011630 00011638 
> 00011664
> 5fe0: 00012008 bec59d10 40178a64 00008e78 80000010 ffffffff 238633c4 
> 94cc31cc
> [<c0028d20>] (v5tj_early_abort+0x0/0x38) from [<00011664>] (0x11664)
> Code: 00000000 00000000 00000000 00000000 (ee150000)
> ---[ end trace 88c1fe1db84a9172 ]---
> 
> Here is my attempt at deciphering the oops file:
> 
> nkinar at matilda:/media/RESEARCH/DEVICE-CODE/oops-reports$ ksymoops -k 
> ./kallsyms -l ./modules --no-object -m ./System.map < oops.txt
> ksymoops 2.4.11 on x86_64 2.6.32-31-generic.  Options used
>      -V (default)
>      -k ./kallsyms (specified)
>      -l ./modules (specified)
>      -O (specified)
>      -m ./System.map (specified)
> 
> Warning (read_ksyms): no kernel symbols in ksyms, is ./kallsyms a valid 
> ksyms file?
> No ksyms, skipping lsmod
> CPU: 0    Not tainted  (2.6.37 #15)
> pc : [<c0028d20>]    lr : [<c0021c58>]    psr: 00000093
> Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
> sp : c3ae5fb0  ip : 00012008  fp : 00011664
> r10: 00011638  r9 : 00011630  r8 : 00011644
> r7 : 00011634  r6 : 00011678  r5 : 00011670  r4 : ffffffff
> r3 : 80000010  r2 : 00008e78  r1 : 4019a008  r0 : 00053177
> Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005317f  Table: 23090000  DAC: 00000015
> Stack: (0xc3ae5fb0 to 0xc3ae6000)
> 5fa0:                                     4019a008 000002a8 002a8000 
> 00001000
> 5fc0: 0001166c 00011670 00011678 00011634 00011644 00011630 00011638 
> 00011664
> 5fe0: 00012008 bec59d10 40178a64 00008e78 80000010 ffffffff 238633c4 
> 94cc31cc
> [<c0028d20>] (v5tj_early_abort+0x0/0x38) from [<00011664>] (0x11664)
> Code: 00000000 00000000 00000000 00000000 (ee150000)
> 
> 
>  >>LR;  00000000c0021c58 <__dabt_usr+38/60>
> 
>  >>RIP; 00000000c0028d20 <v5tj_early_abort+0/38> <=====
> 
> Code;  00000000c0028d10 <do_alignment_ldmstm+228/238>
> 0000000000000000 <_RIP>:
> Code;  00000000c0028d20 <v5tj_early_abort+0/38> <=====
>   10:   00 00                     add    %al,(%rax) <=====
> Code;  00000000c0028d22 <v5tj_early_abort+2/38>
>   12:   15 ee 00 00 00            adc    $0xee,%eax
> 
> 
> 1 warning issued.  Results may not be reliable.
> 
> 
> Looking at the source code of the mtest program, it appears that the 
> oops occurs around lines 134-135 of memtest.c when safe_malloc() is called.
> 
> What could be the problem here, and is there anything that I can do to 
> rectify it?  Is there a possibility of changing anything in the Linux 
> kernel config to stop (or at least minimize) the problem from 
> occurring?  Alternately, is there a "known-good" configuration that I 
> can use to rectify what is happening?

Just a piece of advice about the hardware :

0/ can you tell us if the very same kernel revision and memtest goes 
smoothly on an Atmel at91sam9rl-ek board (the Evaluation Kit): if you 
have one...
1/ try to test the same condition with another hardware. If you built 
several of your custom hardware, running on another chip / board can 
give clues
2/ try the same test with caches disabled (kernel configuration option). 
That can also give you an idea about the software/hardware location of 
the issue: be aware that a cache enabled ARM9 does more demanding 
accesses to the external SDRAM: that can highlight some routing / noise 
issues.

> I've tried a number of different kernels, including linux-2.6.39-rc6 and 
> the official ARM kernel pulled from git.  I've also tried building with 
> the arm-none-linux-gnueabi-gcc from CodeSourcery, but similar problems 
> still arise.

You can test a proven kernel going to www.linux4sam.org: but you will 
need the at91sam9rl-ek to use the binary provided there (sources 
available also of course).

Best regards,
-- 
Nicolas Ferre
