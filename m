From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 22 Feb 2011 15:36:02 +0300
Subject: [PATCH 2/2] DM9000B: Fix PHY power for network down/up
In-Reply-To: <4D62D323.7010403@henry.nestler.mail.gmail.com>
References: <4D618B5D.5040001@henry.nestler.mail.gmail.com>	<4D62491F.4050602@ru.mvista.com>
	<4D62D323.7010403@henry.nestler.mail.gmail.com>
Message-ID: <4D63ADB2.7090105@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-02-2011 0:03, Henry Nestler wrote:

>>> DM9000 revision B needs 1 ms delay after PHY power on (see spec), and PHY
>>> power must on in register

>>      Couldn't parse that.

    You seem to have missed a word in your patch description.

> This can read in manual DM900B-12-DS-F02 from September 2 2010, Page 14:
> "If this Register 1FH bit 0 is updated from '1' to '0', the all
> Registers can not be accessed within 1ms."

    That I've understood.

> The example driver code waits 2 ms.

>>> diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
>>> index 2d4c4fc..5925569 100644
>>> --- a/drivers/net/dm9000.c
>>> +++ b/drivers/net/dm9000.c
>> [...]
>>> @@ -1194,6 +1191,10 @@ dm9000_open(struct net_device *dev)
>>>    	if (request_irq(dev->irq, dm9000_interrupt, irqflags, dev->name, dev))
>>>    		return -EAGAIN;
>>>
>>> +	/* GPIO0 on pre-activate PHY, Reg 1F is not set by reset */
>>> +	iow(db, DM9000_GPR, 0);	/* REG_1F bit0 activate phyxcer */
>>> +	udelay(1000); /* delay needs by DM9000B */

>>      Why not mdelay(1)?

> Because udelay is the base of mdelay.
> See include/linux/delay.h:31

> #define mdelay(n) ... udelay((n)*1000)

    And?

WBR, Sergei
