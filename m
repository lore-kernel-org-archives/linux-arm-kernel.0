From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 30 Aug 2013 15:24:45 +0200
Subject: Clock framework deadlock with external SPI clockchip
Message-ID: <52209D1D.3080102@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm currently facing a deadlock in the common clock framework that
unfortunately is not addressed by the reentrancy patches. I have a external
clock chip that is controlled via SPI. So for example to configure the rate
of the clock chip you need to send a SPI message. Naturally the clock
framework will hold the prepare lock while configuring the rate.
Communication in the SPI framework happens asynchronously, spi_sync() will
enqueue a message in the SPI masters queue and then wait using
wait_for_completion(). The master will call complete() once the transfer has
been finished. The SPI master runs in it's own thread in which it processes
the messages. In this thread it also calls clk_set_rate() to configure the
SPI transfer clock rate based on what the message says. Now the deadlock
happens as we try to take the prepare_lock again and since the clock chip
and the SPI master run in different threads the reentrancy code does not
kick in.

The basic sequence is like this:

=== Clock chip driver ===        === SPI master driver ===
 clk_prepare_lock()
 spi_sync()
   wait_for_completion(X)
                                 clk_get_rate()
			           clk_prepare_lock() <--- DEADLOCK
				   clk_prepare_unlock()
				 ...
				 complete(X)
 ...
 clk_prepare_unlock()

I'm wondering if you have any idea how this can be fixed. In my opinion we'd
need a per clock mutex to address this properly.

Thanks,
- Lars
