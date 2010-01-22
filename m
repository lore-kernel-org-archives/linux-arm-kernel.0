From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jan 2010 16:57:19 +0000
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
In-Reply-To: <20100122164713.GA21907@shareable.org>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100121220653.GA21010@pengutronix.de>
	<20100121221133.GA30419@n2100.arm.linux.org.uk>
	<4B597A82.4020906@epfl.ch> <20100122110701.GA15699@shareable.org>
	<20100122113130.GB10449@n2100.arm.linux.org.uk>
	<20100122164713.GA21907@shareable.org>
Message-ID: <20100122165719.GB18461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2010 at 04:47:13PM +0000, Jamie Lokier wrote:
> Any tips on how to make the serial receive irq latency more reliable
> on ARM, with a boringly generic serial driver?

What you could do is arrange for a backtrace to be printed when
you read an overrun condition from the UART - if interrupts were
disabled by something taking a long time, and then enabled, you
should see the point where they were just enabled in the backtrace.

It could be down to another IRQF_DISABLED interrupt - in which case
you won't see it in the backtrace.

Of course, printing a backtrace will cause subsequent overruns...
