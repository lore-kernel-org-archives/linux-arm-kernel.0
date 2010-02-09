From: csammy@gmail.com (Sammy Chan)
Date: Wed, 10 Feb 2010 00:19:23 +0800
Subject: Kernel may hang when opening a tty device
Message-ID: <1bbf47391002090819y1f37e8a9l39ff5a6581c0977e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is my first post. I've an interesting finding to share with you. I'm
using AT91RM9200 with an old kernel 2.4.21-rmk1. Recently, I found that the
kernel would hang at times when calling open("/dev/ttySX") in order to
initialize an RS232 port, IRDA port or other serial device. In fact, it got
stuck at an infinite while loop here:

[drivers/at91/serial/at91_serial.c, at91_change_speed()]

......
    /* first, disable interrupts and drain transmitter */
    local_irq_save(flags);
    imr = UART_GET_IMR(uart);   /* get interrupt mask */
    UART_PUT_IDR(uart, -1);     /* disable all interrupts */
    local_irq_restore(flags);

    while (!(UART_GET_CSR(uart) & AT91C_US_TXEMPTY)) { barrier(); }
......
    UART_PUT_BRGR(uart, quot);

------------------------------------------
It didn't stand to reason that a byte sent to the shift register could never
trasmitted. After painstaking investigation, I found that US_BRGR (clock
divisor) was 0 when the loop was being executed, which means the clock was
disabled. The reason there was data to be transmitted during the open call
was that by default the ttyS device has the ECHO c_lflag on and there was
some initial noise generated from the serial devices, causing the noise
received to be transmitted soon after the transmitted was enabled during. If
the noise happened to arrive just before the loop was executed, the kernel
would be trapped. That explains the randomness. If US_BRGR was set to some
non-zero value, the problem would disappear. It seems even in the latest
kernel, the while loop still precedes setting the US_BRGR. I wonder if this
is a potential kernel bug, or if it's just my responsibility to ensure that
there is no noise or ECHO turned off as default for non-terminal devices?

Regards,
Sammy

----------------
Sammy Chan
csammy at gmail.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100210/c0e37219/attachment.htm>
