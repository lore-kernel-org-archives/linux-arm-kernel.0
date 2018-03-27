From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Mar 2018 09:47:40 +0200
Subject: sun6i SPI driver issue
In-Reply-To: <1aab0d1b-cdd4-cdbc-0242-af5d180e581b@orpaltech.com>
References: <536bf3b1-4440-d060-b22f-2ce7321f4c13@orpaltech.com>
 <20180326114556.6xgxzq3jrbpah47n@flea>
 <1aab0d1b-cdd4-cdbc-0242-af5d180e581b@orpaltech.com>
Message-ID: <20180327074740.epkhjsu3bqhgk32d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please don't reply in HTML.

On Mon, Mar 26, 2018 at 02:57:27PM +0300, Sergey Suloev wrote:
> On 03/26/2018 02:45 PM, Maxime Ripard wrote:
> 
>     On Mon, Mar 19, 2018 at 06:43:43PM +0300, Sergey Suloev wrote:
> 
>         I have recently found a critical issue with sun6i SPI driver. It actually
>         found it long time ago while using spidev but I didn't considered it as
>         something important. Now it seems like a blocking issue that prevents using
>         the driver in any serious application.
> 
>     So is it "critical" or "not important"?
> 
> 
>         I have created a DRM driver for a ili9488-based display, its source is
>         available here [1] and device tree overlay [2]. The driver has been
>         successfully verified on RPi3, but? it is failing on sunxi: the driver gets
>         loaded, display seems working but SPI transfers are periodically failing
>         with error -110 (timeout). Due to the issue the picture is frozen and
>         completely refreshed again from time to time.
> 
>     On which kernel version was this tested?
> 
>     Do you have any additional details on what exactly is happening?
> 
>     Is it timeouting because you never received any interrupts? Is the
>     first part of your transfer (the one that would fit in the FIFO
>     actually done, and it's the second part that fails? Something else?
>
> the issue is related to wrong PIO algorithm in sun6i SPI driver: the transfer
> length must be <= FIFO length in PIO mode, i.e. the current implementation is
> 100% broken.

Right, but you still don't give any detail on what "the issue" is
exactly, so it's kind of difficult to try to come up with a fix for
it.

> I put the restriction? above and tested with BPi M2 with ili9488
> slave - it works perfectly.

The current code has:
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-sun6i.c#L195

Which seems to match what you're saying. So what did you change
exactly?

> I also applied DMA stuff offered? by Michal ([3] hramrach at gmail.com)
> and it works great too.

That patch has never been sumbitted upstream as far as I know, so
I don't really care about it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/3ff3ed71/attachment.sig>
