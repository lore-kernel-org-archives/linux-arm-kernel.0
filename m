From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 May 2015 14:17:08 +0100
Subject: [PATCH 08/12] i2c: pxa: enable/disable irq across message xfer
In-Reply-To: <1432818224-17070-9-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-9-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150528131707.GB2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 06:33:40PM +0530, Vaibhav Hiremath wrote:
> In order to avoid "spurious irq" caused by CP polling mode,
> enable irq at the entry of i2c_pxa_xfer() fn and disable it
> again before exit.

NAK.

It's really not nice for drivers to disable a potentially shared interrupt.
If the interrupt is shared, you disable the interrupt for other users of
that interrupt as well.  See:

commit c66dc529194be374556d166ee7ddb84a7d1d302b
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Feb 23 12:38:18 2011 +0100

    i2c-pxa2xx: add support for shared IRQ handler

    Sodaville has three of them on a single IRQ. IRQF_DISABLED is removed
    because it is a NOP allready and scheduled for removal.

    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>

So you're breaking Sodaville.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
