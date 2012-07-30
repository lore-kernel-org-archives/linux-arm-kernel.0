From: josh.coombs@gmail.com (Josh Coombs)
Date: Mon, 30 Jul 2012 12:46:44 -0400
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If I'm reading this correctly, if kirkwood_ge00_init is called without
any data, all that happens is the clock is enabled.  If the right data
is passed in, the ethernet interface is initialized, and then the
clock is enabled.

Patch 6 in your series sets all the existing DT board files to call
kirkwood_ge00_init with no data.

Would it make more sense for readability to separate the clock prep
and other interface initialization so DT board files don't appear to
be calling for a full turn up despite now handling that in the DTS
tree?  IE instead of converting all the board-XXX.c to call
kirkwood_ge00_init(NULL) have them call a new function,
kirkwood_ge00_clk_prep(NULL) instead, assuming the clock can't be
handled directly via DTS.

Josh C

On Mon, Jul 30, 2012 at 11:15 AM, Ian Molton <ian.molton@codethink.co.uk> wrote:
> This patch modifies the ethernet setup helper functions so that they can be
> used /purely/ to set up the clocks.
>
> This is part of ongoing work to enable device tree support in the mv643xx.c
> ethernet driver, where as yet the kirkwood platform does not have proper clk
> support.
>
> This should allow a gradual migration to device tree and later to proper clk
> support, wherupon the helper functions can be removed entirely.
>
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  arch/arm/mach-kirkwood/common.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index c4b64ad..c1776ea 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -299,7 +299,8 @@ void __init kirkwood_ehci_init(void)
>   ****************************************************************************/
>  void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
>  {
> -       orion_ge00_init(eth_data,
> +       if (eth_data)
> +               orion_ge00_init(eth_data,
>                         GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
>                         IRQ_KIRKWOOD_GE00_ERR);
>         /* The interface forgets the MAC address assigned by u-boot if
> @@ -313,7 +314,8 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
>   ****************************************************************************/
>  void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
>  {
> -       orion_ge01_init(eth_data,
> +       if (eth_data)
> +               orion_ge01_init(eth_data,
>                         GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
>                         IRQ_KIRKWOOD_GE01_ERR);
>         clk_prepare_enable(ge1);
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
