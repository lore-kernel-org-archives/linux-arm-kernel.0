From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 25 Jul 2014 15:33:17 +0200
Subject: [PATCH v3 4/4] can: flexcan: add vf610 support for FlexCAN
In-Reply-To: <601adb6fe47279c115c1cc607365a00e@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
 <ff2ea1726b13dc2ffa3519ce9244f3633cf1420d.1405428166.git.stefan@agner.ch>
 <53C5398F.2000005@pengutronix.de> <1b8a8ca03b4a160027a79b722f697e25@agner.ch>
 <601adb6fe47279c115c1cc607365a00e@agner.ch>
Message-ID: <53D25C9D.5080803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 12:50 PM, Stefan Agner wrote:
> Am 2014-07-16 08:43, schrieb Stefan Agner:
>> Am 2014-07-15 16:24, schrieb Marc Kleine-Budde:
>> <snip>
>>>> @@ -150,18 +171,20 @@
>>>>   * FLEXCAN hardware feature flags
>>>>   *
>>>>   * Below is some version info we got:
>>>> - *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT
>>>> - *                                Filter?   connected?
>>>> - *   MX25  FlexCAN2  03.00.00.00     no         no
>>>> - *   MX28  FlexCAN2  03.00.04.00    yes        yes
>>>> - *   MX35  FlexCAN2  03.00.00.00     no         no
>>>> - *   MX53  FlexCAN2  03.00.00.00    yes         no
>>>> - *   MX6s  FlexCAN3  10.00.12.00    yes        yes
>>>> + *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT  Memory err
>>>> + *                                Filter?   connected?  detection
>>>> + *   MX25  FlexCAN2  03.00.00.00     no         no         no
>>>> + *   MX28  FlexCAN2  03.00.04.00    yes        yes         no
>>>> + *   MX35  FlexCAN2  03.00.00.00     no         no         no
>>>> + *   MX53  FlexCAN2  03.00.00.00    yes         no         no
>>>> + *   MX6s  FlexCAN3  10.00.12.00    yes        yes         no
>>>> + *   VF610 FlexCAN3  ?               no         no        yes
>>>                                         ^^         ^^
>>>
>>> Can you check the datasheet if the flexcan core has a "Glitch Filter
>>> Width Register (FLEXCANx_GFWR)"
>>
>>
>> There is no such register called GFWR/Glitch Filter or similar.
>>
>>> Can you check if the core generates a warning interrupt with the current
>>> setup, if you don't switch on bus error reporting? This means internally
>>> the [TR]WRN_INT is connected and works as specified.
>>
>> Ok, so I disabled TWRNMSK (Bit 11) in the control register and printed
>> out the error and status register (ESR1), this is what I get:
>> [  191.285295] flexcan_irq, esr=00040080
>> [  191.288996] flexcan_irq, ctrl=17092051
>>
>> Bit 17 (TWRNINT) is not set while TWRNMSK is disabled. Hence [TR]WRN_INT
>> is not connected?
> 
> Ping. Anything open/to do from my side?

Please keep the printing of esr and ctrl in the interrupt handler, add a
#define DEBUG in the driver, but do not change anything else. Then:

start the driver as usual:
- configure bitrate
- ifconfig can0 up
- _do_not_ enable bit error reporint
- start candump from gitorious with:
  candump -e any,0:0,#FFFFFFFF
- short circuit CAN-High and CAN-Low
- send a CAN frame

Another test is to setup a proper CAN bus, but configure the a second
CAN node with a different bitrate. Start the can0 on vf610 as usual,
then candump -e any,0:0,#FFFFFFFF, but do not send any CAN frames on the
vf610. Then on the other system keep sending CAN frames, you might have
to restart the CAN on the second system....

Please send the outputs of candump and demsg to the list. It should
generate a warning, error passive and finally a busoff message.

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/b64a1efe/attachment.sig>
