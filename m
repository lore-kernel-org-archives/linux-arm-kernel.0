From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 4 May 2018 19:19:27 +0200
Subject: [PATCH net-next v2 01/13] net: phy: sfp: make the i2c-bus
 property really optional
In-Reply-To: <fd91699d-c290-8821-b4a6-0789071cfba1@gmail.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-2-antoine.tenart@bootlin.com>
 <fd91699d-c290-8821-b4a6-0789071cfba1@gmail.com>
Message-ID: <20180504171927.GB13899@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Fri, May 04, 2018 at 10:03:16AM -0700, Florian Fainelli wrote:
> On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> >  
> >  static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
> >  {
> > +	if (!sfp->read)
> > +		return -EOPNOTSUPP;
> 
> -ENODEV would be closer to the intended meaning IMHO, those this could
> be argue that this is yet another color to paint the bikeshed with.

I thought about -ENODEV as well, but ended up choosing -EOPNOTSUPP for
some reason. But I'm really fine with both solutions, it really depends
on if we want to return a callback isn't available from a s/w point of
view (-EOPNOTSUPP) or a h/w point of view (-ENODEV).

> >  	ret = sfp_read(sfp, false, 0, &id, sizeof(id));
> > +	if (ret == -EOPNOTSUPP)
> > +		return ret;
> 
> Can you find a way such that only sfp_sm_mod_probe() needs to check
> whether the sfp read/write operations returned failure and then we just
> make sure the SFP state machine does not make any more progress? Having
> to check the sfp_read()/sfp_write() operations all over the place sounds
> error prone and won't scale in the future.

I tried doing this in this way (only having logic in the probe
function), but that wasn't as simple as this solution and it seemed
quite invasive as these read/write calls can be called from a few
functions but many code paths (as it's a state machine). So I choose the
easiest solution to maintain in the long run, as each future state
machine update could impact this.

Thanks!
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
