From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Aug 2011 18:00:51 +0900
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <s5hvcufqalz.wl%tiwai@suse.de>
References: <65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<s5h4o1zsn6o.wl%tiwai@suse.de>
	<20110803052333.GA16141@opensource.wolfsonmicro.com>
	<s5hvcufqalz.wl%tiwai@suse.de>
Message-ID: <20110803090049.GA30782@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2011 at 08:20:56AM +0200, Takashi Iwai wrote:

> BTW, looking through snd_soc_get_reg_access_index() for *_readable() & 
> co , I wonder what would be the merit of using rbtree if this kind of
> indexed array is present. If the actual value is also kept in that
> array, we can drop the whole complex stuff like rbtree and lzo.

I agree, you may have seen me mentioning that we should just disallow
the use of advanced caches for the register maps with non-zero steps.
There's really very little benefit from them.

> In addition, the default values aren't necessary to be in a flat array
> form at all.  What we need is a copy function to expand the data
> appropriately to reg_def_copy.

Yes, we can do better here.  We do need something that's reasonably easy
to write in source code, though.  I was thinking something like an array
of:

    { reg, value }

might do the trick for the sparse devices.   Ideally all this code is
going to get pushed out into regmap too so other subsystems can use it.

> Or, we can consider dropping the flat reg_def_copy since it's just
> wasteful to keep the flat array for all types unconditionally, but let
> the codec driver provide an iterator and an look-up or such.

The purpose of that is slightly different, the idea is to let us discard
initdata while still being able to reference the defaults at runtime for
CODECs that didn't get instantiated in the system.  In order to allow
the discard to happen we need to take a copy of the defaults table when
we probe the device.
