From: grygorii.strashko@linaro.org (Grygorii.Strashko@linaro.org)
Date: Mon, 06 Apr 2015 16:11:47 +0300
Subject: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <20150403201846.GH2016@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana> <550C67D6.3080909@linaro.org>
 <20150403201846.GH2016@katana>
Message-ID: <55228613.2060607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2015 11:18 PM, Wolfram Sang wrote:
> 
>>> The I2C specs say in 3.1.16 that the recovery procedure should be used
>>> when SDA is stuck low. So, I do wonder if we should apply the recovery
>>> after a timeout. Stuck SDA might be one reason for timeout, but there
>>> may be others...
>>
>> This is ancient code. And regarding your question -
>> Might be it would be reasonable to add call of
>> i2c_davinci_wait_bus_not_busy() at the end of i2c_davinci_xfer()?
>> This way we will wait for Bus Free before performing recovery.
> 
> That might be an improvement, but the generic question still remains:
> Is a timeout a reason for recovery? SDA stuck low is one reason for a
> timeout. I have problems making up my mind here between being pragmatic
> and being in accordance with the specs.

The timeout here means there were no responses from I2C controller within some
reasonable time period (default - 1 sec). Which in turn
means that Bus/HW state is "unknown" and init&recovery seems reasonable here, but
yes - "init&recovery" could be optimized more, but, in my opinion, only
as subsequent patches.

Actually, i2c_generic_recovery() will just exit if SDA is high already.

> 
>> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
>> as proposed by Alexander Sverdlin here:
>>   https://patchwork.ozlabs.org/patch/448994/.
> 
> Okay, good that you said it. So I'll give his patch series priority over
> this one.


Sorry, but this series already mises few merge windows and it has a lot
of revied-by and tested-by, so could we proceed please?

Re-based & re-sent http://www.spinics.net/lists/arm-kernel/msg410810.html

-- 
regards,
-grygorii
