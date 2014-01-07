From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 07 Jan 2014 10:13:10 +0100
Subject: [PATCH 2/2] phy-core: Don't propagate -ENOSUPP from
 phy_pm_runtime_get_sync to caller
In-Reply-To: <52CBC152.3070403@ti.com>
References: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
 <1388963189-13556-2-git-send-email-hdegoede@redhat.com>
 <52CBC152.3070403@ti.com>
Message-ID: <52CBC526.4050001@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/07/2014 09:56 AM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Monday 06 January 2014 04:36 AM, Hans de Goede wrote:
>> The phy-core allows phy_init and phy_power_on to be called multiple times,
>> but before this patch -ENOSUPP from phy_pm_runtime_get_sync would be
>> propagated to the caller for the 2nd and later calls.
>
> Thanks for fixing this. Have one minor comment below.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/phy/phy-core.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index d7b992e..8ee6157 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -161,7 +161,8 @@ int phy_init(struct phy *phy)
>>   			dev_err(&phy->dev, "phy init failed --> %d\n", ret);
>>   			goto out;
>>   		}
>> -	}
>> +	} else
>> +		ret = 0; /* Override possible ret == -ENOTSUPP */
>
> 'should use braces in both branches'.

Ok, I'll do a v2 fixing this soonish, any comments on the first patch?

Regards,

Hans
