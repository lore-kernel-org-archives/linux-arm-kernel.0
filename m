From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 16:42:53 -0700
Subject: [PATCH] clk: tegra: provide dummy cpu car ops
In-Reply-To: <643E69AA4436674C8F39DCC2C05F7638629CA50C97@HQMAIL03.nvidia.com>
References: <1360853581-9756-1-git-send-email-pdeschrijver@nvidia.com>
 <643E69AA4436674C8F39DCC2C05F7638629CA50C97@HQMAIL03.nvidia.com>
Message-ID: <5137D47D.6030105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 04:20 PM, Andrew Chew wrote:
>> Subject: [PATCH] clk: tegra: provide dummy cpu car ops
>>
>> tegra_boot_secondary() relies on some of the car ops. This means having an
>> uninitialized tegra_cpu_car_ops will lead to an early boot panic.
>> Providing a dummy struct avoids this and makes adding Tegra114 clock
>> support in a bisectable way a lot easier.
>>
>> --
>>
>> Stephen,
>>
>> Should this be a separate patch or should I make this part of new release of
>> the Tegra114 clock series?

I'm not sure if I answered this. Peter, I intend to apply this patch to
a branch right before the CCF, so there's no explicit need to include it
in the series, although if you do, that's fine.

>> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c index

>>  /* Global data of Tegra CPU CAR ops */
>> -struct tegra_cpu_car_ops *tegra_cpu_car_ops;
> 
> Sorry for bringing this up so late...
> Shouldn't the above be "struct tegra_cpu_car_ops tegra_cpu_car_ops;"?
> 
>> +static struct tegra_cpu_car_ops *dummy_car_ops; struct
>> +tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;

No, the value is used as a pointer in include/linux/clk/tegra.h, e.g.:

tegra_cpu_car_ops->wait_for_reset(cpu);
