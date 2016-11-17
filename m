From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 17 Nov 2016 07:52:03 +0530
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <20161114134813.GK1041@n2100.armlinux.org.uk>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161114134843epcas2p2d52a44bae703d52a9e9646e73ed5b41d@epcas2p2.samsung.com>
 <20161114134813.GK1041@n2100.armlinux.org.uk>
Message-ID: <8b3f2f77-d883-519e-db65-a0bfca254c22@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Monday 14 November 2016 07:18 PM, Russell King - ARM Linux wrote:
> This should be sent _to_ me because it's touching generic ARM code.
> Thanks.
> 

Sorry for this.

I had included your email in CC for this patch, but looks like my email
client had some issue and this patch could not reach to your mailbox. I
will take care in future.

> On Mon, Nov 14, 2016 at 10:31:56AM +0530, Pankaj Dubey wrote:
>> Many platforms are duplicating code for enabling SCU, lets add
>> common code to enable SCU by parsing SCU device node so the duplication
>> in each platform can be avoided.
>>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: Jisheng Zhang <jszhang@marvell.com>
>> CC: Russell King <linux@armlinux.org.uk>
>> CC: Dinh Nguyen <dinguyen@opensource.altera.com>
>> CC: Patrice Chotard <patrice.chotard@st.com>
>> CC: Linus Walleij <linus.walleij@linaro.org>
>> CC: Liviu Dudau <liviu.dudau@arm.com>
>> CC: Ray Jui <rjui@broadcom.com>
>> CC: Stephen Warren <swarren@wwwdotorg.org>
>> CC: Heiko Stuebner <heiko@sntech.de>
>> CC: Shawn Guo <shawnguo@kernel.org>
>> CC: Michal Simek <michal.simek@xilinx.com>
>> CC: Wei Xu <xuwei5@hisilicon.com>
>> CC: Andrew Lunn <andrew@lunn.ch>
>> CC: Jun Nie <jun.nie@linaro.org> 
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/include/asm/smp_scu.h |  4 +++
>>  arch/arm/kernel/smp_scu.c      | 56 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
>> index bfe163c..fdeec07 100644
>> --- a/arch/arm/include/asm/smp_scu.h
>> +++ b/arch/arm/include/asm/smp_scu.h
>> @@ -39,8 +39,12 @@ static inline int scu_power_mode(void __iomem *scu_base, unsigned int mode)
>>  
>>  #if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
>>  void scu_enable(void __iomem *scu_base);
>> +void __iomem *of_scu_get_base(void);
>> +int of_scu_enable(void);
>>  #else
>>  static inline void scu_enable(void __iomem *scu_base) {}
>> +static inline void __iomem *of_scu_get_base(void) {return NULL; }
>> +static inline int of_scu_enable(void) {return 0; }
>>  #endif
>>  
>>  #endif
>> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
>> index 72f9241..d0ac3ed 100644
>> --- a/arch/arm/kernel/smp_scu.c
>> +++ b/arch/arm/kernel/smp_scu.c
>> @@ -10,6 +10,7 @@
>>   */
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/of_address.h>
>>  
>>  #include <asm/smp_plat.h>
>>  #include <asm/smp_scu.h>
>> @@ -70,6 +71,61 @@ void scu_enable(void __iomem *scu_base)
>>  	 */
>>  	flush_cache_all();
>>  }
>> +
>> +static const struct of_device_id scu_match[] = {
>> +	{ .compatible = "arm,cortex-a9-scu", },
>> +	{ .compatible = "arm,cortex-a5-scu", },
>> +	{ }
>> +};
>> +
>> +/*
>> + * Helper API to get SCU base address
>> + * In case platform DT do not have SCU node, or iomap fails
>> + * this call will fallback and will try to map via call to
>> + * scu_a9_get_base.
>> + * This will return ownership of scu_base to the caller
>> + */
>> +void __iomem *of_scu_get_base(void)
>> +{
>> +	unsigned long base = 0;
>> +	struct device_node *np;
>> +	void __iomem *scu_base;
>> +
>> +	np = of_find_matching_node(NULL, scu_match);
>> +	scu_base = of_iomap(np, 0);
>> +	of_node_put(np);
>> +	if (!scu_base) {
>> +		pr_err("%s failed to map scu_base via DT\n", __func__);
>> +		if (scu_a9_has_base()) {
>> +			base = scu_a9_get_base();
>> +			scu_base = ioremap(base, SZ_4K);
>> +		}
>> +		if (!scu_base) {
>> +			pr_err("%s failed to map scu_base\n", __func__);
>> +			return IOMEM_ERR_PTR(-ENOMEM);
> 
> I can't see the point of using error-pointers here - it's not like we
> really know why we're failing, so just return NULL.
> 
>> +		}
>> +	}
>> +	return scu_base;
>> +}
>> +
>> +/*
>> + * Enable SCU via mapping scu_base DT
>> + * If scu_base mapped successfully scu will be enabled and in case of
>> + * failure if will return non-zero error code
>> + */
>> +int of_scu_enable(void)
>> +{
>> +	void __iomem *scu_base;
>> +
>> +	scu_base = of_scu_get_base();
>> +	if (!IS_ERR(scu_base)) {
>> +		scu_enable(scu_base);
>> +		iounmap(scu_base);
>> +		return 0;
>> +	}
>> +	return PTR_ERR(scu_base);
> 
> and just return your -ENOMEM here.
> 
