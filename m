From: dgilbert@interlog.com (Douglas Gilbert)
Date: Mon, 18 Mar 2013 11:15:13 -0400
Subject: [PATCH Resend v5 00/16] spi/spi-atmel: add dmaengine support
 for atmel spi controller and to test the device tree support
In-Reply-To: <B256D81BAE5131468A838E5D7A24364148FA439C@penmbx01>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
 <CAOCHtYhQsqhf1aBzh2giACMaeE0DXkcZm8qJ73rqn6njFcCaSA@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A24364148FA439C@penmbx01>
Message-ID: <51472F81.9060803@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, Feb 26, 2013 at 6:34 PM, Wenyou Yang <wenyou.yang@atmel.com>
wrote:
> Hi All,
>
> This set of patches is to add dmaengine support for atmel spi and to test
> device tree support.
>
> The work is based on Nicolas and Richard's work.
>
> Because the Atmel DMA device tree support hasn't on mainline, to
> at91sam9x5ek and at91sam9n12ek
> with dma support, it doesn't work on the dmaengine mode, only on PIO mode
> so far.
>
> It has been tested as below:
>   1./tested on v3.8, by using mtd utils, "mount", "umount" and "cp"
> commands.
>   2./tested on "spi/next" git tree after removing commit "spi: make sure all
> transfer has proper speed set".
>   3./tested by using Documentation/spi/spidev_test.c on "/dev/spidev".
>   4./tested on on at91sam9x5ek, at91sam9m10g45ek, at91sam9263ek and
> at91sam9g20ek boards

I took a different approach to testing this patch. Try
the world's most common SPI device, namely a (micro)SD
card. There are a few issues.

The mmc_spi driver isn't very DT friendly. I added some
DT SPI attributes, patch attached. In my case cd-inverted
was needed.

Also I ran into a boot sequence problem since my hardware
boots of a microSD card using the MCI interface. I was
using a second microSD for SPI testing. at91bootstrap
and u-boot (plus the kernel image) are on my MCI microSD
card and they got the kernel booting. However since the
kernel probes SPI before MCI, then by the time of the rootfs
remount, my SPI microSD card had overtaken the /dev/mmcblk0
device node leading to some confusion.

There are several ways of coping with this problem and I
took an easy one: making mmc_spi a module. Just wondering
if there are any DT mechanisms to cope with these "order
of probing" type problems?

And data transfers to and from that microSD card using SPI
were slow, as in 200 kB/sec (should be closer to 1 MB/sec).
So Atmel, when are we getting DMA working for the AT91SAM9x5
family?

Doug Gilbert


-------------- next part --------------
A non-text attachment was scrubbed...
Name: at91_mmc_spi_dg1.patch
Type: text/x-patch
Size: 1627 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130318/153b1fcd/attachment.bin>
