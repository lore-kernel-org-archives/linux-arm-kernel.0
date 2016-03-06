From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 6 Mar 2016 21:43:25 +0100
Subject: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized variable access
In-Reply-To: <20160305145400.GF19428@n2100.arm.linux.org.uk>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
 <20160305145400.GF19428@n2100.arm.linux.org.uk>
Message-ID: <201603062143.25158.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 March 2016, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2016 at 06:07:32PM +0100, Arnd Bergmann wrote:
> > gcc warns about the possibilty of accessing a property read from
> > devicetree in cs35l32_i2c_probe() when it has not been initialized
> > because CONFIG_OF is disabled:
> > 
> > sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
> > sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > The code is actually correct because it checks the dev->of_node
> > variable first and we know this is NULL here, but by adding a
> > check for IS_ENABLED(CONFIG_OF), we can let the compiler know
> > as well, and also generate smaller object code.
> 
> No, the code is buggy, and the compiler is very correct in warning about
> it.

...
> 
> Note that 'out_values' is not written to if of_find_property_value_of_size()
> returns an error.  Therefore, if cirrus,boost-manager is missing, the
> resulting value of 'val' is left uninitialised.

You are right, this is an actual bug in the driver, and my patch just
hides it. Interestingly, this is not the case that the warning was about,
as we get the warning only when CONFIG_OF is disabled and the code
is correct (because dev->of_node is guaranteed to be NULL), but we
don't get the warning when CONFIG_OF is enabled and we can actually
run into the problem.

Fixing the driver to have correct error handling on the property
functions will make the warning go away and fix the bug you pointed
out, so we should definitely do that and drop my patch.

	Arnd
