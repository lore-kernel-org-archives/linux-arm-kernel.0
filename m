From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Feb 2012 15:07:55 +0000
Subject: [GIT PULL] cs89x0 platform support
In-Reply-To: <20120201134415.GU1990@pengutronix.de>
References: <20120201134415.GU1990@pengutronix.de>
Message-ID: <201202011507.55627.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 February 2012, Sascha Hauer wrote:
> Please pull the following for next. It contains cs89x0 platform
> support. David has acked the base patch and is fine with this
> patch going via the Arm tree.
> 
> Sascha
> 
> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> 
>   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git features/cs89x0
> 
> Jaccon Bastiaansen (4):
>       CS89x0 : add platform driver support
>       CS89x0 : add CS89x0 platform device to the iMX21ADS board
>       CS89x0 : remove QQ2440 board support from the CS89x0 driver
>       CS89x0 : add CS89x0 platform device to the iMX31ADS board
> 

This is a very nice series, but since you are already working on
that driver, could you also fix it so it does not use inw/outw on
__iomem pointers? This happens to work on ARM right now, but
I'd like to change that in the future and cs89x0 is one out of
very few drivers that get it wrong. My hope is to get to the
point where a non-ISA non-PCI platform would just never provide
inb/outb functions, especially not those that are as broken as
the ones that many ARM platforms provide.

I think the best way would be to use ioport_map in case of ISA
and use ioread16/iowrite16 in the default readword/writeword
functions, which should work fine for all little-endian
versions of cs89x0. You can also make it an runtime choice,
with readw/writew being the default for platform, inw/outw
for ISA and IXP providing their own.

I think it would also be nice to move out the ugly non-CS89x0_PLATFORM
code into a cs89x0-legacy.c file. Ideally, that would also just
contain statically defined platform devices for ISA and IXP2000,
but that is probably not worth the effort.

	Arnd
