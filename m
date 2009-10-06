From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Tue, 6 Oct 2009 17:08:24 +0200
Subject: i.MX31 kernel panic and irq
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi @ all :-)

This is about a kernel panic I'm experiencing / causing.
Setup: The system is a DENX QONG EVB-Light. I consists of an i.MX31
(ARM11) + some flash and an FPGA doing eth. I use a rootfs over NFS
and the kernel is loaded from tftp. Version 2.6.31 (pulled from
DENX, which should be equal to the one from kernel.org)
So inside my kernel module I do that:
	
unsigned char my_dev; /* needed for the irq requesting */		
static int __init mod_init(void){	
	int gpio_1_irq=-1;
	if ( mxc_iomux_alloc_pin( IOMUX_MODE(MX31_PIN_CSI_D4,IOMUX_CONFIG_GPIO),\
			"GPIO" ) !=0 ){
		printk( " [MX31_PIN_CSI_D4=>GPIO:FAILED]\n");
		MY_EXIT(-EIO);
	}
	/* work around -> */
	gpio_request(IOMUX_TO_GPIO(MX31_PIN_CSI_D4), "GPIO" ) 
	/* <- work around */

	if ( gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_CSI_D4)) !=0 ){
		printk(" [MX31_PIN_CSI_D4=>IN:FAILED]\n");
		MY_EXIT(-EIO);
	} 
			
	gpio_1_irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_CSI_D4));
	printk( "Reqesting GPIO-IRQ %d ... ", gpio_1_irq );
	if ( request_irq(gpio_1_irq,my_isr,IRQF_DISABLED,MY_DRV_NAME,&my_dev) ){
		printk( "failed!\n" );
		MY_EXIT(-EIO);
	}
}

the 'my_isr' looks like that:

static irqreturn_t my_isr( int irq, void * dev_id){
	return IRQ_HANDLED;
}

Next I tested the irq, by `watch cat /proc/interrupts` and shorting the
pin with a wire, to GND. -> works fine :-)

But I get a kernel panic when touching the pin with bare hands
(immediately after touching it). This works every time I touch that pin.
If I unload the module (which frees the irq in the deinit routine)
I can touch that pin freely, without crashing the kernel:


------------[ cut here ]------------
WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0x88()
Modules linked in: test_drv
[<c002c904>] (unwind_backtrace+0x0/0xe8) from [<c00417d4>] (warn_slowpath_fmt+0x6c/0x90)
[<c00417d4>] (warn_slowpath_fmt+0x6c/0x90) from [<c0028230>] (cpu_idle+0x74/0x88)
[<c0028230>] (cpu_idle+0x74/0x88) from [<c00089a8>] (start_kernel+0x1f0/0x2cc)
[<c00089a8>] (start_kernel+0x1f0/0x2cc) from [<80008034>] (0x80008034)
---[ end trace caa39301c0064903 ]---
Unable to handle kernel paging request at virtual address 60000013
pgd = c0004000
[60000013] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in: test_drv
CPU: 0    Tainted: G        W   (2.6.31-mx31-spi #29)
PC is at cpu_idle+0x28/0x88
LR is at cpu_idle+0x74/0x88
pc : [<c00281e4>]    lr : [<c0028230>]    psr: 40000093
sp : c0339fc8  ip : 80000093  fp : 00000000
r10: 80020a40  r9 : 4107b364  r8 : 80020a74
r7 : c033c360  r6 : c033c36c  r5 : 60000013  r4 : c0028308
r3 : f1080080  r2 : 00000002  r1 : c03599ac  r0 : 00000009
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 8fa10000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0338268)
Stack: (0xc0339fc8 to 0xc033a000)
9fc0:                   c037c99c c0357ad0 c0022e10 c00089a8 c0008350 00000000 
9fe0: 00000000 c0022e10 00c5387d c0357b40 c0023214 80008034 00000000 00000000 
[<c00281e4>] (cpu_idle+0x28/0x88) from [<c00089a8>] (start_kernel+0x1f0/0x2cc)
[<c00089a8>] (start_kernel+0x1f0/0x2cc) from [<80008034>] (0x80008034)
Code: e5943000 e3130002 1a000007 f10c0080 (e5953000) 
---[ end trace caa39301c0064904 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002c904>] (unwind_backtrace+0x0/0xe8) from [<c004184c>] (panic+0x44/0x124)
[<c004184c>] (panic+0x44/0x124) from [<c004494c>] (do_exit+0x550/0x5d4)
[<c004494c>] (do_exit+0x550/0x5d4) from [<c002ac24>] (die+0x124/0x144)
[<c002ac24>] (die+0x124/0x144) from [<c002d7cc>] (__do_kernel_fault+0x70/0x80)
[<c002d7cc>] (__do_kernel_fault+0x70/0x80) from [<c002d934>] (do_page_fault+0x158/0x24c)
[<c002d934>] (do_page_fault+0x158/0x24c) from [<c0026250>] (do_DataAbort+0x34/0x98)
[<c0026250>] (do_DataAbort+0x34/0x98) from [<c00269cc>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc0339f80 to 0xc0339fc8)
9f80: 00000009 c03599ac 00000002 f1080080 c0028308 60000013 c033c36c c033c360 
9fa0: 80020a74 4107b364 80020a40 00000000 80000093 c0339fc8 c0028230 c00281e4 
9fc0: 40000093 ffffffff                                                       
[<c00269cc>] (__dabt_svc+0x4c/0x60) from [<c00281e4>] (cpu_idle+0x28/0x88)
[<c00281e4>] (cpu_idle+0x28/0x88) from [<c00089a8>] (start_kernel+0x1f0/0x2cc)
[<c00089a8>] (start_kernel+0x1f0/0x2cc) from [<80008034>] (0x80008034)
Rebooting in 1 seconds..


After that I took a function generator, generating a clock signal.
I tuned that up and with around 500kHz after 5 sec. or so the kernel
crashes (with round about 3Meg irq events). That looks like this:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1]
Modules linked in: test_drv
CPU: 0    Not tainted  (2.6.31-mx31-spi #29)
PC is at flush_thread+0x4/0x54
LR is at flush_thread+0x8/0x54
pc : [<c0028318>]    lr : [<c002831c>]    psr: 60000093
sp : c0339fb8  ip : 00000000  fp : 00000000
r10: 80020a40  r9 : 4107b364  r8 : 80020a74
r7 : c033c360  r6 : c033c36c  r5 : c0357b0c  r4 : c0338000
r3 : c0338000  r2 : 00000000  r1 : 00000000  r0 : c033f820
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 8fa10000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0338268)
Stack: (0xc0339fb8 to 0xc033a000)
9fa0:                                                       c027ead4 c0028308 
9fc0: 40000013 c0028210 c037c99c c0357ad0 c0022e10 c00089a8 c0008350 00000000 
9fe0: 00000000 c0022e10 00c5387d c0357b40 c0023214 80008034 00000000 00000000 
[<c0028318>] (flush_thread+0x4/0x54) from [<c0028210>] (cpu_idle+0x54/0x88)
[<c0028210>] (cpu_idle+0x54/0x88) from [<c00089a8>] (start_kernel+0x1f0/0x2cc)
[<c00089a8>] (start_kernel+0x1f0/0x2cc) from [<80008034>] (0x80008034)
Code: f1080080 e28dd004 e8bd8000 e92d4030 (e24dd004) 
---[ end trace 93fe427f69eb77d1 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002c904>] (unwind_backtrace+0x0/0xe8) from [<c004184c>] (panic+0x44/0x124)
[<c004184c>] (panic+0x44/0x124) from [<c004494c>] (do_exit+0x550/0x5d4)
[<c004494c>] (do_exit+0x550/0x5d4) from [<c002ac24>] (die+0x124/0x144)
[<c002ac24>] (die+0x124/0x144) from [<c002d7cc>] (__do_kernel_fault+0x70/0x80)
[<c002d7cc>] (__do_kernel_fault+0x70/0x80) from [<c002d934>] (do_page_fault+0x158/0x24c)
[<c002d934>] (do_page_fault+0x158/0x24c) from [<c0026250>] (do_DataAbort+0x34/0x98)
[<c0026250>] (do_DataAbort+0x34/0x98) from [<c00269cc>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc0339f70 to 0xc0339fb8)
9f60:                                     c033f820 00000000 00000000 c0338000 
9f80: c0338000 c0357b0c c033c36c c033c360 80020a74 4107b364 80020a40 00000000 
9fa0: 00000000 c0339fb8 c002831c c0028318 60000093 ffffffff                   
[<c00269cc>] (__dabt_svc+0x4c/0x60) from [<c0028318>] (flush_thread+0x4/0x54)
[<c0028318>] (flush_thread+0x4/0x54) from [<c0028210>] (cpu_idle+0x54/0x88)
[<c0028210>] (cpu_idle+0x54/0x88) from [<c00089a8>] (start_kernel+0x1f0/0x2cc)
[<c00089a8>] (start_kernel+0x1f0/0x2cc) from [<80008034>] (0x80008034)
Rebooting in 1 seconds..


But there are cases when the crash appears with less than 3Meg irqs.
Once with around 100kHz it took like 100 sec. (10Meg) irqs for it to crash
and it sometimes also looks like this:


Internal error: Oops - undefined instruction: 0 [#1]
Modules linked in: test_drv
CPU: 0    Not tainted  (2.6.31-mx31-spi #29)
Unable to handle kernel paging request at virtual address e1a020e0
Unable to handle kernel paging request at virtual address 1b00001b
Unable to handle kernel paging request at virtual address e1520027
...10 more times the '1b00001b' and 'e1520027' lines ...
Unable to handle kernel paging request at virtual address 1b00001b
Unable to handle kernel NULL pointer dereference at virtual address 000000d8
pgd = c0004000
[000000d8] *pgd=40000193(bad)
Internal error: Oops: 17 [#2]
Modules linked in: test_drv


So am I doing the irq requesting the wrong way? I also tried that
one with the option 'IRQF_SHARED' (it should not be shared anyway)
the crashes (by touching with the bare hand) now look like this:


Internal error: Oops - undefined instruction: 0 [#1]
Modules linked in: test_drv
CPU: 0    Not tainted  (2.6.31-mx31-spi #29)


I checked the
'WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0x88()'
but could not get my head around the idle_task stuff that's happening
there. May be I did tinker with the '.config' switches too much?
Or is there something missing in the setup of the GPIO ports?

The next thing: I will switch the pin and try if other ones
behave the same way.

Any suggestions welcome :-)

Cheers
Rene



Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
