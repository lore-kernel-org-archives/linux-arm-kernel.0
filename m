From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 24 Mar 2011 14:24:51 +0100
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <384BC720F8C741B886DC000F067EBA20@subhasishg>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<4D776B05.4010506@pengutronix.de>
	<384BC720F8C741B886DC000F067EBA20@subhasishg>
Message-ID: <4D8B4623.4010709@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2011 02:16 PM, Subhasish Ghosh wrote:
> Hello,
> 
>> A device may be de-initialized and another loaded or two different
>> devices
>> can be run simultaneously on the two cores.
>> It's also possible, as in our case, to implement a single device on both
>> the PRU's resulting in improved load sharing.
> 
>> Make you driver compile with sparse "make C=1", you cast way too much
>> when accessing io mem. Use void __iomem * instead of u32 *.
> 
> 
> With make C=1 I am receiving some warnings such as:
> 
> warning: cast removes address space of expression
> drivers/mfd/da8xx_pru.c:61:17: warning: incorrect type in argument 1
> (different base types)
> drivers/mfd/da8xx_pru.c:61:17:    expected void const volatile [noderef]
> <asn:2>*<noident>
> drivers/mfd/da8xx_pru.c:61:17:    got int
> drivers/mfd/da8xx_pru.c:66:28: warning: incorrect type in argument 1
> (different address spaces)

(Re)read the warning carefully:

You have to fix drivers/mfd/da8xx_pru.c, the first argument should be
__void iomem *, not an int. Fix the type of the first argument. Don't
use any casts at all, follow all warnings, eventually you will have void
__iomem * (or struct * instead of void *) and no warnings.

> I can remove all of these by casting to (__force void  __iomem *) but is
> this correct.

No evil casts, please :)

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110324/fc02347e/attachment.sig>
