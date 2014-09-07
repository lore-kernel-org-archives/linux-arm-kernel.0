From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 07 Sep 2014 23:06:05 +0200
Subject: [PATCH ] ARM: pxa: fix section mismatch warning for
 pxa_timer_nodt_init
In-Reply-To: <12220413.BdRleC0Xf5@wuerfel>
References: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>
 <87oawivarv.fsf@free.fr> <12220413.BdRleC0Xf5@wuerfel>
Message-ID: <3188925.pjYA4K7kjn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 July 2014 20:50:36 Arnd Bergmann wrote:
> commit a38b1f60b5245a3 ("ARM: pxa: Add non device-tree timer link to
> clocksource") introduced a harmless section mismatch warning for
> all pxa platforms, by introducing a new pxa_timer_init() function
> that is not marked __init but that calls pxa_timer_nodt_init(),
> which is. The function is only called at init time, so it is safe
> to also annotate it this way.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

Apparently this is not merged yet, should we take it through arm-soc?

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 630fa916bbc6..04b013fbc98f 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL(get_clock_tick_rate);
 /*
  * For non device-tree builds, keep legacy timer init
  */
-void pxa_timer_init(void)
+void __init pxa_timer_init(void)
 {
        pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000),
                            get_clock_tick_rate());
