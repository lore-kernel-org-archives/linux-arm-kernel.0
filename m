From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Aug 2015 11:59:57 +0100
Subject: [PATCH 1/3] spi: bitbang: Replace spinlock by mutex when calling
 chipselect
In-Reply-To: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Message-ID: <20150804105957.GI20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 02:09:56PM +0800, Nicolas Boichat wrote:
> Enabling CONFIG_DEBUG_ATOMIC_SLEEP in kernel configuration, we get
> this warning in spi_gpio_setup:
> [    1.177747] BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:1431
> [    1.190182] in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
> [    1.196922] 3 locks held by swapper/0/1:

Please don't include entire stack traces in commit logs, they're
enormous and overwhelm the actual content (like here where the trace is
much bigger than the actual commit message).  If you feel the
information from the trace adds something please present *edited*
highlights instead.

> Actually, I'm not sure if I understand the existing code: why are we not
> waiting for busy to go down to 0, then call chipselect, instead of not calling
> it at all if the bus happens to be busy when we setup the device? With the
> current approach, it would be easy to just use an unconditional mutex_lock.

We shouldn't be blocking waiting for the bus to become free, that's not
how the interface works.

> Also, is it harmful to deactivate the newly setup device in spi_bitbang_setup,
> even if the bus is busy with another device? chipselect should be independent
> for each device (or is it not?). So I'm not clear why we need any locking at
> all...

If you assert chip select on one device while another device is still
being interacted with then the new device will see the traffic for the
old device and become confused.

> Anyway, this patch series does not change the existing behaviour, applies on
> top of broonie-sound/for-next, and, along with the 2 follow-up patches, was
> compile-tested on x86-64/arm (allyesconfig) and ppc44x (defconfig+SPI driver),
> and runtime-tested on an arm platform.

I'm not seeing enough analysis in the commit log of what's being locked
and why - I don't fully understand what the busy stuff is for either
(not that I've looked at the code in detail just now) but I think that's
going to be the key thing here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/7bc725ed/attachment-0001.sig>
