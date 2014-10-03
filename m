From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 03 Oct 2014 12:22:20 +0200
Subject: [PATCH 1/3 V2] CNS3xxx: Fix debug UART.
In-Reply-To: <2989906.dE3tTh8Pqq@wuerfel> (Arnd Bergmann's message of "Thu, 02
 Oct 2014 16:39:45 +0200")
References: <m3d2av3lgt.fsf@t19.piap.pl> <m3oatzaqdz.fsf@t19.piap.pl>
 <2989906.dE3tTh8Pqq@wuerfel>
Message-ID: <m3lhoxh2qr.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> One question though, just to make sure it's correct:
>
>> @@ -1094,6 +1094,7 @@ config DEBUG_UART_PHYS
>> +       default 0x78000000 if DEBUG_CNS3XXX
>
>> @@ -1155,6 +1155,7 @@ config DEBUG_UART_VIRT
>> +       default 0xfb002000 if DEBUG_CNS3XXX
>
> It seems strange that the offset from the base address is
> different for the VIRT and PHYS part. The early boot code
> tries to map the registers using a supersection mapping,
> which requires the same alignment within a 2MB area.

Interesting indeed. I thought it's a regular page mapping.

I think a supersection is a 16 MB mapping and the early code in
__create_page_tables() uses 1 MB section instead (probably for
simplicity). This still means the physical address actually used is
0x78002000, not exactly per specs.

#define CNS3XXX_UART0_BASE                      0x78000000      /* UART 0 */
#define CNS3XXX_UART0_BASE_VIRT                 0xFB002000
#define CNS3XXX_UART1_BASE                      0x78400000      /* UART 1 */
#define CNS3XXX_UART2_BASE                      0x78800000      /* UART 2 */

I wonder if the early ll debug code (with the initial section mapping)
produces any output at all (by default). The first thing I see on the
serial console is:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x900
Linux version 3.17.0-rc7+ xxx
CPU: ARMv6-compatible processor [410fb024] revision 4 (ARMv7), cr=00c5787d

(this ARMv7 thing is a bit misleading, though).
The "Booting..." and "Linux version" lines are printed with the initial
mapping, before setup_arch()->debug_ll_io_init() updates it, right?

FWIW I have changed CNS3XXX_UART0_BASE to 0x78002000 and it works the
same. The registers are probably "aliased" all over the place.

I guess we should eventually change the mappings so the UART is at
a section boundary.
--
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
