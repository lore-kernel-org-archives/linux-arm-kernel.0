From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 02 Sep 2013 16:39:40 +0200
Subject: Clock framework deadlock with external SPI clockchip
In-Reply-To: <20130902111850.GN9594@tbergstrom-lnx.Nvidia.com>
References: <52209D1D.3080102@metafoo.de>
 <20130902111850.GN9594@tbergstrom-lnx.Nvidia.com>
Message-ID: <5224A32C.6070508@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 01:18 PM, Peter De Schrijver wrote:
> On Fri, Aug 30, 2013 at 03:24:45PM +0200, Lars-Peter Clausen wrote:
>> Hi,
>>
>> I'm currently facing a deadlock in the common clock framework that
>> unfortunately is not addressed by the reentrancy patches. I have a external
>> clock chip that is controlled via SPI. So for example to configure the rate
>> of the clock chip you need to send a SPI message. Naturally the clock
>> framework will hold the prepare lock while configuring the rate.
>> Communication in the SPI framework happens asynchronously, spi_sync() will
>> enqueue a message in the SPI masters queue and then wait using
>> wait_for_completion(). The master will call complete() once the transfer has
>> been finished. The SPI master runs in it's own thread in which it processes
>> the messages. In this thread it also calls clk_set_rate() to configure the
>> SPI transfer clock rate based on what the message says. Now the deadlock
>> happens as we try to take the prepare_lock again and since the clock chip
>> and the SPI master run in different threads the reentrancy code does not
>> kick in.
>>
>> The basic sequence is like this:
>>
>> === Clock chip driver ===        === SPI master driver ===
>>  clk_prepare_lock()
>>  spi_sync()
>>    wait_for_completion(X)
>>                                  clk_get_rate()
>> 			           clk_prepare_lock() <--- DEADLOCK
>> 				   clk_prepare_unlock()
>> 				 ...
>> 				 complete(X)
>>  ...
>>  clk_prepare_unlock()
>>
>> I'm wondering if you have any idea how this can be fixed. In my opinion we'd
>> need a per clock mutex to address this properly.
> 
> One workaround is to leave the SPI masters clock always prepared. A similar
> problem can occur with I2C and DVFS using notifiers.


That's kind of what I'm doing right now as a temporary solution. But we'd
basically need to have all SPI or I2C master drivers to be aware that they
might be used for controlling a external clock chip. And there are also
situations where the workaround does not work. E.g. if the clk API is used
to configure the rate of the SPI SCK signal, since the rate can be set by
the spi message.

- Lars
