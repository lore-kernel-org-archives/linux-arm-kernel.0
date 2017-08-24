From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Aug 2017 17:06:33 +0100
Subject: [PATCH] [RFC] ARM: vdso: work around gcc-8 warning
In-Reply-To: <20170823140538.1590432-1-arnd@arndb.de>
References: <20170823140538.1590432-1-arnd@arndb.de>
Message-ID: <20170824160633.GW20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 04:05:26PM +0200, Arnd Bergmann wrote:
> gcc-8 correctly points out that reading four bytes from a pointer to a
> 'char' variable is wrong
> 
> arch/arm/kernel/vdso.c: In function 'vdso_init':
> arch/arm/kernel/vdso.c:200:6: error: '__builtin_memcmp_eq' reading 4 bytes from a region of size 1 [-Werror=stringop-overflow=]
> 
> However, in this case the variable just stands for the beginning of the
> vdso and is not actually a 'char', so the code is doing what it is meant
> to do.
> 
> Not sure what the best solution for this is, changing the hack to
> declare the variable as 'int' instead makes the warning go away.

Well, one way to look at the code is an array of characters, so
we could say that it should be:

extern char vdso_start[], vdso_end[];

which is exactly the same construct that we use for _stext and
similar.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
