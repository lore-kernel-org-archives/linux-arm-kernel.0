From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 18 Jun 2013 13:26:04 +0200
Subject: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
In-Reply-To: <20130618104338.584098e1@skate>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130612104207.GE30841@mithrandir> <20130618104338.584098e1@skate>
Message-ID: <20130618112604.GD6322@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 10:43:38AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Wed, 12 Jun 2013 12:42:40 +0200, Thierry Reding wrote:
> > On Thu, Jun 06, 2013 at 06:41:24PM +0200, Thomas Petazzoni wrote:
> > [...]
> > > @@ -292,6 +454,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
> > >  
> > >  #endif
> > >  
> > > +	armada_370_xp_msi_init(node);
> > > +
> > 
> > So I see that you don't have access to the original platform device
> > here, but you could use of_find_device_by_node() to obtain it and pass
> > that into armada_370_xp_msi_init() in order to set the msi_chip.dev
> > field. Or you could do the lookup in armada_370_xp_msi_init() if you
> > don't need it for anything else in armada_370_xp_mpic_of_init().
> 
> As I replied to Grant, of_find_device_by_node() returns NULL, I believe
> because the all IRQ controller driver initialization is done pretty
> early, before the of_platform_populate() call is made, so there is no
> platform_device associated with the IRQ controller node at the time the
> armada_370_xp_mpic_of_init() function is called.
> 
> Do you see another approach, especially in relation to your comment on
> PATCH 2/8 ?

Hmmm, that's too bad. The only other possibility that I see is that you
could associate the struct device at a later point when it becomes
available, but looking at the irqchip driver it doesn't look like you
get notification of that either. I suppose you could add a
platform_driver to it and hook things up in its .probe() callback, but
I'm not sure if that's in line with how the irqchip was designed. Adding
Grant Likely and Thomas Gleixner on Cc, maybe they have better advice.

Looking at other irqchip drivers I find it a bit odd to see how they're
structured, though. We've been preaching for years that drivers should
be well-encapsulated and told everybody it was bad to use globals and
they should be associating driver-specific data with each instance of a
device. Then comes along irqchip and all of a sudden it's okay to use
globals again. It feels a bit fragile.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/51731f1c/attachment.sig>
