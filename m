From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Tue, 27 Dec 2011 23:16:12 +0100
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <20111226190616.GL8722@opensource.wolfsonmicro.com>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
 <20111226190616.GL8722@opensource.wolfsonmicro.com>
Message-ID: <4EFA43AC.8030900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2011 08:06 PM, Mark Brown wrote:
> On Mon, Dec 12, 2011 at 09:16:29PM +0530, Thomas Abraham wrote:
> 
>> +	/* Wait max 1ms */
>> +	timeout = 10;
>> +	while ((__raw_readl(base + 0x4) & S5P_INT_LOCAL_PWR_EN)
>> +					!= S5P_INT_LOCAL_PWR_EN) {
>> +		if (!timeout) {
>> +			pr_err("Power domain %s enable failed\n", domain->name);
>> +			return -ETIMEDOUT;
>> +		}
>> +		timeout--;
>> +		udelay(100);
>> +	}
> 
> Might be worth putting a cpu_relax() in there just to be a bit nicer?

There is a quite significant delay within the loop, thus it might make more
sense to replace udelay() with usleep_range() instead.
