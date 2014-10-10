From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Oct 2014 21:42:21 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141010182604.GC6075@katana>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk> <20141010182604.GC6075@katana>
Message-ID: <2769473.KEN6DZKnT7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 October 2014 20:26:05 Wolfram Sang wrote:
> 
> You got me wondering, though, that it could not be correct to call
> platform_driver_register() from the platform core instead of module
> init. I will check tomorrow. Still, this would be a bug independent of
> my series. Although I'd need to respin it if platform_driver_probe()
> needed a fix.

Right, this seems to be a preexisting bug. platform_create_bundle 
and platform_driver_probe will both overwrite the .owner field with
NULL since they live in builtin code. They need to be replaced with
__platform_driver_probe and __platform_driver_register that both
take an extra owner argument passed down from the caller in the driver
module.

	Arnd
