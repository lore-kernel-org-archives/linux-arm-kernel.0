From: grygorii.strashko@linaro.org (Grygorii.Strashko@linaro.org)
Date: Fri, 20 Mar 2015 20:32:54 +0200
Subject: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <20150318203151.GA12072@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana>
Message-ID: <550C67D6.3080909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 03/18/2015 10:31 PM, Wolfram Sang wrote:
> Hi,
> 
> so, the bus recovery patches look fine to me in general.
> 
> It is only this one question left which I always had with bus recovery.
> Maybe you guys can join me thinking about it.

Ok. Thanks and sorry for delayed reply - missed your e-mail :(
I'll resend them next week.

> 
>> @@ -376,8 +366,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>>   						      dev->adapter.timeout);
>>   	if (r == 0) {
>>   		dev_err(dev->dev, "controller timed out\n");
>> -		davinci_i2c_recover_bus(dev);
>> -		i2c_davinci_init(dev);
>> +		i2c_recover_bus(adap);
>>   		dev->buf_len = 0;
>>   		return -ETIMEDOUT;
> 
> The I2C specs say in 3.1.16 that the recovery procedure should be used
> when SDA is stuck low. So, I do wonder if we should apply the recovery
> after a timeout. Stuck SDA might be one reason for timeout, but there
> may be others...

This is ancient code. And regarding your question -
Might be it would be reasonable to add call of
i2c_davinci_wait_bus_not_busy() at the end of i2c_davinci_xfer()?
This way we will wait for Bus Free before performing recovery.

Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
as proposed by Alexander Sverdlin here:
 https://patchwork.ozlabs.org/patch/448994/. 

-- 
regards,
-grygorii
