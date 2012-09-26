From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Wed, 26 Sep 2012 22:28:29 +0530
Subject: [PATCH 01/10] usb: otg: msm: Convert to clk_prepare/unprepare
In-Reply-To: <1348194419-11486-2-git-send-email-sboyd@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <CADTbHxoFeYWPJpYTN85kBeF=kv2v1yDioJW-upzn1RcwVT_sKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi..

On Fri, Sep 21, 2012 at 7:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Add calls to clk_prepare and unprepare so that MSM can migrate to
> the common clock framework.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/usb/otg/msm_otg.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/usb/otg/msm_otg.c b/drivers/usb/otg/msm_otg.c
> index 9f5fc90..2ae0639 100644
> --- a/drivers/usb/otg/msm_otg.c
> +++ b/drivers/usb/otg/msm_otg.c
> @@ -514,13 +514,13 @@ static int msm_otg_suspend(struct msm_otg *motg)
>                         motg->pdata->otg_control == OTG_PMIC_CONTROL)
>                 writel(readl(USB_PHY_CTRL) | PHY_RETEN, USB_PHY_CTRL);
>
> -       clk_disable(motg->pclk);
> -       clk_disable(motg->clk);
> +       clk_disable_unprepare(motg->pclk);
> +       clk_disable_unprepare(motg->clk);
>         if (motg->core_clk)
> -               clk_disable(motg->core_clk);
> +               clk_disable_unprepare(motg->core_clk);
>
I was under assumption that system suspend/resume might be called from
the interrupt context. If that is case then its not appropriate to
call clk_prepare/unprepare here right? or my understanding is not correct????

--
Pankaj Jangra
