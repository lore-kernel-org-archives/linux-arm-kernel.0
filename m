From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Thu, 21 Apr 2016 10:39:50 +0300
Subject: [PATCH 2/4] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
In-Reply-To: <20160421104022.2d6549a9@xhacker>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
 <1460638414-5987-3-git-send-email-jszhang@marvell.com>
 <57177C32.4090000@linux.intel.com>
 <1461161760.6620.306.camel@linux.intel.com> <20160421104022.2d6549a9@xhacker>
Message-ID: <571883C6.3010404@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2016 05:40 AM, Jisheng Zhang wrote:
> Dear Jarkko, Andy,
>
> On Wed, 20 Apr 2016 17:16:00 +0300 Andy Shevchenko wrote:
>
>> On Wed, 2016-04-20 at 15:55 +0300, Jarkko Nikula wrote:
>>> I see Andy's 1cb715ca4694 ("i2c-designware: move to managed functions
>>> (devm_*)") removed it but at quick look drivers/clk/clk-devres.c:
>>> devm_clk_release() calls only clk_put and I don't see disable is done
>>> down the path.
>>
>> The following is a mistake of the mentioned patch.
>> -       clk_disable_unprepare(dev->clk);
>>
>> I did at the same mistake in dw_dmac driver which had been fixed later
>> in the commit 8be4f523b480 ("dmaengine: dw: fix regression in dw_probe()
>> function").
>>
>
> As Andy pointed out, managed devm_clk_get can only automatically put clk
> but doesn't unprepare and disable the clk
>
Ok, then it makes sense to move this fix first in the series and queue 
for stable v4.5+. Then another from you, Andy or me for kernels before 
b33af11de236 ("i2c: designware: Do not require clock when SSCN and FFCN 
are provided") that introduced the i2c_dw_plat_prepare_clk().

-- 
Jarkko
