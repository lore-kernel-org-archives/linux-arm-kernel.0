From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 19 Nov 2018 11:40:46 +0100
Subject: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
In-Reply-To: <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-7-lkundrak@v3.sk>
 <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
 <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
Message-ID: <20181119104046.GC28607@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/ctype.h>
> > > +#include <linux/olpc-ec.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/reboot.h>
> > > +#include <linux/input.h>
> > > +#include <linux/kfifo.h>
> > > +#include <linux/module.h>
> > > +#include <linux/power_supply.h>
> > 
> > Easy to maintain when it's sorted.

No / it depends.

> > > +       channel = priv->rx_buf[0];
> > > +       byte = priv->rx_buf[1];
> > 
> > Maybe specific structures would fit better?
> > 
> > Like
> > 
> > struct olpc_ec_resp_hdr {
> >  u8 channel;
> >  u8 byte;
> > ...
> > }

Structures have padding and other nastyness...

> > > +                       pm_wakeup_event(priv->pwrbtn->dev.parent,
> > > 1000);
> > 
> > Magic number.

Nothing wrong with magic numbers.

> > > +       args[0] = mask & 0xff;
> > > +       args[1] = (mask >> 8) & 0xff;
> > 
> > ...mask >> 0;
> > ...mask >> 8;

No, please.

> > __maybe_unused  instead of ugly #ifdef?
> > 
> > > +{
> > > +       struct platform_device *pdev = to_platform_device(dev);
> > > +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);
> > 
> > dev_get_drvdata() or how is it called?
> > 
> > > +       unsigned char hintargs[5];
> > 
> > struct olpc_ec_hint_cmd {
> > u8 ...
> > u32 ...
> > };
> > 
> > ?

No, unless you want to break the code. Or add __attribute__ packed and
deal with endianness.

Just no.

> > > +       static unsigned int suspend_count;
> > 
> > u32 I suppose.

You know, there's semantic difference between unsigned int and
u32. And this sounds like candidate for unsigned int.

> > > +       /* Enable all EC events while we're awake */
> > > +       olpc_xo175_ec_set_event_mask(0xffff);
> > 
> > #define EC_ALL_EVENTS GENMASK(15, 0)

Actually that's less readable. Just don't.

> > > +static const struct of_device_id olpc_xo175_ec_of_match[] = {
> > > +       { .compatible = "olpc,xo1.75-ec" },
> > > +       { },
> > 
> > No comma for terminators.

Comma is fine.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/3c171663/attachment-0001.sig>
