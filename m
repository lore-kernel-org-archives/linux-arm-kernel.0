From: yong.shen@linaro.org (Yong Shen)
Date: Mon, 18 Oct 2010 13:43:43 +0800
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <20101013175424.GU28242@pengutronix.de>
References: <1286525307-1934-1-git-send-email-yong.shen@linaro.org>
	<1286525307-1934-2-git-send-email-yong.shen@linaro.org>
	<20101013175424.GU28242@pengutronix.de>
Message-ID: <AANLkTimprV8=cAD-CfiAgLTCFyj=wc7qMj0sPDCUpWDC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Thanks for your thorough review. I have two feedbacks to your commends.
Sorry for delayed response, cause I had a hard time due to my computer crash
and data loss.

> diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> > index 2d37785..83add9c 100644
> > --- a/arch/arm/mach-mx5/cpu.c
> > +++ b/arch/arm/mach-mx5/cpu.c
> > @@ -22,6 +22,8 @@ static int cpu_silicon_rev = -1;
> >
> >  #define SI_REV 0x48
> >
> > +struct cpu_wp *(*get_cpu_wp)(int *wp);
> > +
>
> This is not needed.
>
> This is needed, otherwise it does not pass compile.

>
> > +             return ret;
> > +     }
> > +
> > +     cpufreq_frequency_table_get_attr(imx_freq_table, policy->cpu);
> > +     return 0;
> > +}
> > +
> > +static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
> > +{
> > +     cpufreq_frequency_table_put_attr(policy->cpu);
> > +
> > +     /* Reset CPU to 665MHz */
> > +     set_cpu_freq(arm_normal_clk);
>
> arm_normal_clk is initialized to cpu_freq_khz_max * 1000 and never touched
> again. It would be clearer here to remove arm_normal_clk and write
> cpu_freq_khz_max * 1000 directly here. Then you can also remove the
> comment which is wrong for most i.MXs, even for the i.MX51.
>
>
Actually, this is arm_normal_clk is touched later in mxc_cpufreq_exit()
fuction.

Yong
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101018/9e3e23a6/attachment-0001.html>
