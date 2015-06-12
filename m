From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 12 Jun 2015 19:01:32 +0200
Subject: [BUG] at91: serial: something wrong with using DMA
In-Reply-To: <5570376F.7050406@aksignal.cz>
References: <555C8B79.4030900@aksignal.cz> <556563CE.3090506@aksignal.cz>
 <556D611A.5090004@aksignal.cz> <5570376F.7050406@aksignal.cz>
Message-ID: <557B106C.4020207@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi jiri,

the bug is reproduced on sama5d3x with the 3.18 at91 kernel. So with a DMA
controller driven by drivers/dma/at_hdmac.c. This driver is also used for
at91sam9g25.

3.18 at91, 3.19 vanilla and later kernels contain a patch
"tty/serial: at91: fix rx ring buffer management".
This patch was not applied to 3.18 vanilla yet.

This patch didn't introduce the bug you reported but I refer to it because my
debug traces were produced by applying another "debug" patch after the
"fix rx ring buffer management" patch.

The "debug" patch is:

@@ -1014,6 +1016,9 @@ static void atmel_rx_from_dma(struct uart_port *port)
         */
        ring->head = sg_dma_len(&atmel_port->sg_rx) - state.residue;
        BUG_ON(ring->head > sg_dma_len(&atmel_port->sg_rx));
+       dev_vdbg(port->dev, "%s: tail=%d, head=%d, residue=%u, dma_len=%u\n",
+                __FUNCTION__, ring->tail, ring->head, state.residue,
+                sg_dma_len(&atmel_port->sg_rx));
        /*
         * At this point ring->head may point to the first byte right after the
         * last byte of the dma buffer:

>From my PC, I used picocom to send one character at a time to the sama5d3x USART.
Then the resulting traces are:

...
Jan  1 00:44:06 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2030, head=2031, residue=2065, dma_len=4096
Jan  1 00:44:06 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2031, head=2032, residue=2064, dma_len=4096
Jan  1 00:44:06 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2032, head=2033, residue=2063, dma_len=4096
Jan  1 00:44:09 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2033, head=2034, residue=2062, dma_len=4096
Jan  1 00:44:10 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2034, head=2035, residue=2061, dma_len=4096
Jan  1 00:44:11 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2035, head=2036, residue=2060, dma_len=4096
Jan  1 00:44:12 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2036, head=2037, residue=2059, dma_len=4096
Jan  1 00:44:13 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2037, head=2038, residue=2058, dma_len=4096
Jan  1 00:44:15 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2038, head=2039, residue=2057, dma_len=4096
Jan  1 00:44:17 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2039, head=2040, residue=2056, dma_len=4096
Jan  1 00:44:18 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2040, head=2041, residue=2055, dma_len=4096
Jan  1 00:44:20 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2041, head=2042, residue=2054, dma_len=4096
Jan  1 00:44:21 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2042, head=2043, residue=2053, dma_len=4096
Jan  1 00:44:22 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2043, head=2044, residue=2052, dma_len=4096
Jan  1 00:44:23 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2044, head=2045, residue=2051, dma_len=4096
Jan  1 00:44:25 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2045, head=2046, residue=2050, dma_len=4096
Jan  1 00:44:26 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2046, head=2047, residue=2049, dma_len=4096
Jan  1 00:44:28 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2047, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:32 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:37 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:39 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:40 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:42 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:43 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:45 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:46 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:48 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:49 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:52 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:53 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:53 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:54 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:44:55 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
...
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=2048, residue=2048, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2048, head=0, residue=4096, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=0, head=1, residue=4095, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=1, head=2, residue=4094, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=2, head=3, residue=4093, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=3, head=4, residue=4092, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=4, head=5, residue=4091, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=5, head=6, residue=4090, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=6, head=7, residue=4089, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=7, head=8, residue=4088, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=8, head=9, residue=4087, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=9, head=10, residue=4086, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=10, head=11, residue=4085, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=11, head=12, residue=4084, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=12, head=13, residue=4083, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=13, head=14, residue=4082, dma_len=4096
Jan  1 00:55:04 buildroot kern.debug kernel: atmel_usart f0020000.serial: atmel_rx_from_dma: tail=14, head=15, residue=4081, dma_len=4096
...

Please note that for the 2048 first received bytes, the DMA residue is
decreased normally down to 2048. Then for the next 2048 received bytes, the DMA
residue remains at the wrong 2048 value whereas it should decrease.
At this point 4096 bytes were received, this is the size of the DMA ring
buffer: the DMA driver reschedules a new transfer so the new residue is 4096.
Following the received bytes, the residue is decreased down to 2048 then
blocked again for the next 2048 bytes and so on...

The DMA residue is used to update the head pointer of the USART RX ring buffer.
Since the computation of the DMA residue is wrong the USART can't work
properly.

We have to look at the residue computation in the at_hdmac.c driver.
Anyway, thanks for reporting and for your investigation: it helped a lot!

Best Regards,

Cyrille

Le 04/06/2015 13:33, Ji?? Prchal a ?crit :
> Hi,
> writing again, I made small tester to see what is happening. There is loop ttyS3 to ttyS2.
> 
> / # uname -a
> Linux prchal 3.18.0-linux4sam_4.7_cpm9g25+ #2 PREEMPT Thu May 21 14:29:51 CEST 2015 armv5tejl GNU/Linux
> / #  testtty -i /dev/ttyS2 -o /dev/ttyS3 -b 512
> [ 9657.789789] atmel_usart f801c000.serial: using dma0chan4 for rx DMA transfers
> [ 9657.798798] atmel_usart f801c000.serial: using dma0chan5 for tx DMA transfers
> [ 9657.807807] atmel_usart f8020000.serial: using dma0chan6 for rx DMA transfers
> [ 9657.816816] atmel_usart f8020000.serial: using dma0chan7 for tx DMA transfers
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 512 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 1024 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 1536 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 2048 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 0 B, error! Total = 2048 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 0 B, error! Total = 2048 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 0 B, error! Total = 2048 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 2048 B, error! Total = 4096 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 4608 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 5120 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 5632 B.
> Write to /dev/ttyS3 = 512 B.
> Read from /dev/ttyS2 = 512 B. Total = 6144 B.
> 
> and repeated...
> 
> I can send testtty source code if you like.
> 
> 
> On 2.6.2015 09:54, Ji?? Prchal wrote:
>> Hi,
>> we made some research how it "doesn't" work.
>> Just after the ttyS is opened it gives data in each read as it received them (44 B). No select, just read, VMIN = 0
>> VTIME = 1. But after 2048 B in total received since open it stopped giving data (read returns 0) until next 2048 B
>> received and then read gives all of the next 2048 B and so on.
>> In kernel 3.18.13 it works fine, in 4.x or 3.18.0-linux4sam no.
>> What we do wrong?
>> Jiri
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
