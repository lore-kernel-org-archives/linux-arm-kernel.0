From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 04 Nov 2014 14:28:52 +0100
Subject: [PATCH 7/7] can: m_can: workaround for transmit data less than
 4 bytes
In-Reply-To: <5458D0FA.1040504@hartkopp.net>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
 <1414579527-31100-7-git-send-email-b29396@freescale.com>
 <5457B1D1.6080301@pengutronix.de>
 <20141104082505.GA8060@shlinux1.ap.freescale.net>
 <54589AC8.4010106@pengutronix.de>
 <20141104092651.GC8060@shlinux1.ap.freescale.net>
 <5458AB65.7000500@pengutronix.de> <5458D0FA.1040504@hartkopp.net>
Message-ID: <5458D494.3040700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2014 02:13 PM, Oliver Hartkopp wrote:
> 
> 
> On 04.11.2014 11:33, Marc Kleine-Budde wrote:
>> On 11/04/2014 10:27 AM, Dong Aisheng wrote:
> 
> 
>>> +       /* We meet an IC issue that we have to write the full 8
>>
>> At least on the *insert SoC name here*, an issue with the Message RAM
>> was discovered. Sending CAN frames with dlc less than 4 bytes will lead
>> to bit errors, when the first 8 bytes of the Message RAM have not been
>> initialized (i.e. written to). To work around this issue, the first 8
>> bytes are initialized here.
> 
> Yes. Also put the current IP revision (3.0.x) into the comment.

Good idea - also add the SoC's mask revision.

> Did inform the Bosch guys from this issue - or is it already in some
> errata sheet?
> 
>>
>>> +        * bytes (whatever value for the second word) in Message RAM to
>>> +        * avoid bit error for transmit data less than 4 bytes at the
>>> first
>>> +        * time. By initializing the first 8 bytes of tx buffer
>>> before using
>>> +        * it can avoid such issue.
>>> +        */
>>> +       m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(0), 0x0);
>>> +       m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(1), 0x0);
>>> +
>>>          m_can_config_endisable(priv, false);
>>>   }
>>
>> Can you trigger the issue when sending CAN-FD frames with dlc > 8 && dlc
>> < 64?
> 
> Just a nitpick:
> 
> DLC can just be 0 .. 15

Correct, I was talking about the length

> and the length (struct canfd_frame.len) can be from 0 .. 64
> 
> See:
> 
> http://lxr.free-electrons.com/source/include/uapi/linux/can.h#L83
> 
> That's the reason for all these helpers
> 
> http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L36
> 
> that hide the evil "DLC" from userspace now and make 'len' a usable loop
> variable as we were able to use the former dlc for classic CAN :-)

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141104/ad957e98/attachment.sig>
