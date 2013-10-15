From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Oct 2013 13:02:48 +0200
Subject: [PATCH] sh-pfc: r8a7791 PFC support
In-Reply-To: <CANqRtoTS-=GUZ2HqyDRenTa7PnSfY8hN1j4U58L0JxzQamg+cA@mail.gmail.com>
References: <20131008040824.3480.69707.sendpatchset@w520>
 <1876860.l29tzQeBi6@avalon>
 <CANqRtoTS-=GUZ2HqyDRenTa7PnSfY8hN1j4U58L0JxzQamg+cA@mail.gmail.com>
Message-ID: <3851663.6IUEzO7ztC@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Tuesday 15 October 2013 12:42:17 Magnus Damm wrote:
> On Thu, Oct 10, 2013 at 7:41 AM, Laurent Pinchart wrote:
> > On Tuesday 08 October 2013 13:08:24 Magnus Damm wrote:
> >> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >> 
> >> Add PFC support for the r8a7791 SoC including pin groups for
> >> on-chip devices such as MSIOF, SCIF, USB, MMC, VIN, SDHI, DU.
> >> 
> >> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >> Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
> >> Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> >> Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
> >> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> >> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> >> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> >> [damm at opensource.se: Forward ported to upstream, reused existing sh-pfc
> >> macros] Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > I'll trust you for having reviewed all the data tables :-D
> > 
> >> ---
> >> 
> >>  Written against renesas-devel-20131004
> >>  
> >>  Based on the following broken out patches from BSP v0.5.0:
> >>  0739, 0766, 0771, 0774, 0777, 0782, 0798, 1056, 1057, 1235, 1261, 1271
> >>  
> >>  drivers/pinctrl/sh-pfc/Kconfig       |    5
> >>  drivers/pinctrl/sh-pfc/Makefile      |    1
> >>  drivers/pinctrl/sh-pfc/core.c        |    3
> >>  drivers/pinctrl/sh-pfc/core.h        |    1
> >>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 4327 ++++++++++++++++++++++++++++
> >>  5 files changed, 4337 insertions(+)
> > 
> > [snip]
> > 
> >> --- 0001/drivers/pinctrl/sh-pfc/core.c
> >> +++ work/drivers/pinctrl/sh-pfc/core.c        2013-10-08
> >> 12:43:03.000000000 +0900 @@ -558,6 +558,9 @@ static const struct
> >> platform_device_id s
> >>  #ifdef CONFIG_PINCTRL_PFC_R8A7790
> >>       { "pfc-r8a7790", (kernel_ulong_t)&r8a7790_pinmux_info },
> >>  #endif
> >> +#ifdef CONFIG_PINCTRL_PFC_R8A7791
> >> +     { "pfc-r8a7791", (kernel_ulong_t)&r8a7791_pinmux_info },
> >> +#endif
> >>  #ifdef CONFIG_PINCTRL_PFC_SH7203
> >>       { "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
> >>  #endif
> > 
> > You should also update the sh_pfc_of_table array.
> 
> Ok, thanks, I will!
> 
> >> --- /dev/null
> >> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a7791.c 2013-10-08
> > 
> > 12:46:46.000000000
> > 
> >> +0900 @@ -0,0 +1,4327 @@
> >> +/*
> >> + * arch/arm/cpu/armv7/rmobile/pfc-r8a7791.c
> > 
> > The file seems to have moved :-) You can probably just remove the file
> > name, it doesn't add much and only asks for getting outdated.
> 
> Yes, I agree. I will fix.
> 
> >> + *     This file is r8a7791 processor support - PFC hardware block.
> >> + *
> >> + * Copyright (C) 2013 Renesas Electronics Corporation
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2
> >> + * as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> Foundation,
> >> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> > 
> > You can remove the last two paragraphs.
> 
> Ok!
> 
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/platform_data/gpio-rcar.h>
> >> +
> >> +#include "core.h"
> >> +#include "sh_pfc.h"
> > 
> > [snip]
> > 
> >> +static struct sh_pfc_pin pinmux_pins[] = {
> >> +     PINMUX_GPIO_GP_ALL(),
> >> +};
> > 
> > [snip]
> > 
> >> +/* - ETH
> >> -------------------------------------------------------------------- */
> >> +static const unsigned int eth_link_pins[] = {
> >> +     /* LINK */
> >> +     RCAR_GP_PIN(5, 18),
> >> +};
> >> +static const unsigned int eth_link_mux[] = {
> >> +     ETH_LINK_MARK,
> >> +};
> >> +static const unsigned int eth_magic_pins[] = {
> >> +     /* MAGIC */
> > 
> > I've seen an errata for a different SoC that renamed the ethernet "magic"
> > pin to "wol" (wake-on-lan). Could you check whether that has been done
> > for R8A7791 as well ?
> 
> Thanks, I will look into this and sync with the r8a7790 PFC table if needed!
>
> >> +/* - VIN0
> > 
> > The red, green and blue signals need to be used together, shouldn't they
> > be grouped ?
> > 
> > Same for hsync and vsync. You could also s/_signal// here and below.
> > 
> >> +/* - VIN1
> > 
> > No synchronization signals for vin1 ?
> 
> Thanks for checking the VIN bits. I believe your comments are all
> valid, and I propose that I simply remove the VIN portions and request
> people to address your commends and submit support for this
> independently. I hope that is OK with you.

That's fine with me.

> >> +static const struct sh_pfc_pin_group pinmux_groups[] = {
> >> +     SH_PFC_PIN_GROUP(du_rgb666),
> >> +     SH_PFC_PIN_GROUP(du_rgb888),
> >> +     SH_PFC_PIN_GROUP(du_clk_out_0),
> >> +     SH_PFC_PIN_GROUP(du_clk_out_1),
> >> +     SH_PFC_PIN_GROUP(du_sync_1),
> >> +     SH_PFC_PIN_GROUP(du_cde_disp),
> >> +     SH_PFC_PIN_GROUP(du1_clk_in),
> >> +     SH_PFC_PIN_GROUP(du0_clk_in),
> > 
> > du0 should come before du1.
> 
> Sure.
> 
> >> +static const char * const du1_groups[] = {
> >> +     "du1_clk_in",
> >> +};
> >> +
> >> +static const char * const du0_groups[] = {
> >> +     "du0_clk_in",
> >> +};
> > 
> > And here too.
> 
> Ok, I will fix that.
> 
> If you don't mind then I will address the minor things myself and drop
> the VIN portion and then resend it as V2.

Sure, no problem.

-- 
Regards,

Laurent Pinchart
