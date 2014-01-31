From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 14:31:11 +0100
Subject: [PATCH 0/3] spi: core: Introduce devm_spi_alloc_master
In-Reply-To: <20140131121215.GB22609@sirena.org.uk>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140131121215.GB22609@sirena.org.uk>
Message-ID: <20140131133111.GF2950@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 12:12:15PM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 11:23:09AM +0100, Maxime Ripard wrote:
> 
> > This patchset introduces a devm_spi_alloc_master to the spi core. While most of
> > the drivers have a spi_master_put call in the probe, a lot of them using the
> > devm_spi_register_master function are missing it in the remove function,
> > leading to leaked resources.
> 
> This seems confusing - the idea here is that if we've handed the device
> off to the managed function then the managed function deals with
> destroying it.  Note that spi_alloc_master() says that the put is only
> required after errors adding the device (which would be the expected
> behaviour if you look at other APIs).  Looking at the code I think there
> is an issue here but I'm not at all clear that this is the best fix.

Ah, right, spi_master_put doesn't free the memory either...

I guess we have a few choices here, either:
  - Add a devm_kzalloc to spi_alloc_master, since most of the drivers
    I've been looking at fail to free the memory, this would be the
    least intrusive solution. We'd still have to remove all the kfree
    calls in the driver that rightfully free the memory.
  - Make devm_unregister_master also call kfree on the master
  - Add a kfree to my devm_put_master so that the memory is reclaimed,
    which isn't the case for now.

I don't have a strong preference here, maybe for the third one, since
it makes obvious that it's managed and you don't have to do anything
about it, while the other do not.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/a8aa0f8d/attachment.sig>
