From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Apr 2014 10:12:30 +0200
Subject: [PATCH 01/27] ARM: EXYNOS: Add Exynos3250 SoC ID
In-Reply-To: <53479545.4050707@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <53478C75.60302@samsung.com> <53479545.4050707@samsung.com>
Message-ID: <4735652.2Yh9suVdiT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 April 2014 16:09:57 Chanwoo Choi wrote:
> On 04/11/2014 03:32 PM, Chanwoo Choi wrote:
> >>>  
> >>> +#if defined(CONFIG_SOC_EXYNOS3250)
> >>> +# define soc_is_exynos3250()    is_samsung_exynos3250()
> >>> +#else
> >>> +# define soc_is_exynos3250()    0
> >>> +#endif
> >>
> >> In general, I think we have too much code littered with soc_is_<foo>() going
> >> on, so please try to avoid adding more for this SoC. Especially in cases where
> >> you just want to bail out of certain features where we might already have
> >> function pointers to control if a function is called or not, such as the
> >> firmware interfaces.
> >>
> > 
> > Do you prefer dt helper function such as following function instead of new soc_is_xx() ?
> > - of_machine_is_compatible("samsung,exynos3250")
> > 
> 
> I think of_machine_is_compatible() is not proper alternative method.
> of_machine_is_compatible can be only used if CONFIG_OF is enabled.
> 

CONFIG_OF is enabled by definition, that wouldn't be a problem. However,
of_machine_is_compatible() doesn't solve the problem that Olof mentioned,
you still make runtime-decisions based on the SoC ID, which you should not.

Instead, the code should be restructured so it doesn't have to know which
SoC is being used. If some machines work differently from others, that should
be local knowledge within the device driver, and it can use for instance
a DT property of the device node that describes the register set the driver
is using.

	Arnd
