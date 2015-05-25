From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 25 May 2015 11:44:37 +1000
Subject: [linux-sunxi] [PATCH 1/2] mmc: sunxi: fix timeout in
 sunxi_mmc_oclk_onoff
In-Reply-To: <4011290915a42fce8b9c19d59f3ca9c3289a6817.1432491958.git.hramrach@gmail.com>
References: <cover.1432491958.git.hramrach@gmail.com>
 <4011290915a42fce8b9c19d59f3ca9c3289a6817.1432491958.git.hramrach@gmail.com>
Message-ID: <CAGRGNgXukmS8hAYbmgeMZUbWqjAF49J_v-S8EtudaEkfYgP9Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, May 25, 2015 at 4:07 AM, Michal Suchanek <hramrach@gmail.com> wrote:
> The 250ms timeout is too short.
>
> On my system enabling the oclk takes under 50ms and disabling slightly
> over 100ms when idle. Under load disabling the clock can take over
> 350ms.
>
> This does not make mmc clock gating look like good option to have on
> sunxi but the system should not crash with mmc clock gating enabled
> nonetheless.
>
> This patch sets the timeout to 750ms and adds debug prints which show
> how long enabling/disabling the clock took so more data can be collected
> from other systems.
>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 4d3e1ff..7cdeecd 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
>
>  static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  {
> -       unsigned long expire = jiffies + msecs_to_jiffies(250);
> +       unsigned long start, end;
>         u32 rval;
>
>         rval = mmc_readl(host, REG_CLKCR);
> @@ -604,6 +604,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>         if (oclk_en)
>                 rval |= SDXC_CARD_CLOCK_ON;
>
> +       start = jiffies;
> +       end = start + msecs_to_jiffies(750);

You might want to make the timeout value a #define so it's not buried
in the code like this.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
