From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 14 Jun 2012 09:44:38 +0300
Subject: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
In-Reply-To: <4FD96CBF.5040106@windriver.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
 <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
 <4FD96CBF.5040106@windriver.com>
Message-ID: <4FD98856.8070601@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/12 07:46, Zumeng Chen wrote:
> ? 2012?06?13? 20:18, Hiremath, Vaibhav ??:
>> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>>
>>> If we don't set proper debouce time for ads7846, then there are
>>> flooded interrupt counters of ads7846 responding to one time
>>> touch on screen, so the driver couldn't work well.
>>>
>>> And since most OMAP3 series boards pass NULL pointer of board_pdata
>>> to omap_ads7846_init, so it's more proper to set it in driver level
>>> after having gpio_request done.
>>>
>>> This patch has been validated on 3530evm.
>>>
>>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>> ---
>>>   drivers/input/touchscreen/ads7846.c |    4 ++++
>>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>>> index f02028e..459ff29 100644
>>> --- a/drivers/input/touchscreen/ads7846.c
>>> +++ b/drivers/input/touchscreen/ads7846.c
>>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>>           }
>>>
>>>           ts->gpio_pendown = pdata->gpio_pendown;
>>> +#ifdef CONFIG_ARCH_OMAP3
>>> +        /* 310 means about 10 microsecond for omap3 */
>>> +        gpio_set_debounce(pdata->gpio_pendown, 310);
>>> +#endif
>>>
>> Zumeng,
>>
>> With my sign-off you are changing the original code, that too
>> without my sign-off and ack.
>> I wouldn't mind you to submit patches from my tree, but the expectation is
>> if you are changing the original code, it should be under your sign-off.
> Thanks, good to learn. I'll remove in next time.
>> Coming to the patch, #ifdef in driver is not recommended, and this 10msec
>> delay is specific to OMAP GPIO and driver should not be aware of this,
>> that's where you will find the original patch handling it in board file.
> According to the git blame of the board-omap3evm.c I think
> 96974a24 did a good thing to all the related codes for omap3
> boards. So I think we can call board and driver as BSP level :-)
> 
> If #ifdef in driver can save many codes, I guess it's deserved.

No, platform/board specific ifdefs in the generic driver code are never
deserved.
How about the attached patch, does it fix the problem for you?


-- 
Regards,
Igor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ads7846.patch
Type: text/x-patch
Size: 1432 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/f22a4b45/attachment.bin>
