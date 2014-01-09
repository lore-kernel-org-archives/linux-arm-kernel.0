From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jan 2014 13:34:56 +0000
Subject: [RFC 06/18] regmap: Formalise use of non-bus context
In-Reply-To: <1389272911.23721.49.camel@hornet>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-7-git-send-email-pawel.moll@arm.com>
 <20131224124538.GZ30815@sirena.org.uk>
 <1389272911.23721.49.camel@hornet>
Message-ID: <20140109133456.GN31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 01:08:31PM +0000, Pawel Moll wrote:
> On Tue, 2013-12-24 at 12:45 +0000, Mark Brown wrote:

> > The obvious question here is why is this callback useful
> > - what is being allocated in a regmap specific context that needs to be
> > lifetime managed separately to the thing doing the creation?  I can't
> > see any obvious reason why this would ever get used.

> First of all, it's just a generalization of the free_context already
> existing in regmap_bus (and used by regmap-mmio). And in case of this
> series it is being used to release extra resource added allocated for a
> "busless" regmap_config. Briefly, I'm using devm_regmap_init() to
> "attach" a custom regmap configuration to a device when it is being
> created (which is then dev_get_regmap()-ed in the driver, as you saw in
> the regulator patch) and its context is a pointer to kzallocated data.
> free_context is used to release it when devm resource is being removed.

> Does it make any sense?

To be honest not really - the above sounds like you should've allocated
the memory using devm_kzalloc() or just embedding the allocated data in
the driver data for the parent.  Internal things need to clean up after
themselves but users should already have a larger context of some kind.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/dd74d83e/attachment.sig>
