From: dietrich@cs.fau.de (Christian Dietrich)
Date: Mon, 23 Apr 2012 14:43:15 +0200
Subject: Possible integer overflow in mach-bcmring with FPGA11107
Message-ID: <86r4veipp8.fsf@gandalf.zerties.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

due to statical analysis, i think i found a possible integer overflow
in the timer (sp804) code, when mach-bcmring is used together with
FPGA11107. All following line numbers are according to Linux v3.2, but
the problem should be still in Linux HEAD (if i haven't missed anything).

Ok here is the Problem:

,----[arch/arm/mach-bcmring/clock.h:24]------------------
| struct clk {
| [..]
|         unsigned long rate_hz;  /* clock rate in Hz */
| [..]
| };
`----

,----
| % arm-linux-gnueabihf-cpp-4.6 -dM /dev/null | grep __SIZEOF_LONG__
| #define __SIZEOF_LONG__ 4
`----

As you see rate_hz is defined as long, but long is according to
gnueabihf (and gnueabi) 4 bytes long. I hope i got the right compiler
here.

,----[arch/arm/mach-bcmring/include/mach/csp/tmrHw_reg.h]----
| #if defined(CFG_GLOBAL_CHIP) && (CFG_GLOBAL_CHIP == FPGA11107)
| #define tmrHw_HIGH_FREQUENCY_MHZ        150     /* Always 150MHz for FPGA */
| #define tmrHw_HIGH_FREQUENCY_HZ         150000000
| #else
| [..]
| #endif
`----

When FPGA11107 is used the frequency is set to 150 000 000 Hz.

,----[arch/arm/mach-bcmring/core.c:100]---
| #if defined(CONFIG_ARCH_FPGA11107)
| /* fpga cpu/bus are currently 30 times slower so scale frequency as well to */
| /* slow down Linux's sense of time */
| [..]
| #define TIMER3_FREQUENCY_KHZ   (tmrHw_HIGH_FREQUENCY_HZ / 1000 * 30)
| #else
| [..]
| #define TIMER3_FREQUENCY_KHZ  (tmrHw_HIGH_FREQUENCY_HZ / 1000)
| #endif
`----

,----[arch/arm/mach-bcmring/core.c:121]---
| static struct clk sp804_timer3_clk = {
|         .name = "sp804-timer-3",
|         .type = CLK_TYPE_PRIMARY,
|         .mode = CLK_MODE_XTAL,
|         .rate_hz = TIMER3_FREQUENCY_KHZ * 1000,
| };
`----

This seems totally innocent, but when doing the caluculation for
rate_hz by hand (or python) the result is slighly bigger than
2^32-1. Therfore an integer overflow should occur and the rate_hz rate
will be far too low. It may be that there is a sanity check in
hardware, but i don't know the used hardware at all.

,----[python shell]
| >>> tmrHw_HIGH_FREQUENCY_HZ = 150000000
| >>> TIMER3_FREQUENCY_KHZ = (tmrHw_HIGH_FREQUENCY_HZ / 1000 * 30)
| >>> rate_hz = TIMER3_FREQUENCY_KHZ * 1000
| >>>
| >>> import math
| >>> math.log(rate_hz, 2) # Bits used
| 32.06727785542857
| >>> rate_hz % 2**32
| 205032704L
`----

I hope my observations are correct, and this is a real bug and i
didn't just waste your time. For better testing the issue i will
append the used configuration. I just did:

,----
| cp ~/mach-bcmring.config .config
| ARCH=arm make silentoldconfig
| ARCH=arm SUBARCH=arm KERNELVERSION="v3.2" make arch/arm/mach-bcmring/core.o  CC=arm-linux-gnueabi-gcc-4.5
| [...]
|    CC      arch/arm/mach-bcmring/core.o
| arch/arm/mach-bcmring/core.c:125:34: warning: integer overflow in expression
`----

chris

-------------- next part --------------
A non-text attachment was scrubbed...
Name: mach-bcmring.config
Type: application/octet-stream
Size: 53541 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/e830d7f7/attachment-0001.obj>
-------------- next part --------------
-- 
(? x . x x) (? x . x x) -- See how beautiful the lambda is
? No documentation is better than bad documentation
? and always be awesome to each other, always.
