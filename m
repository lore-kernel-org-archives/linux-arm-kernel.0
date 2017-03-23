From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 23 Mar 2017 18:55:50 +0100
Subject: [PATCH v4 1/4] pinctrl: rockchip: remove unnecessary locking
In-Reply-To: <20170323175153.1a576d3c.john@metanate.com>
References: <20170323105931.10455-1-john@metanate.com>
 <20170323161020.GM10423@jcartwri.amer.corp.natinst.com>
 <20170323175153.1a576d3c.john@metanate.com>
Message-ID: <9002373.ugSBBElCUj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 23. M?rz 2017, 17:51:53 CET schrieb John Keeping:
> On Thu, 23 Mar 2017 11:10:20 -0500, Julia Cartwright wrote:
> > One quick question below.  Apologies if this has been covered, but just
> > want to be sure.
> > 
> > On Thu, Mar 23, 2017 at 10:59:28AM +0000, John Keeping wrote:
> > > regmap_update_bits does its own locking and everything else accessed
> > > here is a local variable so there is no need to lock around it.
> > > 
> > > Signed-off-by: John Keeping <john@metanate.com>
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > v3: unchanged
> > > v2.1:
> > > - Remove RK2928 locking in rockchip_set_pull()
> > > v2:
> > > - Also remove locking in rockchip_set_schmitt()
> > > ---
> > > 
> > >  drivers/pinctrl/pinctrl-rockchip.c | 33
> > >  ++-------------------------------
> > >  1 file changed, 2 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> > > b/drivers/pinctrl/pinctrl-rockchip.c index bd4b63f66220..6568c867bdcd
> > > 100644
> > > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > 
> > [..]
> > 
> > > @@ -1185,17 +1177,14 @@ static int rockchip_set_drive_perpin(struct
> > > rockchip_pin_bank *bank,> > 
> > >  			rmask = BIT(15) | BIT(31);
> > >  			data |= BIT(31);
> > >  			ret = regmap_update_bits(regmap, reg, rmask, data);
> > > 
> > > -			if (ret) {
> > > -				spin_unlock_irqrestore(&bank->slock, flags);
> > > +			if (ret)
> > > 
> > >  				return ret;
> > > 
> > > -			}
> > > 
> > >  			rmask = 0x3 | (0x3 << 16);
> > >  			temp |= (0x3 << 16);
> > >  			reg += 0x4;
> > >  			ret = regmap_update_bits(regmap, reg, rmask, temp);
> > 
> > Killing the lock here means the writes to to this pair of registers (reg
> > and reg + 4) can be observed non-atomically.  Have you convinced
> > yourself that this isn't a problem?
> 
> I called it out in v1 [1] since this bit is new since v4.4 where I
> originally wrote this patch, and didn't get any comments about it.
> 
> I've convinced myself that removing the lock doesn't cause any problems
> for writing to the hardware: if the lock would prevent writes
> interleaving then it means that two callers are trying to write
> different drive strengths to the same pin, and even with a lock here one
> of them will end up with the wrong drive strength.
> 
> But it does mean that a read via rockchip_get_drive_perpin() may see an
> inconsistent state.  I think adding a new lock specifically for this
> particular drive strength bit is overkill and I can't find a scenario
> where this will actually matter; any driver setting a pinctrl config
> must already be doing something to avoid racing two configurations
> against each other, mustn't it?

also, pins can normally only be requested once - see drivers complaining if 
one of their pins is already held by a different driver. So if you really end 
up with two things writing to the same drive strength bits, the driver holding 
the pins must be really messed up anyway :-)


Heiko
