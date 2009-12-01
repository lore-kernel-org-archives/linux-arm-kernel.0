From: derkling@gmail.com (Patrick Bellasi)
Date: Tue, 1 Dec 2009 09:58:57 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
In-Reply-To: <cd73a99e0911301236pd18a382o6faa04c15b3bf9c@mail.gmail.com>
References: <20091129234917.GB18841@game.jcrosoft.org>
	<1259574486-13391-1-git-send-email-derkling@gmail.com>
	<1259574486-13391-2-git-send-email-derkling@gmail.com>
	<cd73a99e0911301236pd18a382o6faa04c15b3bf9c@mail.gmail.com>
Message-ID: <aa8983610912010058j738df89fyd75e9e75973e94ed@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 9:36 PM, Andrew Victor <avictor.za@gmail.com> wrote:
> hi Patrick,
>
>> This patch update the at91_eth_data to handle the usage of PA10 and PA11
>> for EMAC's EXT2 and EXT3 signals.
>
>> @@ -83,6 +83,7 @@ struct at91_eth_data {
>> ? ? ? ?u32 ? ? ? ? ? ? phy_mask;
>> ? ? ? ?u8 ? ? ? ? ? ? ?phy_irq_pin; ? ?/* PHY IRQ */
>> ? ? ? ?u8 ? ? ? ? ? ? ?is_rmii; ? ? ? ?/* using RMII interface? */
>> + ? ? ? u8 ? ? ? ? ? ? ?use_twi_pins; ? /* ETX2-ETX3 on PA23-PA24 */
>> ?};
>
> The "at91_eth_data" structure is used on all AT91 processors with a
> MACB peripheral (AT572D940HF, CAP9, 9620, 9263).
> So this isn't really a nice cross-platform change.

That's true: different chips use different GPIO multiplexing.
However, we should provide an "extensible" support for board which
don't use the reference design routing.

Personally I don't like the solution proposed by Jean-Christophe to
use a name which is "generic enough to match all soc": indeed that
solution is not well self-describing.

I noticed that the board.h already use ifdefs to customise data
structures for different SoC. This could be a valuable solution to
support SoC specific data too.
Thus, I personally prefer the solution showed thereafter, where we have:
1. explicit definition of what SoC support that configuration parameter
2. use a self-explaining name which provide a more readable code
within the SoC specific code that use the data structure (e.g.
at91sam9260_devices.c)
3. the same approach could be extended to others data structure,
whenever it is necessary, without triggering a new discussion on ML
about what could be "the better name for..."

So, what about that?

iff --git a/arch/arm/mach-at91/include/mach/board.h
b/arch/arm/mach-at91/include/mach/board.h
index f452ae5..7fbcee3 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -83,7 +83,9 @@ struct at91_eth_data {
        u32             phy_mask;
        u8              phy_irq_pin;    /* PHY IRQ */
        u8              is_rmii;        /* using RMII interface? */
+#if defined(CONFIG_ARCH_AT91SAM9260)
        u8              use_twi_pins;   /* ETX2-ETX3 on PA23-PA24 */
+#endif
 };
 extern void __init at91_add_device_eth(struct at91_eth_data *data);


> Regards,
> ?Andrew Victor
Bye Patrick

-- 
#include <best/regards.h>

DERKLING
LRU 338214 (http://counter.li.org)

<---------------------------------------------------------------------------------------------------------->
   Patrick Bellasi <bellasi@elet dot polimi dot it>
   PhD student at Politecnico di Milano

   Contacts:
    - ICQ         344672588
    - MSN       derkling at yahoo dot it
    - Skype     derkling

   Personal Sites:
    - Bookmarks
           http://del.icio.us/derkling
    - Bibliography
           http://www.bibsonomy.org/user/derkling

   Privacy:
    - GnuPG     0x72ABC1EE (keyserver.linux.it)
       pub      1024D/72ABC1EE 2003-12-04
       Key fingerprint = 3958 7B5F 36EC D1F8 C752
                                9589 C3B7 FD49 72AB C1EE
<---------------------------------------------------------------------------------------------------------->
