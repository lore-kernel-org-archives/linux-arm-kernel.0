From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 19:41:27 -0300
Subject: [PATCH 2/4] watchdog: orion: Use the reference clock on Armada
 375 SoC
In-Reply-To: <20141022140221.GP9845@lunn.ch>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413984884-20273-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140221.GP9845@lunn.ch>
Message-ID: <54483297.90102@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 11:02 AM, Andrew Lunn wrote:
> On Wed, Oct 22, 2014 at 10:34:42AM -0300, Ezequiel Garcia wrote:
>> The 25 MHz reference clock has better stability so its use is preferred over the
>> core clock. Changes the Armada 375 clock initialization to use this reference
>> clock. To ensure the driver is compatible with an old devicetree, also provide
>> a fallback path which will silently return to the previous behavior.
> 
> Hi Ezequiel
> 
> There is now quite a lot of code in orion_wdt.c which is not relevant
> to Orion5x and Kirkwood. Would it be possible to put some of it inside
> a #ifdef MACH_MVEBU_V7?
> 

Hum.. I found ifdefs scary, so I tend to avoid them if at all possible.
Just did a quick hack enclosing all the armada-xxx stuff around #if 0
and here's the result:

$ ./scripts/bloat-o-meter ~/linux/.builds/mvebu_v7/drivers/watchdog/orion_wdt.o ~/linux/.builds/orion5x/drivers/watchdog/orion_wdt.o
add/remove: 0/0 grow/shrink: 1/4 up/down: 12/-80 (-68)
function                                     old     new   delta
orion_wdt_probe                              732     744     +12
orion_wdt_get_timeleft                        44      40      -4
orion_enabled                                 68      60      -8
orion_start                                  120      88     -32
orion_wdt_ping                                80      44     -36

To be honest, I don't think it's worth the ugliness.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
