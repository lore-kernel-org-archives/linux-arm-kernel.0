From: dianders@chromium.org (Doug Anderson)
Date: Fri, 9 Aug 2013 09:48:29 -0700
Subject: [PATCH v5 2/4] mmc: dw_mmc: Add exynos resume_noirq callback to
 clear WAKEUP_INT
In-Reply-To: <CAOMZO5DZ=aJsOvTyrKL=57_jGMGQX8k3mDamgXqnF-9Ou2fpAg@mail.gmail.com>
References: <1375825071-20922-1-git-send-email-dianders@chromium.org>
 <1376066000-5495-1-git-send-email-dianders@chromium.org>
 <1376066000-5495-3-git-send-email-dianders@chromium.org>
 <CAOMZO5DZ=aJsOvTyrKL=57_jGMGQX8k3mDamgXqnF-9Ou2fpAg@mail.gmail.com>
Message-ID: <CAD=FV=WxCpqX+23i_Q4_swKWqieNdcZ_sa0bxrcpUnr4vA+pGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

Thanks for your review.

On Fri, Aug 9, 2013 at 9:41 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Aug 9, 2013 at 1:33 PM, Doug Anderson <dianders@chromium.org> wrote:
>
>> +#else
>> +#define dw_mci_exynos_suspend          NULL
>> +#define dw_mci_exynos_resume           NULL
>> +#define dw_mci_exynos_resume_noirq     NULL
>> +#endif /* CONFIG_PM_SLEEP */
>
> You could avoid this else block if you use 'static SIMPLE_DEV_PM_OPS' below.
>
>> +
>>  static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>>  {
>>         /*
>> @@ -187,13 +234,20 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>>         return dw_mci_pltfm_register(pdev, drv_data);
>>  }
>>
>> +const struct dev_pm_ops dw_mci_exynos_pmops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
>> +       .resume_noirq = dw_mci_exynos_resume_noirq,
>> +       .thaw_noirq = dw_mci_exynos_resume_noirq,
>> +       .restore_noirq = dw_mci_exynos_resume_noirq,
>> +};
>
> static SIMPLE_DEV_PM_OPS(dw_mci_exynos_pmops, dw_mci_exynos_suspend,
>  dw_mci_exynos_resume ) ;

The big problem is that SIMPLE_DEV_PM_OPS() doesn't take a "_noirq"
parameters.  Do you know of one that does?

-Doug
