From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 11 Jan 2017 02:52:51 -0800
Subject: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
In-Reply-To: <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
Message-ID: <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 01:07 AM, Marc Gonzalez wrote:

>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>>  	err = clk_prepare_enable(dev->clk);
>>  	if (err)
>>  		return err;
>> +	err = devm_add_action_or_reset(&pdev->dev,
>> +				       (void(*)(void *))clk_disable_unprepare,
>> +				       dev->clk);
>> +	if (err)
>> +		return err;
>
> Hello Guenter,
>
> I would rather avoid the function pointer cast.
> How about defining an auxiliary function for the cleanup action?
>
> clk_disable_unprepare() is static inline, so gcc will have to
> define an auxiliary function either way. What do you think?
>

Not really. It would just make it more complicated to replace the
call with devm_clk_prepare_enable(), should it ever find its way
into the light of day.

Guenter
