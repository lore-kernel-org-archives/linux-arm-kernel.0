From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 2 Feb 2014 15:54:27 +0100
Subject: [PATCH 0/3] spi: core: Introduce devm_spi_alloc_master
In-Reply-To: <20140201173841.GU22609@sirena.org.uk>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140131121215.GB22609@sirena.org.uk>
 <20140131133111.GF2950@lukather>
 <20140201173841.GU22609@sirena.org.uk>
Message-ID: <20140202145427.GB3157@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 01, 2014 at 05:38:41PM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 02:31:11PM +0100, Maxime Ripard wrote:
> > On Fri, Jan 31, 2014 at 12:12:15PM +0000, Mark Brown wrote:
> 
> > > This seems confusing - the idea here is that if we've handed the
> > > device off to the managed function then the managed function
> > > deals with destroying it.  Note that spi_alloc_master() says
> > > that the put is only required after errors adding the device
> > > (which would be the expected behaviour if you look at other
> > > APIs).  Looking at the code I think there is an issue here but
> > > I'm not at all clear that this is the best fix.
> 
> > Ah, right, spi_master_put doesn't free the memory either...
> 
> The memory is freed by the driver core calling the
> spi_master_release() callback when it's safe to do so (after the
> last reference to the device has gone away).
> 
> > I guess we have a few choices here, either:
> >   - Add a devm_kzalloc to spi_alloc_master, since most of the drivers
> >     I've been looking at fail to free the memory, this would be the
> >     least intrusive solution. We'd still have to remove all the kfree
> >     calls in the driver that rightfully free the memory.
> >   - Make devm_unregister_master also call kfree on the master
> >   - Add a kfree to my devm_put_master so that the memory is reclaimed,
> >     which isn't the case for now.
> 
> > I don't have a strong preference here, maybe for the third one, since
> > it makes obvious that it's managed and you don't have to do anything
> > about it, while the other do not.
> 
> None of the above, definitely nothing to do with calling kfree() once
> the device is registered.  We already have that free, it's not the
> issue.  The issue is making sure that we hold references when we need
> them and drop them when we don't.  I (or someone) needs to sit down and
> think it through since things are a bit confused in the code.

Ok. I'll drop the patches and repost the A31 SPI patches.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140202/2205cab3/attachment.sig>
