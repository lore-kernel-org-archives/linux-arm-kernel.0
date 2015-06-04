From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Thu, 04 Jun 2015 13:33:03 +0200
Subject: [BUG] at91: serial: something wrong with using DMA
In-Reply-To: <556D611A.5090004@aksignal.cz>
References: <555C8B79.4030900@aksignal.cz> <556563CE.3090506@aksignal.cz>
 <556D611A.5090004@aksignal.cz>
Message-ID: <5570376F.7050406@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
writing again, I made small tester to see what is happening. There is loop ttyS3 to ttyS2.

/ # uname -a
Linux prchal 3.18.0-linux4sam_4.7_cpm9g25+ #2 PREEMPT Thu May 21 14:29:51 CEST 2015 armv5tejl GNU/Linux
/ #  testtty -i /dev/ttyS2 -o /dev/ttyS3 -b 512
[ 9657.789789] atmel_usart f801c000.serial: using dma0chan4 for rx DMA transfers
[ 9657.798798] atmel_usart f801c000.serial: using dma0chan5 for tx DMA transfers
[ 9657.807807] atmel_usart f8020000.serial: using dma0chan6 for rx DMA transfers
[ 9657.816816] atmel_usart f8020000.serial: using dma0chan7 for tx DMA transfers
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 512 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 1024 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 1536 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 2048 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 0 B, error! Total = 2048 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 0 B, error! Total = 2048 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 0 B, error! Total = 2048 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 2048 B, error! Total = 4096 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 4608 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 5120 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 5632 B.
Write to /dev/ttyS3 = 512 B.
Read from /dev/ttyS2 = 512 B. Total = 6144 B.

and repeated...

I can send testtty source code if you like.


On 2.6.2015 09:54, Ji?? Prchal wrote:
> Hi,
> we made some research how it "doesn't" work.
> Just after the ttyS is opened it gives data in each read as it received them (44 B). No select, just read, VMIN = 0
> VTIME = 1. But after 2048 B in total received since open it stopped giving data (read returns 0) until next 2048 B
> received and then read gives all of the next 2048 B and so on.
> In kernel 3.18.13 it works fine, in 4.x or 3.18.0-linux4sam no.
> What we do wrong?
> Jiri
>
