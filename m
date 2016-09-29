From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 29 Sep 2016 10:02:44 +0200
Subject: [PATCH v3 7/7] i2c: bcm2835: Add support for dynamic clock
In-Reply-To: <87r383g1kb.fsf@eliezer.anholt.net>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-8-git-send-email-noralf@tronnes.org>
 <87r383g1kb.fsf@eliezer.anholt.net>
Message-ID: <109bda50-455e-f91b-a3a1-bf00cb5745db@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.09.2016 23:24, Eric Anholt wrote:
> Noralf Tr?nnes <noralf@tronnes.org> writes:
>
>> Support a dynamic clock by reading the frequency and setting the
>> divisor in the transfer function instead of during probe.
> Is this fixing some particular case you could note in the commit
> message?  As is, it makes me think that we should be using a notifier
> for when the parent clock (that's the one I assume you're talking about
> being dynamic) changes.  But maybe you're working around a variable VPU
> clock being set by the firmware, because we don't have a notifier for
> it?
>
> I'm a bit worried because I think this is going to be pretty expensive
> to be doing per transfer.

Well, the clocks are all configured without CLK_GET_RATE_NOCACHE et. al.,
so the value is read from cache, which is not (very) expensive
(see clk_core_get_rate).

This also means that any clock change of the VPU done by the firmware
does not propagate to the linux kernel anyway and the unchanged
cached value is returned.

To make this work it would require a notification mechanism from the
firmware to trigger a re-validation of all the caches. (or some sort of 
watchdog
process).

Adding a notifier to each driver (I2C, SPI) instead is - imo - a lot of 
unnecessary
code complexity, as any currently running transfer would still be impacted,
because changing the clock-divider in flight is a asking for trouble.
But then changing the vpu-clock speed while a I2s/SPI/... transfer is 
running is
also asking for trouble....

The only place where - IMO - a notifier would make sense is with the 
auxiliar
UART driver(8250_bcm2835aux.c), as there we only read the clock rates
when setting/changing the baud rate. But - again -  this would require some
notification by the firmware in the first place and any reception in the
window of change would go wrong because of unexpected effective baud
rate changes.

So as far as I can tell the change to read the current clock rate in the
transfer function is a reasonable approach and the clock framework should
handle the communication with the firmware about such changes.
(And I remember having had some discussions around this subject
with Phil Elwell or popcornmix some time ago on github where it boiled
down to: what is the "right" interface? - I can not find the reference
right now)

Reviewed-by: Martin Sperl <kernel@martin.sperl.org>

Thanks, Martin
