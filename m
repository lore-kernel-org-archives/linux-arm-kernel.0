From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 09 Jan 2014 15:47:23 +0000
Subject: [RFC 06/18] regmap: Formalise use of non-bus context
In-Reply-To: <20140109133456.GN31886@sirena.org.uk>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-7-git-send-email-pawel.moll@arm.com>
 <20131224124538.GZ30815@sirena.org.uk> <1389272911.23721.49.camel@hornet>
 <20140109133456.GN31886@sirena.org.uk>
Message-ID: <1389282443.23721.51.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-09 at 13:34 +0000, Mark Brown wrote:
> > First of all, it's just a generalization of the free_context already
> > existing in regmap_bus (and used by regmap-mmio). And in case of this
> > series it is being used to release extra resource added allocated for a
> > "busless" regmap_config. Briefly, I'm using devm_regmap_init() to
> > "attach" a custom regmap configuration to a device when it is being
> > created (which is then dev_get_regmap()-ed in the driver, as you saw in
> > the regulator patch) and its context is a pointer to kzallocated data.
> > free_context is used to release it when devm resource is being removed.
> 
> > Does it make any sense?
> 
> To be honest not really - the above sounds like you should've allocated
> the memory using devm_kzalloc() or just embedding the allocated data in
> the driver data for the parent.  Internal things need to clean up after
> themselves but users should already have a larger context of some kind.

I've started with regmap_bus so the free_context did fit well like in
regmap-mmio, but you're right - with the current approach I should be
able to simply use devm_kzalloc(). I'll give it a try and if it works,
I'll drop this patch completely.

Pawe?
