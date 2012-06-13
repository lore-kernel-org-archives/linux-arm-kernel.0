From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 07:47:39 +0000
Subject: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
In-Reply-To: <4FD78C7A.8070107@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
 <4FD78C7A.8070107@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99896E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 00:07:46, Hunter, Jon wrote:

> > +	case GPMC_WAITPIN_3:
> > +		idx =  GPMC_WAITPIN_IDX3;
> > +		break;
> > +	/* no waitpin */
> > +	case 0:
> > +		return 0;
> > +		break;
> 
> Do you need the break and return?

Not necessary, but to keep uniformity with the normal the way of case usage,
can remove it.

> I am wondering if we should combine all the gpmc_xxx_request pin
> functions into one. For example ...
> 
> static int gpmc_pin_request(int type, int pin)
> {
> 	int pin_num, pin_mask;
> 
> 	switch(type) {
> 	case GPMC_PIN_TYPE_CS:
> 		pin_num = GPMC_CS_NUM;
> 		pin_mask = gpmc_cs_map;
> 		break;
> 	case GPMC_PIN_TYPE_WAIT:
> 		pin_num = GPMC_NR_WAITPN;
> 		pin_mask = gpmc_waitpin_map;
> 		break;
> 	case GPMC_PIN_TYPE_WRITEPROTECT:
> 		pin_num = GPMC_NR_WP;
> 		pin_mask = gpmc_wp_map;
> 		break;
> 	default:
> 		return -ENODEV;
> 	}
> 
> 	if (pin >= pin_num)
> 		return -ENODEV;
> 
> 	if (gpmc_pin_is_reserved(pin_mask, pin))
> 		return -EBUSY;
> 
> 	gpmc_reserve_pin(pin_mask, pin);
> 
> 	return 0;
> }

I don't prefer it as part of this series, due to,
1. not sure whether this is right approach for writeprotect,
   and no current users for it
2. CS will affect existing interface, hence more chances of
   issues for the existing interface due to driver conversion


I would prefer optimization/cleanup to done separately,
not part of driver conversion series

Regards
Afzal
