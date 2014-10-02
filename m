From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 16:39:45 +0200
Subject: [PATCH 1/3 V2] CNS3xxx: Fix debug UART.
In-Reply-To: <m3oatzaqdz.fsf@t19.piap.pl>
References: <m3d2av3lgt.fsf@t19.piap.pl> <m3oatzaqdz.fsf@t19.piap.pl>
Message-ID: <2989906.dE3tTh8Pqq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 08:32:08 Krzysztof Ha?asa wrote:
> UARTs on CNS3xxx are 8250-compatible, not AMBA.
> The base address for UART0 is 0x78000000 (physical)
> and 0xfb002000 (virtual).
> 
> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

I've applied it on next/soc now, as this seems to be an
important fix but it also interacts with other stuff we
have in next/soc already and I want to avoid conflicts.

One question though, just to make sure it's correct:

> @@ -1094,6 +1094,7 @@ config DEBUG_UART_PHYS
> +       default 0x78000000 if DEBUG_CNS3XXX

> @@ -1155,6 +1155,7 @@ config DEBUG_UART_VIRT
> +       default 0xfb002000 if DEBUG_CNS3XXX

It seems strange that the offset from the base address is
different for the VIRT and PHYS part. The early boot code
tries to map the registers using a supersection mapping,
which requires the same alignment within a 2MB area.

Do you know what is going on here?

	Arnd
