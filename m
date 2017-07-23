From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 23 Jul 2017 17:53:03 +0200
Subject: [PATCH 04/12] ARM: sa1100/pxa: fix MTD_XIP build
In-Reply-To: <20170720155209.3250880-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Thu, 20 Jul 2017 17:51:42 +0200")
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155209.3250880-1-arnd@arndb.de>
Message-ID: <871sp7rvz4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

Hi Arnd,

> -#define xip_irqpending()	(ICIP & ICMR)
> +/* restored July 2017, this did not build since 2011! */
> +
> +#define ICIP			io_p2v(0x40d00000)
> +#define ICMR			io_p2v(0x40d00004)
Okay, I suppose the IO mapping is guaranteed to work, ie. io_p2v() is behaving
correctly when xip_irqpending() is used, right ? I'm not challenging this, I'm
just ensuring this _could_ work (if anybody had the silly idea to make it work
again, and I admit I don't have that much courage).

> +#define xip_irqpending()	readl(ICIP) & readl(ICMR)
This is not strictly equivalent to (ICIP & ICMR), I would have put for priority
reasons :
+#define xip_irqpending()	(readl(ICIP) & readl(ICMR))

..zip..

Cheers.

-- 
Robert
