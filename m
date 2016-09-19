From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Sep 2016 17:51:49 +0100
Subject: [PATCH 1/3] i2c: bcm2835: Fix hang for writing messages larger
 than 16 bytes
In-Reply-To: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Message-ID: <87zin3omsa.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noralf Tr?nnes <noralf@tronnes.org> writes:

> Writing messages larger than the FIFO size results in a hang, rendering
> the machine unusable. This is because the RXD status flag is set on the
> first interrupt which results in bcm2835_drain_rxfifo() stealing bytes
> from the buffer. The controller continues to trigger interrupts waiting
> for the missing bytes, but bcm2835_fill_txfifo() has none to give.
> In this situation wait_for_completion_timeout() apparently is unable to
> stop the madness.
>
> The BCM2835 ARM Peripherals datasheet has this to say about the flags:
>   TXD: is set when the FIFO has space for at least one byte of data.
>   RXD: is set when the FIFO contains at least one byte of data.
>   TXW: is set during a write transfer and the FIFO is less than full.
>   RXR: is set during a read transfer and the FIFO is or more full.
>
> Implementing the logic from the downstream i2c-bcm2708 driver solved
> the hang problem.
>
> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>

Patches 1, 3 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

For patch 2 I followed some of it, but couldn't quite say it's a review.
I trust your testing, and that the path has had a lot more testing in
the downstream tree, so it's:

Acked-by: Eric Anholt <eric@anholt.net>

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/20ab542b/attachment.sig>
