From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 22:39:02 +0000
Subject: [PATCH] stm: select CONFIG_SRCU
In-Reply-To: <12747713.N26XusNZpW@wuerfel>
References: <12747713.N26XusNZpW@wuerfel>
Message-ID: <20151116223902.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 10:14:35PM +0100, Arnd Bergmann wrote:
> The newly added STM code uses SRCU, but does not ensure that
> this code is part of the kernel:
> 
> drivers/built-in.o: In function `stm_source_link_show':
> include/linux/srcu.h:221: undefined reference to `__srcu_read_lock'
> include/linux/srcu.h:238: undefined reference to `__srcu_read_unlock'
> drivers/built-in.o: In function `stm_source_link_drop':
> include/linux/srcu.h:221: undefined reference to `__srcu_read_lock'
> include/linux/srcu.h:238: undefined reference to `__srcu_read_unlock'
> 
> This adds a Kconfig 'select' statement like all the other SRCU using
> drivers have.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")

Related to this, I have to ask why if I answer to N to STM, I'm then
presented with the STM driver options in this file.  It's not like
they'll be built, as drivers/Makefile has:

obj-$(CONFIG_STM)               += hwtracing/stm/

so it seems rather pointless..  Maybe the other options here should
be wrapped with if STM..endif ?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
