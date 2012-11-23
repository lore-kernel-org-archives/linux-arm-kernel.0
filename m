From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 23 Nov 2012 11:00:21 +0100
Subject: [PATCH v3 3/7] usb: chipidea: usbmisc: fix a potential race
 condition
In-Reply-To: <20121123053635.GB22420@nchen-desktop>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-4-git-send-email-m.grzeschik@pengutronix.de>
 <20121123053635.GB22420@nchen-desktop>
Message-ID: <50AF4935.4000707@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2012 06:36 AM, Peter Chen wrote:
> On Wed, Nov 21, 2012 at 03:06:29PM +0100, Michael Grzeschik wrote:
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> This fixes a potential race condition where the ci13xxx_imx glue code
>> could be fast enough to call one of the usbmisc_ops before he got a
>> valid value on the static usbmisc pointer. To fix that we first set
>> usbmisc, then call usbmisc_set_ops().
> 
> usbmisc is subsys_initcall, and cil13xxx_imx is module_init. Any
> potential situation that the ci13xxx_imx's probe is ran before the
> usbmisc's probe is completed? Besides, there is usbmisc_ops value
> check at the beginning of cil13xxx_imx's probe.

It's bad practice to rely your code on some external ordering mechanism,
even more if the correct solution is so simple. And as Sascha pointed
out everything might be build as modules and loaded individually.

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
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/0408da18/attachment.sig>
