From: zhengyu.shen@nxp.com (Zhengyu Shen)
Date: Fri, 19 Aug 2016 15:28:17 +0000
Subject: [PATCH 1/3] Error: Fix mmdc compilation errors due to cpu notifier
In-Reply-To: <1471570860-2087-2-git-send-email-Nitin.Chaudhary@zii.aero>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <1471570860-2087-1-git-send-email-Nitin.Chaudhary@zii.aero>
 <1471570860-2087-2-git-send-email-Nitin.Chaudhary@zii.aero>
Message-ID: <DB5PR04MB14300BA6980837ED811FE6C19F160@DB5PR04MB1430.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: [PATCH 1/3] Error: Fix mmdc compilation errors due to cpu notifier
> 
> ---
>  arch/arm/mach-imx/mmdc.c   | 89 ++++++++++++++++++++++---------------
> ---------
>  include/linux/cpuhotplug.h |  1 +
>  2 files changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 372b59c..95c222d 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -77,13 +77,14 @@ struct mmdc_pmu
>         struct pmu pmu;
>         void __iomem *mmdc_base;
>         cpumask_t cpu;
> -       struct notifier_block cpu_nb;
>         struct hrtimer hrtimer;
>         unsigned int irq;
>         struct device *dev;
>         struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];  };
> 
> +static struct mmdc_pmu *pmu_mmdc;
> +
I'm not sure it's a good idea to make the pmu static. I looked at several 
other drivers for perf and most of them didn't have the pmu wrapper
as a static variable. Almost every other file which involves pmus uses
the container_of macro to get the pmu wrapper from the event. 
I also looked over some documentation and some internal code and there 
are two MMDCs on i.MX6 Quad although one appears to be unused.
I think just to be on the safe side it should not be made static. 
