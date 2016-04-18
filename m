From: sr@denx.de (Stefan Roese)
Date: Mon, 18 Apr 2016 15:00:52 +0200
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <4248364.c0REkIZjj0@wuerfel>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <4437692.8jaX7AeWuo@wuerfel> <20160418110415.GT3217@sirena.org.uk>
 <4248364.c0REkIZjj0@wuerfel>
Message-ID: <5714DA84.2050505@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.04.2016 13:32, Arnd Bergmann wrote:
> On Monday 18 April 2016 12:04:15 Mark Brown wrote:
>> On Mon, Apr 18, 2016 at 12:51:55PM +0200, Arnd Bergmann wrote:
>>
>>> This would be easier if have a conclusive proof that 1MB per CS always enough.
>>> Is this something that is guaranteed in the SPI spec or the documentation for
>>> this controller?
>>
>> There's no spec for SPI but if there were it'd be hard to see it
>> imposing a limit, one can transfer data as long as the bus is clocked
>> (which some things like ADCs and DACs make use of).
>>
>
> I just reread Stefan's patch and realized that I had fundamentally
> misunderstood how the transfer is done: I thought the offset inside of
> the window was used to address a NOR flash directly, but it seems
> it is just used to send arbitrarily long commands.

Yes. SPI NOR flash support definitely needs some additional patches.
To support the address and commands being inserted in the SPI
messages via the corresponding registers. Again, this patch is
only intended and tested for very "simple" TX messages without any
addresses being inserted at all.

> This means that the 1MB window is probably a reasonable size (provided
> that the (most importantly) the SPI-NOR driver can guarantee that it
> never exceeds this).

I have no problem switching from 1MiB to using 0xffffffff in the
SPI controller 'reg' node to allow even bigger windows in v6.

> It also means that we are probably better off using the single-window mode
> of the SPI controller, where all CS lines share a single mbus window.
> The only real difference here is that we can map all endpoints using a
> single contiguous window into the CPU address space if we want, or we
> can still map them separately on a given board if that results in a nicer
> layout.

Frankly, I've just read about this single-window mode for the first
time. What I miss here in this mode though, is the configuration of
the SPI device (chip-select 0...7) for this direct-mode in the SPI
driver. With the currently implemented separate window method, your
suggested method is easy: Either is window can be mapped (direct-mode)
or not (indirect-mode). With this single-window mode I'm missing the
per-device configuration for direct-mode. Or what is your idea on
how to configure this access-mode in this case?

Thanks,
Stefan
