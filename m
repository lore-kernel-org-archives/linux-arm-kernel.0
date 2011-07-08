From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Fri, 8 Jul 2011 16:45:00 +0200
Subject: [PATCH 1/2] mc13783: add power button support
In-Reply-To: <20110708143032.GT29624@pengutronix.de>
References: <1310135037-24289-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310135037-24289-2-git-send-email-philippe.retornaz@epfl.ch>
	<20110708143032.GT29624@pengutronix.de>
Message-ID: <201107081645.00724.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> > +config INPUT_MC13783_ON
> > +	tristate "MC13783 ON buttons"
> > +	depends on MFD_MC13783
> > +	help
> > +	  Support the ON buttons of MC13783 PMIC as an input device
> > +	  reporting power button status.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called mc13783-pwrbutton.
> 
> Why not use INPUT_MC13783_PWRBUTTON to match the source file (and so
> module) name.

Ok.

> 
> > +
> > +
> 
> one empty line should be enough

Ok.

> > diff --git a/drivers/input/misc/mc13783-pwrbutton.c
> > b/drivers/input/misc/mc13783-pwrbutton.c new file mode 100644
> > index 0000000..6aee01c
> > --- /dev/null
> > +++ b/drivers/input/misc/mc13783-pwrbutton.c
> > @@ -0,0 +1,288 @@
> > +/**
> > + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> > + *
> > + * Copyright (C) 2011 Philippe R?tornaz
> > + *
> > + * Based on twl4030-pwrbutton driver by:
> > + *     Peter De Schrijver <peter.de-schrijver@nokia.com>
> > + *     Felipe Balbi <felipe.balbi@nokia.com>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General
> > + * Public License. See the file "COPYING" in the main directory of this
> > + * archive for more details.
> 
> This implies GPL v2 only? So you either need to clearify here or you
> need to adapt the MODULE_LICENSE line below to read
> 
> 	MODULE_LICENSE("GPL v2");

Well, I took exactly the same license than the twl4030-pwrbutton. 
This driver is: MODULE_LICENSE("GPL"), why should I change it ?

> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> > USA
> 
> This is not the recent address of the FSF.

Ok, will update to 51 Franklin Street, Suite 500, Boston, MA 02110-1335


> > --- a/drivers/mfd/mc13xxx-core.c
> > +++ b/drivers/mfd/mc13xxx-core.c
> > 
> > @@ -778,6 +778,10 @@ err_revision:
> >  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
> >  		
> >  				pdata->leds, sizeof(*pdata->leds));
> > 
> > +	if (pdata->flags & MC13XXX_USE_BUTTON)
> 
> Why not use
> 
> 	if (pdata->buttons)
> 
> to detect if the pwrbutton device should be registered?

To keep consistancy as the others sub-device are registered the same way 
(regulator, led). I can do it as you propose for the button but IMHO it's a 
bit strange to have a MC13XXX_USE_* for all the subdevice except the buttons. 
So should I change ?

Thanks for the review ! 

Philippe
