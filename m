From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 May 2016 09:06:40 +0200
Subject: [PATCH] reset: Put back *_optional variants
In-Reply-To: <57476E48.2060204@synopsys.com>
References: <ca359e013c30f27c825a9580164b01da5ca6476d.1464224883.git.johnyoun@synopsys.com>
 <12e450f0-70ea-29f8-0bf7-8a0697263f2d@redhat.com>
 <57476E48.2060204@synopsys.com>
Message-ID: <dcf6372f-4910-bd03-f1b5-c7e0086fdead@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26-05-16 23:44, John Youn wrote:
> On 5/26/2016 1:25 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 26-05-16 03:15, John Youn wrote:
>>> Prior to commit 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo]
>>> functions wrappers"), the optional variants returned -ENOTSUPP when
>>> CONFIG_RESET_CONTROLLER was not set. This patch reverts to this
>>> behavior. Otherwise those calls will return -EINVAL causing users to
>>> think that an error occurred when CONFIG_RESET_CONTROLLER is not set.
>>>
>>> Fixes: 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo] functions wrappers")
>>> Signed-off-by: John Youn <johnyoun@synopsys.com>
>>> ---
>>>
>>> Hi Philipp, Hans,
>>>
>>> The commit referenced above breaks an upcoming patch for the dwc2
>>> driver that adds an optional reset control.
>>>
>>> https://marc.info/?l=linux-usb&m=146161328211584&w=2
>>>
>>> I've attempted to add the optional variants back the way they were
>>> working before. Let me know if I need to do anything else to fix it or
>>> if it should be done another way.
>>>
>>> Regards,
>>> John
>>
>> Hmm, I don't like all the extra code your patch adds just to fix
>> a return value...
>>
>> Looking at the code before my "reset: Make [of_]reset_control_get[_foo]
>> functions wrappers" patch, all the dev*_get* functions were
>> returning ENOTSUPP except for [devm_]reset_control_get, so following
>> your logic we should also change the of_reset_control_get_by_index
>> variant to return -ENOTSUP.
>>
>> Or better, simply make them all return -ENOTSUP, that seems both
>> consistent and more KISS to me, this would mean an error code
>> change for [devm_]reset_control_get, but will fix all the other
>> getters from having a changed error-code, and I would callers
>> of [devm_]reset_control_get to not care which error code they
>> get, except for -EPROBE_DEFER.
>>
>> So IMHO the following change would be a better way to fix this:
>>
>> --- a/include/linux/reset.h
>> +++ b/include/linux/reset.h
>> @@ -65,14 +65,14 @@ static inline struct reset_control *__of_reset_control_get(
>>                                          struct device_node *node,
>>                                          const char *id, int index, int shared)
>>   {
>> -   return ERR_PTR(-EINVAL);
>> + return ERR_PTR(-ENOTSUPP);
>>   }
>>
>>   static inline struct reset_control *__devm_reset_control_get(
>>                                          struct device *dev,
>>                                          const char *id, int index, int shared)
>>   {
>> -   return ERR_PTR(-EINVAL);
>> + return ERR_PTR(-ENOTSUPP);
>>   }
>>
>>   #endif /* CONFIG_RESET_CONTROLLER */
>
>
> I'm good with this. However, per Philipp on a previous thread, the
> intended behavior is to return -EINVAL for the non-optional functions.
>
> http://marc.info/?l=linux-usb&m=146156945528848&w=2

As Philipp rightfully points out, calling the non-optional functions
without CONFIG_RESET_CONTROLLER is a no-no, so IMHO we should not have to
care too much about the error code in that case, as long as we return
an error.

Also note that even before my patch things were already inconsistent
with the of_...get... functions already always returning
-ENOTSUPP when CONFIG_RESET_CONTROLLER was not set, to me it seems
best and also KISS to just return -ENOTSUPP from all get functions
when CONFIG_RESET_CONTROLLER is not set.

Anyways this is Philipp's call, this is all just my 2 cents.

Regards,

Hans
