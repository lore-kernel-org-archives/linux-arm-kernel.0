From: martinwguy@gmail.com (Martin Guy)
Date: Sun, 25 Apr 2010 10:38:32 +0100
Subject: [spi-devel-general] [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
References: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
Message-ID: <m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry about the incomplete message. Finger trouble.

On 4/25/10, Martin Guy <martinwguy@gmail.com> wrote:
...
>  SFRMOUT will have gone high:

>         if (espi->tx  >0 && espi->tx < t->len
               && !(ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_BSY)) {
>                 /* More to transmit but device has gone idle means that
>                  * SFRMOUT will have gone high */
>                 printk("ep93xx-spi: Underrun\n");
>         }

I've also done a version that doesn't printk() in the middle of it,
which affects timing, but counts the underruns and reports at end of
transfer. The result is that every 512-byte block underruns at least
once, sometimes twice.

I'll run a few more tests, e.g. dropping the clock rate, but at this
point I'd be inclined to declare it impossible to keep SFRMOUT low
during a transfer, and just use the simple non-continuous code with a
comment at the top of the file that explains why you can't use SFRMOUT
as a chip select for devices that require CS to remain asserted for
the duration of a transfer.

    M
