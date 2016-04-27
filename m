From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 13:18:10 +0200
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <57209A90.5070707@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <5212316.Wg9FOfdsuU@wuerfel> <57209A90.5070707@arm.com>
Message-ID: <5946329.0yh8Gf9SVh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 11:55:12 Vladimir Murzin wrote:
> ARMv7-A platform want to run without MMU can adjust it's dependency to
> 
> depends on ARCH_MULTI_V7 || ARCH_MULTI_V7R
> 
> where
> 
> config ARCH_MULTI_V7
>         bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
>         depends on MMU
> ...
> 
> config ARCH_MULTI_V7R
>         bool "MMU-less ARMv7 based platforms (Cortex-R)"
>         depends on !MMU
> ...
> 
> It is also should work for purely R-class platform, although I'm not
> keen on Kconfig and may be totally wrong here 

I would not use "depends on ARCH_MULTI_V7 || ARCH_MULTI_V7R" for
a machine that actually has an ARMv7-A core, that would be a bit
confusing.

If we want to allow building a kernel for ARMv7-A with MMU disabled,
I'd drop the 'depends on MMU' for ARCH_MULTI_V7 and move it to
whatever parts of the kernel actually have a build-time dependency
or that are known to be broken in that configuration.

	Arnd
