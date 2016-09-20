From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 20 Sep 2016 08:46:58 +0200
Subject: [PATCH 1/3] i2c: bcm2835: Fix hang for writing messages larger
 than 16 bytes
In-Reply-To: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Message-ID: <e473206c-7f9c-7b7d-d75d-7879425fc2f9@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.09.2016 17:26, Noralf Tr?nnes wrote:
> Writing messages larger than the FIFO size results in a hang, rendering
> the machine unusable. This is because the RXD status flag is set on the
> first interrupt which results in bcm2835_drain_rxfifo() stealing bytes
> from the buffer. The controller continues to trigger interrupts waiting
> for the missing bytes, but bcm2835_fill_txfifo() has none to give.
I remember having seen similar interrupt issues with the SPI HW-block.
> In this situation wait_for_completion_timeout() apparently is unable to
> stop the madness.
That is because it is a level irq that immediately triggers another 
interrupt giving
no CPU no time to do other (threaded) OS activity - this might be slightly
different for multi-core machines...
> The BCM2835 ARM Peripherals datasheet has this to say about the flags:
>    TXD: is set when the FIFO has space for at least one byte of data.
>    RXD: is set when the FIFO contains at least one byte of data.
>    TXW: is set during a write transfer and the FIFO is less than full.
>    RXR: is set during a read transfer and the FIFO is or more full.
>
> Implementing the logic from the downstream i2c-bcm2708 driver solved
> the hang problem.
>
> Signed-off-by: Noralf Tr?nnes<noralf@tronnes.org>
Reviewed-by: Martin Sperl <kernel@martin.sperl.org>
