From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sat, 25 Sep 2010 17:56:36 -0700
Subject: [PATCH v4] power: introduce library for device-specific OPPs
In-Reply-To: <201009252255.20933.rjw@sisk.pl>
References: <1285332640-16736-1-git-send-email-nm@ti.com>
	<20100924193742.GJ2375@linux.vnet.ibm.com>
	<201009252255.20933.rjw@sisk.pl>
Message-ID: <20100926005636.GB3396@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 25, 2010 at 10:55:20PM +0200, Rafael J. Wysocki wrote:
> On Friday, September 24, 2010, Paul E. McKenney wrote:
> > On Fri, Sep 24, 2010 at 07:50:40AM -0500, Nishanth Menon wrote:
> ...
> > 
> > Looks like a good start!!!  Some questions and suggestions about RCU
> > usage interspersed below.
> ...
> > > + * Locking: RCU reader.
> > > + */
> > > +int opp_get_opp_count(struct device *dev)
> > > +{
> > > +	struct device_opp *dev_opp;
> > > +	struct opp *temp_opp;
> > > +	int count = 0;
> > > +
> > > +	dev_opp = find_device_opp(dev);
> > > +	if (IS_ERR(dev_opp))
> > > +		return PTR_ERR(dev_opp);
> > > +
> > > +	rcu_read_lock();
> > > +	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
> > > +		if (temp_opp->available)
> > > +			count++;
> > > +	}
> > > +	rcu_read_unlock();
> > 
> > This one is OK as well.  You are returning a count, so if all of the
> > counted structures are freed at this point, no problem.  The count was
> > valid when it was accumulated, and the fact that it might now be obsolete
> > is (usually) not a problem.
> 
> However, it looks like it should run rcu_read_lock() before calling
> find_device_opp(dev), shouldn't it?

Indeed it does appear that you are right -- good catch!!!

							Thanx, Paul
