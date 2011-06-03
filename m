From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2011 11:43:27 -0700
Subject: [PATCH v4] ARM: ep93xx: use more reliable CPLD watchdog for reset
	on ts72xx
In-Reply-To: <1307125685-5110-1-git-send-email-ynezz@true.cz>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4A7E@AUSP01VMBX24.collaborationhost.net>
	<1307125685-5110-1-git-send-email-ynezz@true.cz>
Message-ID: <BANLkTikMGkwVp4bGPbdSdx61PLUw23sWkFFxyThLTMkrnqpCCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 3, 2011 at 11:28 AM, Petr ?tetiar <ynezz@true.cz> wrote:
> On all ep93xx based boards from Technologic Systems, there's CPLD watchdog
> available, so use this one to reset the board instead of the soft reset in
> CPU. ?I've seen some weird lockups with the soft reset on ep93xx in the past,
> while the reset via CPLD watchdog seems to be rock solid (tm) and works fine
> so far.
>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> ---
> ?arch/arm/mach-ep93xx/include/mach/system.h | ? 18 +++++++++++++-----
> ?1 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index 6d661fe..67ec430 100644
> --- a/arch/arm/mach-ep93xx/include/mach/system.h
> +++ b/arch/arm/mach-ep93xx/include/mach/system.h
> @@ -2,7 +2,10 @@
> ?* arch/arm/mach-ep93xx/include/mach/system.h
> ?*/
>
> +#include <linux/io.h>
> +
> ?#include <mach/hardware.h>
> +#include <mach/ts72xx.h>
>
> ?static inline void arch_idle(void)
> ?{
> @@ -13,11 +16,16 @@ static inline void arch_reset(char mode, const char *cmd)
> ?{
> ? ? ? ?local_irq_disable();
>
> - ? ? ? /*
> - ? ? ? ?* Set then clear the SWRST bit to initiate a software reset
> - ? ? ? ?*/
> - ? ? ? ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> - ? ? ? ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> + ? ? ? if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> + ? ? ? ? ? board_is_ts7300() || board_is_ts7400()) {
> + ? ? ? ? ? ? ? /* We use more reliable CPLD watchdog to perform the reset */
> + ? ? ? ? ? ? ? __raw_writeb(0x5, TS72XX_WDT_FEED_PHYS_BASE);
> + ? ? ? ? ? ? ? __raw_writeb(0x1, TS72XX_WDT_CONTROL_PHYS_BASE);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? /* Set then clear the SWRST bit to initiate a software reset */
> + ? ? ? ? ? ? ? ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> + ? ? ? ? ? ? ? ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> + ? ? ? }

It would be nicer to introduce a function pointer here, that's filled
in by the ts72xx.c machine_init function but NULL by default:


extern void (*ep93xx_reset)(void);
...

arch_reset():

   local_irq_disable();

   if (ep93xx_reset) {
      ep93xx_reset();
   } else {
      ... current SWRST code ...
   }
...



Otherwise, other boards would add another if statement, any new ts72xx
board would need to modify the soc-common header, etc.


-Olof
