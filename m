From: john@metanate.com (John Keeping)
Date: Wed, 15 Mar 2017 18:46:27 +0000
Subject: [PATCH v2 2/4] pinctrl: rockchip: convert to raw spinlock
In-Reply-To: <20170315182309.GD682@jcartwri.amer.corp.natinst.com>
References: <20170315174654.15128-1-john@metanate.com>
 <20170315180137.GB682@jcartwri.amer.corp.natinst.com>
 <20170315180806.3714af56.john@metanate.com>
 <8564532.G8NNa9Oa4k@phil>
 <20170315182309.GD682@jcartwri.amer.corp.natinst.com>
Message-ID: <20170315184627.60baad35.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Mar 2017 13:23:09 -0500, Julia Cartwright wrote:
> On Wed, Mar 15, 2017 at 07:16:53PM +0100, Heiko Stuebner wrote:
> > Am Mittwoch, 15. M?rz 2017, 18:08:06 CET schrieb John Keeping:  
> > > On Wed, 15 Mar 2017 13:01:37 -0500, Julia Cartwright wrote:  
> > > > On Wed, Mar 15, 2017 at 05:46:52PM +0000, John Keeping wrote:  
> > > > > This lock is used from rockchip_irq_set_type() which is part of the
> > > > > irq_chip implementation and thus must use raw_spinlock_t as documented
> > > > > in Documentation/gpio/driver.txt.
> > > > > 
> > > > > Signed-off-by: John Keeping <john@metanate.com>
> > > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > > ---
> > > > > v2: unchanged
> > > > > ---
> > > > > 
> > > > >  drivers/pinctrl/pinctrl-rockchip.c | 30 +++++++++++++++---------------
> > > > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> > > > > b/drivers/pinctrl/pinctrl-rockchip.c index 128c383ea7ba..8c1cae6d78d7
> > > > > 100644  
> [..]
> > > > > @@ -1295,14 +1295,14 @@ static int rockchip_set_pull(struct
> > > > > rockchip_pin_bank *bank,> > 
> > > > >  	switch (ctrl->type) {
> > > > > 
> > > > >  	case RK2928:
> > > > > -		spin_lock_irqsave(&bank->slock, flags);
> > > > > +		raw_spin_lock_irqsave(&bank->slock, flags);
> > > > > 
> > > > >  		data = BIT(bit + 16);
> > > > >  		if (pull == PIN_CONFIG_BIAS_DISABLE)
> > > > >  		
> > > > >  			data |= BIT(bit);  
> > > > 
> > > > This should be lifted out from under the lock.
> > > >   
> > > > >  		ret = regmap_write(regmap, reg, data);  
> > > > 
> > > > How is this legal?  The regmap_write() here is going to end up acquiring
> > > > the regmap mutex.  
> > > 
> > > It's not, the spinlock can be deleted here.  I only have RK3288 hardware
> > > to test and I missed this when checking the uses of slock.  
> > 
> > That part could very well also use regmap_update_bits like the other parts.
> > Not really sure, why we use regmap_write here, but I'm also not sure, if it 
> > matters at all.  
> 
> regmap_update_bits also acquires the regmap lock, which would similarly
> be a problem here.[1]
> 
> But, if we could pull this entire operation out of the lock (and
> convince ourselves that it's okay to do so), then even better!

Yes, we can delete the lock here for the same reason as all of the
others that are removed in patch 1.

I don't think it makes much difference whether we use regmap_write or
regmap_update_bits here (although consistently using regmap_update_bits
might be nice) so I won't change it as part of this series, especially
since I don't have an RK2928 to test.


John
