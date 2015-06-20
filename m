From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 20 Jun 2015 11:09:37 +0200 (CEST)
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
In-Reply-To: <1434635669-23367-1-git-send-email-Dave.Martin@arm.com>
References: <1434635669-23367-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <416658426.177742.1434791378036.JavaMail.open-xchange@oxbsltgw09.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Dave Martin <Dave.Martin@arm.com> hat am 18. Juni 2015 um 15:54 geschrieben:
>
>
> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> sufficient to inhibit pl011_int() from being triggered by a local
> IRQ and trying to re-take the same lock. This can lead to
> deadlocks.
>
> This patch uses the _irq() locking variants instead to ensure that
> pl011_int() handling for a given port is deferred until any
> pl011_tx_softirq() work for that port is complete.
>
> Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Cc: stable <stable@vger.kernel.org> # 4.1
>

I also get info messages about inconsistent lock state on my mx28 board,
after applying the patch the messages disappeared.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Regards
Stefan
