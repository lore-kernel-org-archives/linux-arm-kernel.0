From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 03 Sep 2013 16:22:29 -0700
Subject: Clock framework deadlock with external SPI clockchip
In-Reply-To: <52209D1D.3080102@metafoo.de>
References: <52209D1D.3080102@metafoo.de>
Message-ID: <20130903232229.10934.60438@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lars-Peter Clausen (2013-08-30 06:24:45)
> Hi,
> 
> I'm currently facing a deadlock in the common clock framework that
> unfortunately is not addressed by the reentrancy patches. I have a external
> clock chip that is controlled via SPI. So for example to configure the rate
> of the clock chip you need to send a SPI message. Naturally the clock
> framework will hold the prepare lock while configuring the rate.
> Communication in the SPI framework happens asynchronously, spi_sync() will
> enqueue a message in the SPI masters queue and then wait using
> wait_for_completion(). The master will call complete() once the transfer has
> been finished. The SPI master runs in it's own thread in which it processes
> the messages. In this thread it also calls clk_set_rate() to configure the
> SPI transfer clock rate based on what the message says. Now the deadlock
> happens as we try to take the prepare_lock again and since the clock chip
> and the SPI master run in different threads the reentrancy code does not
> kick in.
> 
> The basic sequence is like this:
> 
> === Clock chip driver ===        === SPI master driver ===
>  clk_prepare_lock()
>  spi_sync()
>    wait_for_completion(X)
>                                  clk_get_rate()
>                                    clk_prepare_lock() <--- DEADLOCK
>                                    clk_prepare_unlock()
>                                  ...
>                                  complete(X)
>  ...
>  clk_prepare_unlock()

Is there a synchronous equivalent to spi_sync()?

> 
> I'm wondering if you have any idea how this can be fixed. In my opinion we'd
> need a per clock mutex to address this properly.

Increasing the number of locks is a pain in the ass. Per-clock mutexes
not only have a memory impact but in general nested locks do not play
nice with lockdep (which assumes a depth no greater than 8 nested locks,
which is often not enough for complex clock trees). And generating
unique lock subclasses helps with this but makes for terrible, ugly
code.

Another idea (which I have not thought about much) is to have async clk
api's. I think there might be many uses for async clock api's besides
just this case. Think about a GPU driver that scales the main clock
feeding a GPU. Maybe the driver doesn't care to block on clk_set_rate
which might block for 100mS if voltage scaling is involved.
clk_set_rate_async() might preferable.

Regards,
Mike

> 
> Thanks,
> - Lars
