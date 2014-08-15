From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 15 Aug 2014 22:52:01 +0100
Subject: [PATCH v7 8/8] drivers: cpuidle: initialize Exynos driver
 through DT
In-Reply-To: <20140815214513.GB46224@ilina-mac.local>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-9-git-send-email-lorenzo.pieralisi@arm.com>
 <20140815211233.GA46224@ilina-mac.local>
 <20140815214034.GA10552@e102568-lin.cambridge.arm.com>
 <20140815214513.GB46224@ilina-mac.local>
Message-ID: <20140815215201.GA15590@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 10:45:13PM +0100, Lina Iyer wrote:
> On Fri, Aug 15, 2014 at 10:40:34PM +0100, Lorenzo Pieralisi wrote:
> >On Fri, Aug 15, 2014 at 10:12:33PM +0100, Lina Iyer wrote:
> >
> >[...]
> >
> >> > static int exynos_cpuidle_probe(struct platform_device *pdev)
> >> > {
> >> >-	int ret;
> >> >+	int ret, i;
> >> >+	struct cpuidle_driver *drv = &exynos_idle_driver;
> >> >
> >> > 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
> >> >
> >> >-	ret = cpuidle_register(&exynos_idle_driver, NULL);
> >> >+	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> >> >+	if (!drv->cpumask)
> >> >+		return -ENOMEM;
> >> drv->cpumask would not have any cpu set. I dont see it being modified
> >> elsewhere.
> >
> >Gah, I should have missed that while refactoring, I can just compile test this
> >patch so it went unnoticed. Fixed (by copying the possible mask to
> >drv->cpumask).
> >
> >Thank you !
> >Lorenzo
> Noticed that in the big.little exynos driver  as well.

If you mean drivers/cpuidle-big_little.c, there masks are initialized
before parsing DT, so code is correct and I could test that.

Thanks,
Lorenzo
