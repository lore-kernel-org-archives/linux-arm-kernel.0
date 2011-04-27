From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Apr 2011 15:21:56 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>	<1303474267-6344-2-git-send-email-subhasish@mistralsolutions.com>
	<4DB1A3B7.7060300@pengutronix.de> <4DB5D452.9050500@grandegger.com>
	<46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
Message-ID: <4DB81874.1060904@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 03:08 PM, Subhasish Ghosh wrote:

>>>> +static u32 pruss_intc_init[19][3] = {
>>>> + {PRUSS_INTC_POLARITY0, PRU_INTC_REGMAP_MASK, 0xFFFFFFFF},
>>>> + {PRUSS_INTC_POLARITY1, PRU_INTC_REGMAP_MASK, 0xFFFFFFFF},
>>>> + {PRUSS_INTC_TYPE0, PRU_INTC_REGMAP_MASK, 0x1C000000},
>>>> + {PRUSS_INTC_TYPE1, PRU_INTC_REGMAP_MASK, 0},
>>>> + {PRUSS_INTC_GLBLEN, 0, 1},
>>>> + {PRUSS_INTC_HOSTMAP0, PRU_INTC_REGMAP_MASK, 0x03020100},
>>>> + {PRUSS_INTC_HOSTMAP1, PRU_INTC_REGMAP_MASK, 0x07060504},
>>>> + {PRUSS_INTC_HOSTMAP2, PRU_INTC_REGMAP_MASK, 0x0000908},
>>>> + {PRUSS_INTC_CHANMAP0, PRU_INTC_REGMAP_MASK, 0},
>>>> + {PRUSS_INTC_CHANMAP8, PRU_INTC_REGMAP_MASK, 0x00020200},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 32},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 19},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 19},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 18},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 18},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 34},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 34},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 32},
>>>> + {PRUSS_INTC_HOSTINTEN, 0, 5}
>>>
>>> please add ","
>>
>> Also a struct to describe each entry would improve readability.
>> Then you could also use ARRAY_SIZE.
> 
> SG _ I could not follow this, are you recommending that I create a
> structure with three variables and then create
>            an array for it.
> something like:
> 
> const static struct [] = {
>    {
>    unsigned int reg_base;
>    unsigned int reg_mask;
>    unsigned int reg_val;
>    },
> ...
> };

I think this isn't valid C. It should look like this:

struct pruss_intc_init {
	unsigned long reg_base;
	u32 reg_mask;
	u32 reg+val;
};

static const struct pruss_intc_init pruss_initc_init[] = {
	{ .reg_base = 0xdeadbeef, .reg_mask = 0xaa, .reg_val = 0x55 },
	...
};

I'm not sure about the datatype of reg_base. I haven't looked at the
code that uses this array.

cheers, Marc

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110427/899d2e60/attachment.sig>
