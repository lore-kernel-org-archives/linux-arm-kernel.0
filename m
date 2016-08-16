From: Ken.Lin@advantech.com.tw (Ken.Lin)
Date: Tue, 16 Aug 2016 02:42:33 +0000
Subject: [PATCH] ARM: dts: imx6q-bx50v3: configure unused pca953x pins
In-Reply-To: <20160815072825.hffvzlxpzlph6bk7@pengutronix.de>
References: <1471023911-2763-1-git-send-email-akshay.bhat@timesys.com>
 <20160815053033.ds27jg3c7vnx7ujw@pengutronix.de>
 <a23f6081bea242bfba70b805f2a93494@taipei08.ADVANTECH.CORP>
 <20160815072825.hffvzlxpzlph6bk7@pengutronix.de>
Message-ID: <56fb5916ee464557974bf9a0b1e5df88@taipei09.ADVANTECH.CORP>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Without the patch to configure unused pins (floating inputs as default) well based on the project specific schematics design, the unhandled interrupts (return IRQ_NONE in pca953x_irq_handler) would probably exceed a certain rate count and result in the below backtrace which ends up disabling the IRQ (the shared pca953x all interrupt).

[15994.165307] irq 72: nobody cared (try booting with the "irqpoll" option)
[15994.172052] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.0.0 #1
[15994.177904] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[15994.184448] Backtrace:
[15994.186974] [<80012638>] (dump_backtrace) from [<80012854>] (show_stack+0x18/0x1c)
[15994.194561]  r6:80a77864 r5:00000000 r4:00000000 r3:00000000
[15994.200351] [<8001283c>] (show_stack) from [<80727924>] (dump_stack+0x8c/0xa4)
[15994.207614] [<80727898>] (dump_stack) from [<80071d18>] (__report_bad_irq+0x28/0xc8)
[15994.215373]  r6:00000048 r5:00000000 r4:ee14e100 r3:00000000
[15994.221154] [<80071cf0>] (__report_bad_irq) from [<800722cc>] (note_interrupt+0x254/0x2b4)
[15994.229434]  r6:00000048 r5:00000000 r4:ee14e100 r3:00000000
[15994.235217] [<80072078>] (note_interrupt) from [<8006fc14>] (handle_irq_event_percpu+0xd0/0x140)
[15994.244018]  r10:80abaf34 r9:ee14e100 r8:00000048 r7:00002088 r6:00000002 r5:00000002
[15994.251982]  r4:00000000 r3:00000000
[15994.255633] [<8006fb44>] (handle_irq_event_percpu) from [<8006fcc8>] (handle_irq_event+0x44/0x64)
[15994.264520]  r10:00000000 r9:ee14cd10 r8:00000001 r7:00000008 r6:ed9bbbc0 r5:ee14e160
[15994.272484]  r4:ee14e100
[15994.275068] [<8006fc84>] (handle_irq_event) from [<80072b04>] (handle_level_irq+0xbc/0x144)
[15994.283433]  r6:ee14cb00 r5:ee14e160 r4:ee14e100 r3:00022008
[15994.289213] [<80072a48>] (handle_level_irq) from [<8006f18c>] (generic_handle_irq+0x30/0x44)
[15994.297666]  r5:00000008 r4:00000048
[15994.301328] [<8006f15c>] (generic_handle_irq) from [<802eef20>] (mxc_gpio_irq_handler+0x34/0x114)
[15994.310216]  r4:00000003 r3:00000020
[15994.313869] [<802eeeec>] (mxc_gpio_irq_handler) from [<802ef088>] (mx3_gpio_irq_handler+0x88/0xe4)
[15994.322843]  r10:00000000 r9:ee008000 r8:00000001 r7:00000000 r6:ee14cb00 r5:ee14cd10
[15994.330806]  r4:80a77ae4
[15994.333390] [<802ef000>] (mx3_gpio_irq_handler) from [<8006f18c>] (generic_handle_irq+0x30/0x44)
[15994.342191]  r6:80a5aaf8 r5:00000043 r4:00000043 r3:802ef000
[15994.347971] [<8006f15c>] (generic_handle_irq) from [<8006f4ac>] (__handle_domain_irq+0x6c/0xe8)
[15994.356684]  r4:80a53d8c r3:00000167
[15994.360331] [<8006f440>] (__handle_domain_irq) from [<800087bc>] (gic_handle_irq+0x28/0x68)
[15994.368697]  r9:80a5a9c8 r8:80abaf31 r7:f4000100 r6:80a5ac6c r5:80a59f18 r4:f400010c
[15994.376584] [<80008794>] (gic_handle_irq) from [<800133a4>] (__irq_svc+0x44/0x5c)
[15994.384085] Exception stack(0x80a59f18 to 0x80a59f60)
[15994.389157] 9f00:                                                       00000001 00000001
[15994.397361] 9f20: 00000000 80021120 80a58000 80a5a97c 80733270 80abaf31 80abaf31 80a5a9c8
[15994.405565] 9f40: 00000000 80a59f6c 80a59f30 80a59f60 80062ab0 8000f89c 20010013 ffffffff
[15994.413756]  r7:80a59f4c r6:ffffffff r5:20010013 r4:8000f89c
[15994.419545] [<8000f874>] (arch_cpu_idle) from [<8005dc08>] (cpu_startup_entry+0x120/0x18c)
[15994.427851] [<8005dae8>] (cpu_startup_entry) from [<80723428>] (rest_init+0xac/0xd4)
[15994.435611]  r7:80a5a8c0 r3:80733660
[15994.439263] [<8072337c>] (rest_init) from [<809fac94>] (start_kernel+0x358/0x3cc)
[15994.446762]  r5:80abb180 r4:80a5aa84
[15994.450413] [<809fa93c>] (start_kernel) from [<10008074>] (0x10008074)
[15994.456956] handlers:
[15994.459258] [<8006fce8>] irq_default_primary_handler threaded [<802ef8ac>] pca953x_irq_handler
[15994.467942] Disabling IRQ #72


Cheers,
Ken Lin

-----Original Message-----
From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de] 
Sent: Monday, August 15, 2016 3:28 PM
To: Ken.Lin
Cc: Akshay Bhat; shawnguo at kernel.org; kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org; linux-gpio at vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-bx50v3: configure unused pca953x pins

Hello,

Cc += linux-gpio

On Mon, Aug 15, 2016 at 06:18:07AM +0000, Ken.Lin wrote:
> 1. As you can see in the datasheet(that I attached to this email), at 
> power on, P00 - P17 are configured as inputs (by chip default setting, 
> datasheet P.3) and an interrupt is generated by any rising or falling 
> edge of the port inputs in the input mode (datasheet P.10)

ah, I see. All input pins generate an irq. The driver should handle this just fine however. So I hope you don't see an oops or messages about unhandled irqs, right?

> 2. The unhandled interrupts ( return IRQ_NONE in pca953x_irq_handler) 
> in GPIO expander driver (drivers/gpio/gpio-pca953x.c) could happen 
> when unused GPIO pins in GPIO expander are not well configured.

Hmm, maybe the driver should return IRQ_HANDLED in this case, too. After all the irq reason is known and it was expected that an irq happend, right?

> 3. As a result, we tried to configure the unused (default floating
> inputs) pca953x GPIO pins as GPO low to avoid the unexpected 
> interrupts (could be observed during the interference situation e.g.
> putting fingers on the unused pin to make the signal level change)

So changing these to outputs might still make sense to prevent these from floating or triggering unused irqs, but this should not make a semantical difference for your machine. (It might have more load and a bigger irq count, but apart from that everything should be the same.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
