From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Apr 2012 13:58:28 +0000
Subject: [PATCH 02/17] ARM clps711x: Added Cirrus Logic EP7312 CPU variant
In-Reply-To: <20120421122044.GF24211@n2100.arm.linux.org.uk>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <201204211211.36273.arnd@arndb.de>
 <20120421122044.GF24211@n2100.arm.linux.org.uk>
Message-ID: <201204221358.29315.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, Russell King - ARM Linux wrote:
> The headers still have to end up being in an accessible place, and having
> drivers include the minimum required is a good idea.  Merely moving them
> into include/mach and updating the include statements as far as I'd go.
> (and I've never liked the idea of mach/hardware.h being an "include the
> world for this platform" header file.)

Digging a bit deeper into clps711x, I found that with Alexander's patch
series applied, there is nothing that actually includes the three
asm/hardware/ep7*.h files. I wonder about the motivation behind providing
them. Any reason we can't just remove those three files altogher?

Note that if we were to actually start using those files, this section
of mach/hardware.h would be broken:

#if defined (CONFIG_SOC_EP7211)
#include <asm/hardware/ep7211.h>
#elif defined (CONFIG_SOC_EP7212)
#include <asm/hardware/ep7212.h>
#elif defined (CONFIG_SOC_EP7213)
#include <asm/hardware/ep7312.h>
#endif

Because we can have more than one of these socs enabled in the
same configuration and enabling CONFIG_SOC_EP7211 would make the
other two headers invisible.

	Arnd
