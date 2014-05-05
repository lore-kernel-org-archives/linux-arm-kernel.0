From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 05 May 2014 15:00:05 +0200
Subject: [PATCH 1/2] hwinit support for non-TI devices
In-Reply-To: <20140505125811.GC16649@amd.pavel.ucw.cz>
References: <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120810.GB16461@amd.pavel.ucw.cz> <5367824D.2070406@pengutronix.de>
 <20140505125811.GC16649@amd.pavel.ucw.cz>
Message-ID: <53678B55.1070709@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2014 02:58 PM, Pavel Machek wrote:
> On Mon 2014-05-05 14:21:33, Marc Kleine-Budde wrote:
>> On 05/05/2014 02:08 PM, Pavel Machek wrote:
>>> Non-TI chips (including socfpga) needs different raminit
>>> sequence. Implement it.
>>>
>>> Tested-by: Thor Thayer <tthayer@altera.com>
>>> Signed-off-by: Thor Thayer <tthayer@altera.com>
>>> Signed-off-by: Pavel Machek <pavel@denx.de>
>>>
>>> @@ -88,7 +89,8 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>>>  	spin_lock(&raminit_lock);
>>>  
>>>  	ctrl = readl(priv->raminit_ctrlreg);
>>> -	/* We clear the done and start bit first. The start bit is
>>> +	/*
>>> +	 * We clear the done and start bit first. The start bit is
>>
>> Please don't reformat comments.
> 
> Previous one is not correct coding style. I'd like to get it fixed.

net/ and drivers/net use a different multiline commenting style.

> 
> priv, bool enable)
>>>  	spin_unlock(&raminit_lock);
>>>  }
>>>  
>>> +static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>>> +{
>>> +	u32 ctrl;
>>> +
>>> +	spin_lock(&raminit_lock);
>>
>> Why do you need this spinlock?
> 
> _ti() used spinlock, so I assume I need it, too.

It's not a shared ressource you're working on. TI does.

> 
>>> +	ctrl = readl(priv->raminit_ctrlreg);
>>> +	ctrl &= ~DCAN_RAM_INIT_BIT;
>>> +	writel(ctrl, priv->raminit_ctrlreg);
>>
>> Why don't use use the reg directly? Have you read my previous
>> review?
> 
> Can you repost it? I don't think I seen it.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
