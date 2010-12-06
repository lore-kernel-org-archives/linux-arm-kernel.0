From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Dec 2010 13:18:24 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <4CFCC048.4030408@ru.mvista.com>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>
	<201011291745.22566.arnd@arndb.de> <4CFCC048.4030408@ru.mvista.com>
Message-ID: <201012061318.24541.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 December 2010, Sergei Shtylyov wrote:
> > There are many differences between readl and __raw_readl, including
> 
> > * __raw_readl does not have barriers and does not serialize with
> >    spinlocks, so it breaks on out-of-order CPUs.
> > * __raw_readl does not have a specific endianess, while readl is
> >    fixed little-endian,
> 
>     I know I'm late but readl()/writel() are CPU-endian, not LE.

If that was the case, it would be a bug. readl/writel is defined to be
the same endianess as PCI, which is little-endian. Otherwise you would
not be able to use any PCI devices on big-endian ARM machines. The
definition of readl is

#define readl(addr) __le32_to_cpu(__raw_readl(addr))

which converts the little-endian I/O register into a native endian
CPU register.


	Arnd
