From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2016 11:56:16 +0200
Subject: [PATCH] smc91x: remove ARM hack for unaligned 16-bit writes
In-Reply-To: <1899384.M1jdqOztqi@wuerfel>
References: <20160825144314.1850730-1-arnd@arndb.de>
 <20160825223743.GK1041@n2100.armlinux.org.uk> <1899384.M1jdqOztqi@wuerfel>
Message-ID: <4142998.LszVVqOYjE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 26, 2016 11:41:21 AM CEST Arnd Bergmann wrote:
> 
> I think this breaks machines that declare a device that just lists
> SMC91X_USE_32BIT but not SMC91X_USE_16BIT. Right now, the way this
> is interpreted is to use 32-bit accessors for most things, but
> not avoiding 16-bit reads.

I guess my patch has the same problem here, with the

	if (SMC_CAN_USE_8BIT && !SMC_16BIT(lp))

check that is true when a platform device is declared with 32-bit
I/O only but all three are enabled at compile-time. The best check
I can think of here (aside from redefining how the flags work)
would be

#define SMC_8BIT_ONLY(p) 	\
	(((p)->cfg.flags & (SMC91X_USE_8BIT |SMC91X_USE_16BIT | SMC91X_USE_32BIT)) == \
	 SMC91X_USE_8BIT)


	Arnd
