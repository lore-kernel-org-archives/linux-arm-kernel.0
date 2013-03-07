From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 15:37:36 +0000
Subject: [PATCH V3 1/4] cpufreq: exynos: Adding cpufreq driver for
 exynos5440
In-Reply-To: <5138B200.7060906@samsung.com>
References: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
 <5138B200.7060906@samsung.com>
Message-ID: <20130307153736.GC4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 04:28:00PM +0100, Sylwester Nawrocki wrote:
> On 03/07/2013 05:13 AM, Amit Daniel Kachhap wrote:
> > +	dvfs_info->cpu_clk = devm_clk_get(dvfs_info->dev, "armclk");
> > +	if (IS_ERR_OR_NULL(dvfs_info->cpu_clk)) {
> 
> devm_clk_get() return value needs to be checked with IS_ERR(),
> not IS_ERR_OR_NULL().
> 
> > +		pr_err("Failed to get cpu clock\n");
> > +		ret = PTR_ERR(dvfs_info->cpu_clk);
> > +		goto err_free_table;

Amit, to illustrate why this is wrong, consider this:
1. Set cpu_clk to NULL.
2. Realise IS_ERR_OR_NULL(NULL) is true.
3. What is the value of PTR_ERR(NULL) ?
4. What effect does that have when you jump to err_free_table ?
5. What value is returned from this function in that case ?
6. What does that return value mean to the driver core ?
