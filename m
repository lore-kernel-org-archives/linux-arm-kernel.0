From: martinwguy@gmail.com (Martin Guy)
Date: Sun, 11 Apr 2010 15:24:21 +0100
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100410155443.GG2685@gw.healthdatacare.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
	<20100406181839.GA2685@gw.healthdatacare.com>
	<x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
	<l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
	<20100410155443.GG2685@gw.healthdatacare.com>
Message-ID: <j2g56d259a01004110724q7e038392r9b7b33772b66e1f1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/10/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>  Can you try following with your devices?

Woo, nice one!
Same CPU usage (~57%) same throughput (315kb/s) and it's much more
elegant. :) Just using repeated interrupts to handle the last 4 words
instead of the nasty busy-wait loops seems fairer to other interrupts
too!

You can make it even smaller be removing some redundant checks
deriving from the fact that it's synchronous, so N writes always cause
N reads:

>         if (espi->tx == 0 && espi->rx == 0)
>                 espi->fifo_level = 0;

can be

         if (espi->tx == 0)
                 espi->fifo_level = 0;

,

>         while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
>                 espi->rx < t->len) {

         while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)) {

and

>         /* is transfer finished? */
>         if (espi->tx == t->len && espi->rx == t->len) {

         if (espi->rx == t->len) {

Cheers!

    M
