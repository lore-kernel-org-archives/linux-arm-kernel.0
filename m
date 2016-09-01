From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Sep 2016 10:27:54 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87twe0krym.fsf@belgarion.home>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
Message-ID: <20160901092754.GU1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 09:19:13AM +0200, Robert Jarzmik wrote:
> The result today is that my PCMCIA card inserted in Lubbock's slot is not
> detected, but that's not really a surprise. As a matter of fact, I didn't
> look much into it, the only data points I have are :
>  - PCMCIA is probed now
>    - this is based on dmesg in [3]
>    - this is also based on ls /sys/bus/sa1111-rab/devices/1800
> 	lrwxrwxrwx    1 root     root             0 Jan  1 00:15 driver -> ../../../../bus/sa1111-rab/drivers/sa1111-pcmcia
> 	drwxr-xr-x    2 root     root             0 Jan  1 00:15 power
> 	lrwxrwxrwx    1 root     root             0 Jan  1 00:15 subsystem -> ../../../../bus/sa1111-rab
> 	-rw-r--r--    1 root     root          4096 Jan  1 00:15 uevent
> 
>  - PCMCIA sockets are not there
>    - this is based on ls /sys/class/pcmcia_socket/ where there is nothing
> 
>  - MAX16xx gpio are not claimed, which is surprising
>    - this is based on cat /sys/kernel/debug/gpio
> 	gpiochip0: GPIOs 0-84, gpio-pxa:
> 	gpiochip2: GPIOs 478-495, parent: platform/sa1111, sa1111:
> 	gpiochip1: GPIOs 496-511, lubbock:

It looks like:

(a) pcmcia_probe() in drivers/pcmcia/sa1111_generic.c doesn't check the
    return value from the platform specific init functions, meaning if
    they fail, the driver still binds.  (note: they return -ENODEV to
    indicate that they should skip to the next platform.)
(b) there is no clock provided for the sa1111 pcmcia device (aka "1800").
    This should be the same clock as pxa2xx-pcmcia.

> > There is a slight issue, which is that the interrupts can't be translated to
> > an interrupt by gpio-reg, which will currently cause soc_common problems - but
> > that's an easy fix, though leaves us with more code than I'd desire in
> > pxa2xx_mainstone.c.  Maybe a solution there would be to have gpio-reg also
> > take an array of interrupt numbers... not sure yet.
>
> Normally these interrupts are already dealt with by
> arch/arm/mach-pxa/pxa_cplds_irq.c, which adds an irqdomain for them. The missing
> part is the "gpio to interrupt" translation part, right ? This is where your
> array comes into play if I get your right, to be the input of the to_irq()
> function of the gpiochip.

Yes.

> As your gpios are contiguous (0 .. 31), why an array instead of a simple offset
> so that your translation is only a linear irq = gpio + offset ?

There isn't a linear translation here:

#define MST_PCMCIA_nIRQ         (1 << 10)  /* IRQ / ready signal */
#define MST_PCMCIA_nSPKR_BVD2   (1 << 9)   /* VDD sense / digital speaker */
#define MST_PCMCIA_nSTSCHG_BVD1 (1 << 8)   /* VDD sense / card status changed */#define MST_PCMCIA_nVS2         (1 << 7)   /* VSS voltage sense */
#define MST_PCMCIA_nVS1         (1 << 6)   /* VSS voltage sense */
#define MST_PCMCIA_nCD          (1 << 5)   /* Card detection signal */
#define MST_PCMCIA_RESET        (1 << 4)   /* Card reset signal */
#define MST_PCMCIA_PWR_MASK     (0x000f)   /* MAX1602 power-supply controls */

#define MAINSTONE_S0_CD_IRQ     MAINSTONE_IRQ(9)
#define MAINSTONE_S0_STSCHG_IRQ MAINSTONE_IRQ(10)
#define MAINSTONE_S0_IRQ        MAINSTONE_IRQ(11)
#define MAINSTONE_S1_CD_IRQ     MAINSTONE_IRQ(13)
#define MAINSTONE_S1_STSCHG_IRQ MAINSTONE_IRQ(14)
#define MAINSTONE_S1_IRQ        MAINSTONE_IRQ(15)

MST_PCMCIA_nCD		=> MAINSTONE_S0_CD_IRQ or MAINSTONE_S1_CD_IRQ
MST_PCMCIA_nSTSCHG_BVD1 => MAINSTONE_S0_STSCHG_IRQ or MAINSTONE_S1_STSCHG_IRQ
MST_PCMCIA_nIRQ		=> MAINSTONE_S0_IRQ or MAINSTONE_S1_IRQ

So they aren't linear, and every "gpio" doesn't have a corresponding
interrupt.

> [1] Typo fix
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index f034928b99a1..81a1de6fb46f 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
> @@ -13,7 +13,7 @@
>   */
>  #include <linux/clkdev.h>
>  #include <linux/gpio.h>
> -#include <linux/gpip/gpio-reg.h>
> +#include <linux/gpio/gpio-reg.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>

Fixed.

> [2] Kind-of fix for lubbock pcmcia probe
> >From 977c16201a752aac8a8fb2da1f4271795f0b2122 Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Thu, 1 Sep 2016 08:31:08 +0200
> Subject: [PATCH] pcmcia: lubbock: fix sockets configuration
> 
> On lubbock board, the probe of the driver crashes by dereferencing very
> early a platform_data structure which is not set, in
> pxa2xx_configure_sockets().
> 
> This patch blindly fixes it without any analysis as to know if it's the
> right fix or even if the fix doesn't break in suspend/resume.
> 
> The stack fixed is :
> [    0.244353] SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision 1
> [    0.256321] sa1111 sa1111: Providing IRQ336-390
> [    0.340899] clocksource: Switched to clocksource oscr0
> [    0.472263] Unable to handle kernel NULL pointer dereference at virtual address 00000004
> [    0.480469] pgd = c0004000
> [    0.483432] [00000004] *pgd=00000000
> [    0.487105] Internal error: Oops: f5 [#1] ARM
> [    0.491497] Modules linked in:
> [    0.494650] CPU: 0 PID: 1 Comm: swapper Not tainted 4.8.0-rc3-00080-g1aaa68426f0c-dirty #2068
> [    0.503229] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
> [    0.510344] task: c3e42000 task.stack: c3e44000
> [    0.514984] PC is at pxa2xx_configure_sockets+0x4/0x24 (drivers/pcmcia/pxa2xx_base.c:227)
> [    0.520193] LR is at pcmcia_lubbock_init+0x1c/0x38
> [    0.525079] pc : [<c0247c30>]    lr : [<c02479b0>]    psr: a0000053
> [    0.525079] sp : c3e45e70  ip : 100019ff  fp : 00000000
> [    0.536651] r10: c0828900  r9 : c0434838  r8 : 00000000
> [    0.541953] r7 : c0820700  r6 : c0857b30  r5 : c3ec1400  r4 : c0820758
> [    0.548549] r3 : 00000000  r2 : 0000000c  r1 : c3c09c40  r0 : c3ec1400
> [    0.555154] Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [    0.562450] Control: 0000397f  Table: a0004000  DAC: 00000053
> [    0.568257] Process swapper (pid: 1, stack limit = 0xc3e44190)
> [    0.574154] Stack: (0xc3e45e70 to 0xc3e46000)
> [    0.578610] 5e60:                                     c4849800 00000000 c3ec1400 c024769c
> [    0.586928] 5e80: 00000000 c3ec140c c3c0ee0c c3ec1400 c3ec1434 c020c410 c3ec1400 c3ec1434
> [    0.595244] 5ea0: c0820700 c080b408 c0828900 c020c5f8 00000000 c0820700 c020c578 c020ac5c
> [    0.603560] 5ec0: c3e687cc c3e71e10 c0820700 00000000 c3c02de0 c020bae4 c03c62f7 c03c62f7
> [    0.611872] 5ee0: c3e68780 c0820700 c042e034 00000000 c043c440 c020cdec c080b408 00000005
> [    0.620188] 5f00: c042e034 c00096c0 c0034440 c01c730c 20000053 ffffffff 00000000 00000000
> [    0.628502] 5f20: 00000000 c3ffcb87 c3ffcb90 c00346ac c3e66ba0 c03f7914 00000092 00000005
> [    0.636811] 5f40: 00000005 c03f847c 00000091 c03f847c 00000000 00000005 c0434828 00000005
> [    0.645125] 5f60: c043482c 00000092 c043c440 c0828900 c0434838 c0418d2c 00000005 00000005
> [    0.653430] 5f80: 00000000 c041858c 00000000 c032e9f0 00000000 00000000 00000000 00000000
> [    0.661729] 5fa0: 00000000 c032e9f8 00000000 c000f0f0 00000000 00000000 00000000 00000000
> [    0.670020] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.678311] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    0.686673] (pxa2xx_configure_sockets) from pcmcia_lubbock_init (/drivers/pcmcia/sa1111_lubbock.c:161)
> [    0.696026] (pcmcia_lubbock_init) from pcmcia_probe (/drivers/pcmcia/sa1111_generic.c:213)
> [    0.704358] (pcmcia_probe) from driver_probe_device (/drivers/base/dd.c:378 /drivers/base/dd.c:499)
> [    0.712848] (driver_probe_device) from __driver_attach (/./include/linux/device.h:983 /drivers/base/dd.c:733)
> [    0.721414] (__driver_attach) from bus_for_each_dev (/drivers/base/bus.c:313)
> [    0.729723] (bus_for_each_dev) from bus_add_driver (/drivers/base/bus.c:708)
> [    0.738036] (bus_add_driver) from driver_register (/drivers/base/driver.c:169)
> [    0.746185] (driver_register) from do_one_initcall (/init/main.c:778)
> [    0.754561] (do_one_initcall) from kernel_init_freeable (/init/main.c:843 /init/main.c:851 /init/main.c:869 /init/main.c:1016)
> [    0.763409] (kernel_init_freeable) from kernel_init (/init/main.c:944)
> [    0.771660] (kernel_init) from ret_from_fork (/arch/arm/kernel/entry-common.S:119)
> [ 0.779347] Code: c03c6305 c03c631e c03c632e e5903048 (e993000c)
> All code
> ========
>    0:	c03c6305 	eorsgt	r6, ip, r5, lsl #6
>    4:	c03c631e 	eorsgt	r6, ip, lr, lsl r3
>    8:	c03c632e 	eorsgt	r6, ip, lr, lsr #6
>    c:	e5903048 	ldr	r3, [r0, #72]	; 0x48
>   10:*	e993000c 	ldmib	r3, {r2, r3}		<-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	e993000c 	ldmib	r3, {r2, r3}
> [    0.786319] ---[ end trace 5264be19ef367bea ]---
> [    0.791201] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.791201]
> [    0.800441] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/pcmcia/pxa2xx_base.c    | 9 +++++----
>  drivers/pcmcia/pxa2xx_base.h    | 2 +-
>  drivers/pcmcia/sa1111_lubbock.c | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
> index 483f919e0d2e..91b5f5724cba 100644
> --- a/drivers/pcmcia/pxa2xx_base.c
> +++ b/drivers/pcmcia/pxa2xx_base.c
> @@ -214,9 +214,8 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
>  }
>  #endif
>  
> -void pxa2xx_configure_sockets(struct device *dev)
> +void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops)
>  {
> -	struct pcmcia_low_level *ops = dev->platform_data;
>  	/*
>  	 * We have at least one socket, so set MECR:CIT
>  	 * (Card Is There)
> @@ -322,7 +321,7 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
>  			goto err1;
>  	}
>  
> -	pxa2xx_configure_sockets(&dev->dev);
> +	pxa2xx_configure_sockets(&dev->dev, ops);
>  	dev_set_drvdata(&dev->dev, sinfo);
>  
>  	return 0;
> @@ -348,7 +347,9 @@ static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
>  
>  static int pxa2xx_drv_pcmcia_resume(struct device *dev)
>  {
> -	pxa2xx_configure_sockets(dev);
> +	struct pcmcia_low_level *ops = (struct pcmcia_low_level *)dev->platform_data;
> +
> +	pxa2xx_configure_sockets(dev, ops);
>  	return 0;
>  }
>  
> diff --git a/drivers/pcmcia/pxa2xx_base.h b/drivers/pcmcia/pxa2xx_base.h
> index b609b45469ed..e58c7a415418 100644
> --- a/drivers/pcmcia/pxa2xx_base.h
> +++ b/drivers/pcmcia/pxa2xx_base.h
> @@ -1,4 +1,4 @@
>  int pxa2xx_drv_pcmcia_add_one(struct soc_pcmcia_socket *skt);
>  void pxa2xx_drv_pcmcia_ops(struct pcmcia_low_level *ops);
> -void pxa2xx_configure_sockets(struct device *dev);
> +void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops);
>  
> diff --git a/drivers/pcmcia/sa1111_lubbock.c b/drivers/pcmcia/sa1111_lubbock.c
> index 9d5ffc71ae51..7c1f0f6cd578 100644
> --- a/drivers/pcmcia/sa1111_lubbock.c
> +++ b/drivers/pcmcia/sa1111_lubbock.c
> @@ -157,7 +157,7 @@ int pcmcia_lubbock_init(struct sa1111_dev *sadev)
>  
>  	if (machine_is_lubbock()) {
>  		pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
> -		pxa2xx_configure_sockets(&sadev->dev);
> +		pxa2xx_configure_sockets(&sadev->dev, &lubbock_pcmcia_ops);
>  		ret = sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
>  				pxa2xx_drv_pcmcia_add_one);
>  	}

I think the patch is sane - it's certainly saner than the current mess,
so I'll add it to my patch set, thanks.

> [    7.171675] atkbd serio0: keyboard reset failed on 0a00
> [    7.177087] ------------[ cut here ]------------
> [    7.181895] WARNING: CPU: 0 PID: 17 at kernel/irq/manage.c:527 enable_irq+0x58/0x70
> [    7.189606] Unbalanced enable for IRQ 357
> [    7.193662] Modules linked in:
> [    7.196854] CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 4.8.0-rc3-00080-g1aaa68426f0c-dirty #2070
> [    7.205878] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
> [    7.213055] Workqueue: events_long serio_handle_event
> [    7.218386] [<c0015260>] (unwind_backtrace) from [<c00122f0>] (show_stack+0x10/0x14)
> [    7.226312] [<c00122f0>] (show_stack) from [<c001ea40>] (__warn+0xcc/0xf8)
> [    7.233334] [<c001ea40>] (__warn) from [<c001eaa0>] (warn_slowpath_fmt+0x34/0x44)
> [    7.240964] [<c001eaa0>] (warn_slowpath_fmt) from [<c0047d44>] (enable_irq+0x58/0x70)
> [    7.248935] [<c0047d44>] (enable_irq) from [<c0250df4>] (ps2_write+0x4c/0x78)
> [    7.256211] [<c0250df4>] (ps2_write) from [<c025107c>] (ps2_sendbyte+0x50/0x144)
> [    7.263746] [<c025107c>] (ps2_sendbyte) from [<c02513b0>] (__ps2_command+0xc0/0x3c4)
> [    7.271630] [<c02513b0>] (__ps2_command) from [<c02516d8>] (ps2_command+0x24/0x38)
> [    7.279389] [<c02516d8>] (ps2_command) from [<c0259968>] (atkbd_probe+0x60/0x140)
> [    7.287026] [<c0259968>] (atkbd_probe) from [<c025a950>] (atkbd_connect+0x130/0x238)
> [    7.294901] [<c025a950>] (atkbd_connect) from [<c0250ae4>] (serio_driver_probe+0x28/0x3c)
> [    7.303251] [<c0250ae4>] (serio_driver_probe) from [<c020c410>] (driver_probe_device+0x124/0x28c)
> [    7.312276] [<c020c410>] (driver_probe_device) from [<c020c5f8>] (__driver_attach+0x80/0xa4)
> [    7.320852] [<c020c5f8>] (__driver_attach) from [<c020ac5c>] (bus_for_each_dev+0x6c/0x90)
> [    7.329167] [<c020ac5c>] (bus_for_each_dev) from [<c0250984>] (serio_handle_event+0x154/0x1a0)
> [    7.337933] [<c0250984>] (serio_handle_event) from [<c0030638>] (process_one_work+0x1bc/0x300)
> [    7.346688] [<c0030638>] (process_one_work) from [<c0030d1c>] (worker_thread+0x2bc/0x3f8)
> [    7.355043] [<c0030d1c>] (worker_thread) from [<c0034da0>] (kthread+0xc4/0xd8)
> [    7.362418] [<c0034da0>] (kthread) from [<c000f0f0>] (ret_from_fork+0x14/0x24)
> [    7.369720] ---[ end trace 52001af966019111 ]---

Hmm, I've not seen that one, I'll look into it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
