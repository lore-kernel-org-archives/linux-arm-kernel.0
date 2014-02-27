From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 16:05:40 -0800
Subject: [PATCH v3 1/9] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
In-Reply-To: <20140226235959.GD18563@joshc.qualcomm.com>
References: <1393441562-685-1-git-send-email-sboyd@codeaurora.org>
 <1393441562-685-2-git-send-email-sboyd@codeaurora.org>
 <20140226235959.GD18563@joshc.qualcomm.com>
Message-ID: <530E8154.9060403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/14 15:59, Josh Cartwright wrote:
> On Wed, Feb 26, 2014 at 11:05:54AM -0800, Stephen Boyd wrote:
>> Use the regmap APIs for this driver instead of custom pm8xxx
>> APIs. This breaks this driver's dependency on the pm8xxx APIs and
>> allows us to easily port it to other bus protocols in the future.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/input/misc/pmic8xxx-pwrkey.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
>> index 0e1a05f95858..cf6125dc3b51 100644
>> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
>> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
>> @@ -120,6 +120,10 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!regmap)
>> +		return -ENODEV;
>> +
> This looks really weird.  A previous version of patch was included in
> v3.14-rc1 (1e63bd9cc4), which already included a very similar hunk...
>
> Maybe the fact that the hunk isn't identical is why a rebase didn't drop
> it (and instead, now if this gets merged, we'll have unnecessary
> duplication).
>

Ah yeah, sorry about that. This patch should just be ignored. I don't
think it affects anything else in the series?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
