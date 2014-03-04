From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 04 Mar 2014 11:37:20 +0100
Subject: [PATCH2] CNS3xxx: Fix a WARN() related to IRQ allocation.
In-Reply-To: <m3eh2nqz7n.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of "Fri, 28 Feb 2014 12:00:12 +0100")
References: <m3eh2nqz7n.fsf@t19.piap.pl>
Message-ID: <m3a9d6ntb3.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: at drivers/irqchip/irq-gic.c:952 gic_init_bases+0xe4/0x2b8()
Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
Backtrace:
gic_init_bases    from cns3xxx_init_irq+0x24/0x34
cns3xxx_init_irq  from init_IRQ+0x24/0x2c
init_IRQ          from start_kernel+0x1a8/0x338
start_kernel      from 0x2000806c

The problem is that 64 CNS3xxx CPU interrupts, starting at 32, are
allocated by the ARM platform-independent code (as requested by
machine_desc->nr_irqs = 96), and then the GIC code tries to allocate
them again.

Tested on Gateworks Laguna board, masqueraded as CNS3420VB.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
