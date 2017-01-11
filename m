From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 11 Jan 2017 16:50:57 +0200
Subject: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
In-Reply-To: <20170111143917.hedhyfu6m5dopag7@pengutronix.de>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <20170111143917.hedhyfu6m5dopag7@pengutronix.de>
Message-ID: <3d6670d5-bc35-62cf-81b9-9d41a2f4e803@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

On 01/11/2017 04:39 PM, Uwe Kleine-K?nig wrote:
> On Wed, Jan 11, 2017 at 01:31:47PM +0100, Marc Gonzalez wrote:
>> On 11/01/2017 11:52, Guenter Roeck wrote:
>>
>>> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
>>>
>>>>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>>>>>  	err = clk_prepare_enable(dev->clk);
>>>>>  	if (err)
>>>>>  		return err;
>>>>> +	err = devm_add_action_or_reset(&pdev->dev,
>>>>> +				       (void(*)(void *))clk_disable_unprepare,
>>>>> +				       dev->clk);
>>>>> +	if (err)
>>>>> +		return err;
> 
> This looks wrong. There is no clk_unprepare_disable when
> devm_add_action_or_reset fails.

actually there is a call to clk_disable_unprepare() on error path, you may
take a look at devm_add_action_or_reset() implementation.

Your comment is valid for devm_add_action() function though, but it's not
the case here.

--
With best wishes,
Vladimir
