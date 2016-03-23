From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 23 Mar 2016 16:36:38 +0100
Subject: DCD interrupt for i.MX25 UART
Message-ID: <20160323153638.GO6191@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a problem with an UART on an i.MX25 based machine. I implemented
DCD (and other handshake lines) irq handling[1].

Now a user of this patch noticed that DCD handling (at least) is broken.
The problem is that the USR2_DCDDELT bit doesn't clear:

	root at hostname:~ memtool md 0x43f90080+0x34  
	43f90080: 00000000 00004021 0000078c 00004002                ....!@....... at ..
	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..hR..+...
	43f900a0: 00000000 000000bf 00002e62 00000008                ........b.......
	43f900b0: 0000251c                                           .%..

	root at hostname:~ memtool mw 0x43f90098 0x0x40

	root at hostname:~ memtool md 0x43f90080+0x34  
	43f90080: 00000000 00004021 0000078c 00004002                ....!@....... at ..
	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..hR..+...
	43f900a0: 00000000 000000bf 00002e62 00000008                ........b.......
	43f900b0: 0000251c                                           .%..

In fact even writing 0xffff doesn't change the register, where I would expect
that the DCDDELT bit (0x40) disappears. I'm sure there is nothing toggling this
line.

The net effect is that the irq blocks the machine until it is disabled with

	[   51.885987] irq 61: nobody cared (try booting with the "irqpoll" option)

.

This is on an i.MX25 and I checked the erratas also of the newer i.MX
cpus, but I didn't find anything.

Did I miss something? Is this a known bug? Do you have a recommendation
other than not to set UCR3_DCD? I cannot test the same problem for RI
because my hardware doesn't use it, but I wouldn't be surprised if that
had the same problem.

It would be great to get a statement from you on this topic.

Best regards
Uwe

[1] Message-Id: 1457605569-7828-3-git-send-email-u.kleine-koenig at pengutronix.de

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
