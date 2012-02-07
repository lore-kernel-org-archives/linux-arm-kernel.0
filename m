From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 07 Feb 2012 15:39:24 +0200
Subject: [PATCH v2 2/7] MFD: twl6040: Convert to i2c driver, and separate
 it from twl core
In-Reply-To: <20120207132925.GN3332@opensource.wolfsonmicro.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
 <20120207132925.GN3332@opensource.wolfsonmicro.com>
Message-ID: <4F31298C.5090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2012 03:29 PM, Mark Brown wrote:
> and it looks like you'll save a bunch more code if you're able to
> convert over to using a regmap cache.  Note that as a first pass you
> just need to define which registers are volatile and enable a cache type
> - if defaults are omitted then the values will be read back from the
> device to start off with.

There's one thing which I need to sort out before I enable the regmap
cache for the twl6040 MFD (and remove all other caching of vibra
controls in the MFD, and from the ASoC codec driver):
In the codec driver I have one 'shadow' register which does not exist on
the HW. I'm going to need to have access to that shadow register's bits
in the future transparently.
I was wondering if we could add support to regmap for such SW only
registers. This would only make sens if the cache is enabled. We could
have a callback let's say shadow_reg() in remap_config struct. If it is
a shadow reg we never reach out for the HW and operate only on the cache.
Is this something we can add to regmap?

-- 
P?ter
