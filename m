From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 15:38:36 -0700
Subject: [PATCH 17/31] ASoC: tegra: call pm_runtime APIs around register
 accesses
In-Reply-To: <20131118183947.GS2674@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
 <20131116100205.GG15393@sirena.org.uk> <528A4D9A.10809@wwwdotorg.org>
 <20131118183947.GS2674@sirena.org.uk>
Message-ID: <528A96EC.4040409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 11:39 AM, Mark Brown wrote:
> On Mon, Nov 18, 2013 at 10:25:46AM -0700, Stephen Warren wrote:
>> On 11/16/2013 03:02 AM, Mark Brown wrote:
> 
>>> Or alternatively should the driver be making the device cache
>>> only when runtime PM is disabled?
> 
>> The regmap is already cache-only when runtime-suspended. However
>> the registers don't get flushed during resume. I suppose that
>> would require only adding one extra call to the PM resume
>> function?
> 
> Yup, should probably do that anyway since that's going to bite
> someone otherwise.  We probably want a single operation to flush
> and enable writes now I think about it, it's the common case.
> 
>> For some reason, my gut prefers this current solution, but I
>> could be persuaded.
> 
> I'm not dead set against doing it this way, it's just that it feels
> like if it's required something's not working as well as it
> should.

The problems with the following approach:

 static int tegra30_ahub_runtime_resume(struct device *dev)
 ...
 	regcache_cache_only(ahub->regmap_apbif, false);
 	regcache_cache_only(ahub->regmap_ahub, false);
+	regcache_sync(ahub->regmap_apbif, false);
+	regcache_sync(ahub->regmap_ahub, false);

(or an automated variant of it, whereby regmap automatically does the
sync inside cache_only(false)) are:

1) regcache_sync() doesn't mean "if the cache is dirty, flush the
dirty registers to HW", but rather, "if the cache is dirty, write any
registers that don't match HW defaults to HW". If the HW was in
cache-only mode because simply because clocks were turned off but not
power, then the register values were retained, and the current HW
register values may not be "HW defaults", and you may in fact /need/
to write a value to HW that matches the HW default, yet is different
from the current retained register content.

2) tegra30_ahub_allocate_tx_fifo() does a read-modify-write of a
control register, and may execute when cache_only(true). If that
register was never touched while cache_only(false), which is the case
the first time the r-m-w happens, then there is no cached value, so
the regmap_read() for it will fail. This will either cause
tegra30_ahub_allocate_tx_fifo() to use uninitialized return data from
regmap_read() (if error-checking is missing, which it is), or fail (if
the error-checking were present). Neither is a good choice. Possible
solutions are:

a) Make regmap creation read the initial HW state to use as HW
defaults when the regmap is created. IIRC, this is done for some
regmap configurations but not others. That said, this doesn't seem
correct, since there's no guarantee that the HW state when the regmap
is created /is/ the default HW state.

b) Add a table of HW register defaults. Aside from this issue, there's
no need for this, so I'm not really motivated to do this. Besides, the
number of registers is rather large.

c) Simply put pm_runtime_get()/put() around the body of
tegra30_ahub_allocate_tx_fifo(), which works fine, and was my original
patch.

d) Have regmap_read/write do a pm_runtime_get()/put() themselves. I
know you mentioned this earlier in the thread, but you'd rejected this
approach when I first upstreamed this AHUB driver, and said to rely on
cache_only instead.

I think I still prefer option (c).
