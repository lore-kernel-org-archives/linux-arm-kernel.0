From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 12 Jan 2017 21:17:00 -0800
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
Message-ID: <56a43861-e875-2239-1046-91a26c009160@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 06:39 AM, Uwe Kleine-K?nig wrote:
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
>
>>>>
>>>> Hello Guenter,
>>>>
>>>> I would rather avoid the function pointer cast.
>>>> How about defining an auxiliary function for the cleanup action?
>>>>
>>>> clk_disable_unprepare() is static inline, so gcc will have to
>>>> define an auxiliary function either way. What do you think?
>>>
>>> Not really. It would just make it more complicated to replace the
>>> call with devm_clk_prepare_enable(), should it ever find its way
>>> into the light of day.
>>
>> More complicated, because the cleanup function will have to be deleted later?
>> The compiler will warn if someone forgets to do that.
>>
>> In my opinion, it's not a good idea to rely on the fact that casting
>> void(*)(struct clk *clk) to void(*)(void *) is likely to work as expected
>> on most platforms. (It has undefined behavior, strictly speaking.)
>
> I would expect it to work on all (Linux) platforms. Anyhow, I wonder if
> there couldn't be found a better solution.
>
> If in the end it looks like the following that would be good I think:
>
> 	clk = devm_clk_get(...);
> 	if (IS_ERR(clk))
> 		...
>
> 	ret = devm_clk_prepare_enable(clk)
> 	if (ret)
> 		return ret;
>

It turns out that at least one static analyzer complains about different
parameter pointer types in situations like this, and at least one embedded
compiler manages to create function names with embedded parameter type
(eg it appends an 'i' to the function name for each integer parameter).

With that, I consider the typecast to be too risky after all. It may work
for all of today's Linux architectures and compilers, but who knows if I
get flooded with static analyzer warnings, and who knows if gcc version
18.0 or binutils 35.0 makes it truly incompatible (following the logic of
"we can, therefore we do"). Since I also dislike the stub function solution,
at least in this situation, I'll drop all patches touching clk_prepare_enable(),
and wait for devm_clk_prepare_enable() to be available.

Guenter
