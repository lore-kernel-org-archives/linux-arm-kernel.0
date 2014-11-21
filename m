From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 21 Nov 2014 15:47:36 +0530
Subject: [PATCH v4 1/2] i2c: s3c2410: Handle i2c sys_cfg register in i2c
 driver
In-Reply-To: <20141121072545.GG1480@katana>
References: <1414656270-8048-1-git-send-email-pankaj.dubey@samsung.com>
 <1414656270-8048-2-git-send-email-pankaj.dubey@samsung.com>
 <20141121072545.GG1480@katana>
Message-ID: <546F1140.4050709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 12:55 PM, Wolfram Sang wrote:
> On Thu, Oct 30, 2014 at 01:34:29PM +0530, Pankaj Dubey wrote:
>> Let's handle i2c interrupt re-configuration in i2c driver. This will
>> help us in removing some soc specific checks from machine files and
>> will help in removing static iomapping of SYS register in exynos.c
>>
>> Since only Exynos5250, and Exynos5420 has i2c nodes in DT, added syscon
>> based phandle to i2c device nodes of respective SoC DT files.
>>
>> Also handle saving and restoring of SYS_I2C_CFG register during
>> suspend and resume of i2c driver.
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Randy Dunlap <rdunlap@infradead.org>
>> CC: Wolfram Sang <wsa@the-dreams.de>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: devicetree at vger.kernel.org
>> CC: linux-doc at vger.kernel.org
>> CC: linux-i2c at vger.kernel.org
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    1 +
>>   arch/arm/boot/dts/exynos5250.dtsi                  |    4 +++
>>   arch/arm/boot/dts/exynos5420.dtsi                  |    4 +++
>
> I usually don't take DTS patches. They should go via arm-soc. Please say
> so if there are reasons I should take them.

I CC'ed to you because same patch contains changes in i2c driver.
I am not very sure via which tree this should go. May be I can ask 
samsung SoC maintainer Kukjin to look into this, as patch 2/2 has 
changes in mach-exynos which should go via Kukjin's tree.

>
>> @@ -1084,6 +1092,23 @@ s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
>>   	of_property_read_u32(np, "samsung,i2c-slave-addr", &pdata->slave_addr);
>>   	of_property_read_u32(np, "samsung,i2c-max-bus-freq",
>>   				(u32 *)&pdata->frequency);
>> +	/*
>> +	 * Exynos5's legacy i2c controller and new high speed i2c
>> +	 * controller have muxed interrupt sources. By default the
>> +	 * interrupts for 4-channel HS-I2C controller are enabled.
>> +	 * If node for first four channels of legacy i2c controller
>
> s/node/nodes/

OK.

>
>> +	 * are available then re-configure the interrupts via the
>> +	 * system register.
>> +	 */
>> +	id = of_alias_get_id(np, "i2c");
>> +	i2c->sysreg = syscon_regmap_lookup_by_phandle(np,
>> +			"samsung,sysreg-phandle");
>> +	if (IS_ERR(i2c->sysreg)) {
>> +		/* As this is not compulsory do not return error */
>> +		pr_info("i2c-%d skipping re-configuration of interrutps\n", id);
>
> I'd say drop this message. If you want to keep it, it should be dev_dbg.

OK.

>
>> +		return;
>> +	}
>> +	regmap_update_bits(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, BIT(id), 0);
>>   }
>
> Rest looks good, thanks!

Thanks for review.

Pankaj Dubey
>
