From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Sep 2014 14:17:29 +0100
Subject: [PATCH 7/8] ARM: l2x0: support associativity from DT
In-Reply-To: <1409659354-23553-8-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
 <1409659354-23553-8-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140902131729.GQ30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 02:02:33PM +0200, Linus Walleij wrote:
> The ARM RealView platforms comes with boot loaders that fail
> to set up cache size, ways and associativity correctly. This
> complements Florian's patch to set up cache size and sets from
> the device tree with the possibility to set up associativity
> on the L2C-220 cache variant.

Do we need this?

If we have the cache size, the number of sets, and the cache block size
(cache line size) which are all ePAPR specified properties for a cache,
then:

	number of cache blocks = cache size / cache block size
	ways of associativity = number of cache blocks / number of sets
	way size = cache block size * number of sets

It's a tad annoying to have to convert between the two representations,
but ePAPR decided on size, sets and block size rather than size and
ways.

See arch/powerpc/kernel/cacheinfo.c line 260 for the powerpc
associativity calculations from these values.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
