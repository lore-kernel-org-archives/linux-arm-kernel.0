From: martinwguy@gmail.com (Martin Guy)
Date: Mon, 26 Apr 2010 15:35:35 +0100
Subject: [spi-devel-general] [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
References: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
	<m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
Message-ID: <k2l56d259a01004260735nb44e9dddy5b08668787070ac7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>  During the 512+2+1 message that is sent when the mmc_spi driver is
>  doing a block read, the 512 byte transfer goes like this:
>
>  1) 8 writes, prime the tx fifo
>         SFRMOUT asserts when the first bit of the first byte starts
>         transmitting
>  2) Interrupt
>  3) 8 reads, we must have emptied the tx fifo and filled the rx fifo
>         SFRMOUT de-asserts after the the last bit of the last byte is
>         received

Are you printk-ing the diagnostics in the irq routine?
If so, that slows it down enough to ensure every 8-word block underruns.

Here are stats for 512-word transfers from SD card at 3.7 MHz; figures are
number of underruns/total number of reads and the distribution of
words read per interrupt [0..8], collected during the transfer and
printed once the transfer is over)

1/102 [1,0,2,0,0,100,0,0,1]
1/102 [1,0,2,0,0,100,0,0,1]
1/102 [1,0,2,0,0,100,0,0,1]
2/104 [1,1,0,2,21,76,3,1,2]
3/102 [1,1,1,1,11,85,1,1,3]
4/100 [1,0,1,1,7,83,3,2,4]

while 1- and 2-word transfers seem to be caught on the second interrupt.
[1,2,0,0,0,0,0,0,0]
[1,1,0,0,0,0,0,0,0]


>  I have modifed my board so that I now have an external GPIO for the chip
>  select.
Yes, we'll have to do that too.

>  > I'll run a few more tests, e.g. dropping the clock rate
>
> With a slow enough clock you can probably get to a point where SFRMOUT
>  will stay deasserted during the entire 512 byte transfer

I've tried it down to 400kHz and transfers still underrun (!)

So it does seem that SFRMOUT cannot be used as a chip select unless we
revert to the old busy-wait-for-whole-transfer code, which causes 100%
CPU usage during transfers.
and 1ms-long pauses (for 512 words at 3.7MHz).

This suggests that we can only handle SFRMOUT used as chip select
correctly by reinstating polling mode, adding the continuous transfer
code and allowing the board definition code to specify that polling
mode be used for such devices.
(much as I hate polling mode :)

>  But it would
>  still de-assert during the switch to the next transfer in the message.

Am I right in thinking that the GPIO chip select currently remains
asserted as it should during a multi-transfer message?

    M
