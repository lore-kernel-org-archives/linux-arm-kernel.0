From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 11 Jul 2013 11:31:46 +0200
Subject: [PATCH v12 10/13] usb: chipidea: add wait vbus lower than
 OTGSC_BSV before role starts
In-Reply-To: <20130711092535.GA11728@nchen-desktop>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <1373524041-10482-11-git-send-email-peter.chen@freescale.com>
 <51DE5DC8.8020605@pengutronix.de> <20130711092535.GA11728@nchen-desktop>
Message-ID: <51DE7B82.4030402@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 11:25 AM, Peter Chen wrote:
> On Thu, Jul 11, 2013 at 09:24:56AM +0200, Marc Kleine-Budde wrote:
>> On 07/11/2013 08:27 AM, Peter Chen wrote:
>>> When the gadget role starts, we need to make sure the vbus is lower
>>> than OTGSC_BSV, or there will be an vbus interrupt since we use
>>> B_SESSION_VALID as vbus interrupt to indicate connect and disconnect.
>>> When the host role starts, it may not be useful to wait vbus to lower
>>> than OTGSC_BSV, but it can indicate some hardware problems like the
>>> vbus is still higher than OTGSC_BSV after we disconnect to host some
>>> time later (500 jiffies currently), which is obvious not correct.
>>
>> Jiffies ist not constant. I think you have to specify the timeout in
>> fractions of HZ. The system ticks with HZ jiffies per second. So a
>> timeout of 500ms is "HZ / 2".
> 
> Thanks, I will use msecs_to_jiffies.

even better.

> 
>>> +/**
>>> + * hw_wait_reg: wait the register value
>>> + *
>>> + * Sometimes, it needs to wait register value before going on.
>>> + * Eg, when switch to device mode, the vbus value should be lower
>>> + * than OTGSC_BSV before connects to host.
>>> + *
>>> + * @ci: the controller
>>> + * @reg: register index
>>> + * @mask: mast bit
>>> + * @value: the bit value to wait
>>> + * @timeout: timeout to indicate an error
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> Better: timeout in jiffies
>>
> 
> As I will use msecs_to_jiffies, @timeout: timeout in millisecond.

Good idea - you might want to use timeout_ms.

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/a1363c68/attachment.sig>
