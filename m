From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 11:11:17 +0000
Subject: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset
 at booting)
In-Reply-To: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
References: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20120113111117.GT1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 02:14:23PM +0900, MyungJoo Ham wrote:
> Probe function of s3c2410 watchdog calls request_irq before initializing
> required value (wdt_count). This incurs resetting watchdog counter value
> and watchdog-reboot during booting up.
> 
> This patch addresses such an issue by calling request_irq later.
> 
> Error handling in probe function and calling oder in remove function are
> also revised accordingly.

On the other hand, this patch violates the general principle that you set
the device up _before_ you publish it to userspace.

In the case where you add the watchdog device, but then the subsequent
request_irq() fails, there is a window where the watchdog device could
be opened and started.  You then fall out through the error paths, and
the module could be removed.

Don't do this.  Always setup the device first.  Then publish it.  Never
the other way around.
