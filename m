From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 16 Jan 2014 17:20:13 +0000
Subject: [RFC 06/18] regmap: Formalise use of non-bus context
In-Reply-To: <20140116170954.C3CBCC40973@trevor.secretlab.ca>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 < 1387815830-8794-7-git-send-email-pawel.moll@arm.com>
 <20131224124538. GZ30815@sirena.org.uk> <1389272911.23721.49.camel@hornet>
 <20140116170954.C3CBCC40973@trevor.secretlab.ca>
Message-ID: <1389892813.3496.82.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-16 at 17:09 +0000, Grant Likely wrote:
> > First of all, it's just a generalization of the free_context already
> > existing in regmap_bus (and used by regmap-mmio). And in case of this
> > series it is being used to release extra resource added allocated for a
> > "busless" regmap_config. Briefly, I'm using devm_regmap_init() to
> > "attach" a custom regmap configuration to a device when it is being
> > created (which is then dev_get_regmap()-ed in the driver, as you saw in
> > the regulator patch) and its context is a pointer to kzallocated data.
> > free_context is used to release it when devm resource is being removed.
> 
> Have you thought through all the implications here? What you've
> described effectively changes the devm model. devm operates under the
> assumption that devm data only exists between probe() and remove() time.
> If you 'preload' devm data then the preloaded data will get discarded at
> remove() time which breaks if the driver is remove and probed again at
> runtime.

Uh. Right, you're correct, I've missed that (obvious) fact :-(

I will get the drivers back to "vexpress_regmap_init()" model or try to
find a way of "attaching" a regmap pointer(s?) to a struct device. If it
makes sense at all...

Pawe?
