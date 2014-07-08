From: tj@kernel.org (Tejun Heo)
Date: Tue, 8 Jul 2014 13:18:17 -0400
Subject: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
In-Reply-To: <20140708170353.GA16148@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
 <20140708170353.GA16148@kwain>
Message-ID: <20140708171817.GH4979@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 08, 2014 at 07:03:53PM +0200, Antoine T?nart wrote:
> > So, hpriv->port is both input and output?  This is messy and can lead
> > to confusing failures and there now are multiple ways to modify
> > port_map.  If carrying this information through ahci_host_priv is
> > necessary, let's remove the direct params and introduce new input
> > fields to the struct.
> 
> We just use hpriv->port_map to check port_map is valid and describes
> available ports there.
> 
> hpriv->port_map is filed by the generic ahci_platform_get_resources()
> function when using the new bindings and not by the drivers. port_map is
> the input from the drivers.

So, yeah, it's being used both as input and output and we also have
the arguments which affect port_map, right?  It does seem confusing.

> Well, a had a review a week ago about in the PHY driver saying I should
> avoid using fixed sized arrays... And it was in a driver were we know
> the maximum number of PHY available.
> 
> I think in this case were the number of PHYs depends on the h/w, we should
> use a dynamically allocated array.

Well, so does clk.  Let's say clk is more restricted and phy can be
one or more per port and thus needs to be dynamic.  If so, shouldn't
we at least have some correlation between phys and ports?  It bothers
me that now libahci is carrying random number of resources that it has
no idea how to associate with the ports it manages.  What if later we
want to involve phy driver in power managing unoccupied ports?

Thanks.

-- 
tejun
