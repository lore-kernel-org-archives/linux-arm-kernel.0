From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:45:45 +0200
Subject: [PATCH 07/20] regmap: Without bus read() or write(), force
 use_single_rw
In-Reply-To: <CAGS+omC6dFVnzWmQN2XGy31s1nm-hQJ6DigJREynCAf7A-PcFg@mail.gmail.com>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
 <CAGS+omC6dFVnzWmQN2XGy31s1nm-hQJ6DigJREynCAf7A-PcFg@mail.gmail.com>
Message-ID: <20150812104545.GB19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 12, 2015 at 06:33:55PM +0800, Daniel Kurtz wrote:
> Hi Markus,
> 
> On Wed, Aug 12, 2015 at 6:12 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> >
> > The implementation of regmap bus read() and write() methods are
> > optional. Therefore we have to handle busses which do not have these
> > functions. If raw read() and write() is not supported we have to use
> > reg_read and reg_write always.
> >
> > This patch sets use_single_rw if read() or write() is not set.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/base/regmap/regmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> > index f98bd5bf5c62..35ad3783da70 100644
> > --- a/drivers/base/regmap/regmap.c
> > +++ b/drivers/base/regmap/regmap.c
> > @@ -573,7 +573,7 @@ struct regmap *regmap_init(struct device *dev,
> >                 map->reg_stride = config->reg_stride;
> >         else
> >                 map->reg_stride = 1;
> > -       map->use_single_rw = config->use_single_rw;
> > +       map->use_single_rw = config->use_single_rw || !bus->read || !bus->write;
> 
> What if bus is NULL?

Yes thanks, that has to be checked.

Best Regards,

Markus

> 
> -Dan
> 
> >         map->can_multi_write = config->can_multi_write;
> >         map->dev = dev;
> >         map->bus = bus;
> > --
> > 2.4.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/2cb7711c/attachment.sig>
