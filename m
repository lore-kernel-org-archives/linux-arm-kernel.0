From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 8 May 2018 20:43:43 -0700
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
In-Reply-To: <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
 <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
 <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
Message-ID: <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2018 08:18 PM, Lei YU wrote:
> On Tue, May 8, 2018 at 9:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> No mixed C/C++ comments in hwmon drivers.
>>
>>>          aspeed_set_clock_source(priv->regmap, 0);
>>> +       priv->clk_freq = 24000000;
>>>
>>
>>
>> Are you saying that clk_get_rate() is wrong ? Anyway, if the DT is bad, it
>> should be fixed.
> Nope, clk_get_rate() is OK.
> The reason I make this change is because the PWM supports two types of clock
> source, the 24MHz or the clock from memory controller.
> If the DT uses 24MHz clock, this code is OK.
> But if the DT configs this pwm to use mclk (memory controller clk), this piece
> of code becomes wrong, because the code
> `aspeed_set_clock_source(priv->regmap, 0)` configs the device to use the 24MHz
> clock.
> So no matter what DT configs the clk, this driver *always* uses 24MHz clock.
> 
> That's why I want to make this change.
> 
>> I am not a friend of hacking drivers to fix up bad DTs, and much less so
>> without explanation.
>> Plus, how do we know that the next chip supported by the driver doesn't have
>> a 32MHz clock ?
> This driver currently supports ast2400 and ast2500, and they both use 24MHz
> clock.
> In case future device uses a different clock, we can update this code, right?
> 

I am not going to accept this change, period. This is not one, it is five steps
backward. If "aspeed_set_clock_source(priv->regmap, 0)" changes the clock speed,
or the clock source, read it later, and attach to the correct clock. If that
doesn't work, fix the problem in the clock subsystem. Hacking the driver is just
plain wrong.

Also, if the idea in DT is to provide a different clock to the watchdog on purpose,
maybe the call to "aspeed_set_clock_source(priv->regmap, 0)" is wrong.

Guenter

>> Really, please fix the DT.
> Sure, I will send patch to config the clock to use fixed 24MHz clock as well.
> 
>>
>> Guenter
>>
>>>          aspeed_create_type(priv);
>>>
>>
>>
> 
