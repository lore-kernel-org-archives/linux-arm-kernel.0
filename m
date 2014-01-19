From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 19:40:21 +0100
Subject: [RFC v3 04/13] ahci-platform: Undo pdata->resume on resume failure
In-Reply-To: <20140119112737.GC11123@htj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-5-git-send-email-hdegoede@redhat.com>
 <20140119112737.GC11123@htj.dyndns.org>
Message-ID: <52DC1C15.1030107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 12:27 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Jan 19, 2014 at 12:48:46AM +0100, Hans de Goede wrote:
>> When the ahci_resume fails the error handling code tries to undo all changes
>> made, but it was not undoing the results of pdata->resume.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/ata/ahci_platform.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index dc1ef73..41720cb 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -307,7 +307,7 @@ static int ahci_resume(struct device *dev)
>>   	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
>>   		rc = ahci_reset_controller(host);
>>   		if (rc)
>> -			goto disable_unprepare_clk;
>> +			goto pdata_suspend;
>>
>>   		ahci_init_controller(host);
>>   	}
>> @@ -316,6 +316,9 @@ static int ahci_resume(struct device *dev)
>>
>>   	return 0;
>>
>> +pdata_suspend:
>> +	if (pdata && pdata->suspend)
>> +		pdata->suspend(dev);
>>   disable_unprepare_clk:
>>   	if (!IS_ERR(hpriv->clk))
>>   		clk_disable_unprepare(hpriv->clk);
>
> Hmmmm... resume isn't an operation you can revert without side-effect
> when the whole system is waking up from sleep.  e.g. think about what
> should happen the driver is removed and loaded again - it should be
> able to reinitialized the device, which is unlikely to work if the
> device is suspended at the platform level.  If resume fails, the right
> state to be in is "failed with as much as resumed" instead of
> "suspended".

That sounds like your advocating for just returning from resume on the
first error without undoing any of the previous steps, have I gotten that
right?

That sounds as sensible as any other approach on resume errors
(there are IMHO no good answers), if that is what you mean, shall I do a
patch in the next versions of my patch-set doing that ?

Regards,

Hans
