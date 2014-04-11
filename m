From: sbkim73@samsung.com (Sangbeom Kim)
Date: Fri, 11 Apr 2014 15:04:11 +0900
Subject: [PATCH 04/27] ARM: EXYNOS: Support secondary CPU boot of
 Exynos4212
In-Reply-To: <53477A19.6070509@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397122658-16013-5-git-send-email-cw00.choi@samsung.com>
 <20140411014424.GA14934@quad.lixom.net> <53477A19.6070509@samsung.com>
Message-ID: <006f01cf554b$dbc6a2d0$9353e870$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 04/11/2014 2:14 PM, Chanwoo Choi wrote:

> >>  {
> >> -	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> >> +	if (soc_is_exynos4212())
> >> +		exynos_smc(SMC_CMD_CPU1BOOT, 0, 0, 0);
> >> +	else
> >> +		exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> >
> > 	/* <explain why you need this special case on 4212> */
> 
> It's better to ask system lsi person. We don't know it well.
> I got the guide about secondary boot from system lsi.
> But, this patch was completely tested.

exynos_smc(SMC_CMD_CPU1BOOT, ...) is cpu hotplug SMC interface.
Exynos4212 is dual core processor.
Exynos4212 only have to boot cpu1 on smp boot.
So, Second parameter of exynos_smc is fixed by 0 which means cpu1.
It don't need to boot another cpu (ex. cpu2, cpu3 for quad core processor).
But In case of quad core processor (ex. Exynos4412), 
It need to boot another cpu and specify parameter of booting core.
As I know, Exynos3250 is dual core. 
So It can be included 1st condition too.

Sangbeom,
Thanks,
