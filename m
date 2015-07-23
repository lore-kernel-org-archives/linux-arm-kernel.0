From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 23 Jul 2015 15:05:50 -0700
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
In-Reply-To: <1436439433-10258-1-git-send-email-Dave.Martin@arm.com>
References: <1436439433-10258-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150723220550.GA15032@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 11:57:12AM +0100, Dave Martin wrote:
> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> sufficient to inhibit pl011_int() from being triggered by a local
> IRQ and trying to re-take the same lock.  This can lead to
> deadlocks.
> 
> This patch uses the _irq() locking variants instead to ensure that
> pl011_int() handling for a given port is deferred until any
> pl011_tx_softirq() work for that port is complete.
> 
> Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: stable <stable@vger.kernel.org> # 4.1
> ---
>  drivers/tty/serial/amba-pl011.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This doesn't apply at all to 4.2-rc3, so I can't apply it :(
