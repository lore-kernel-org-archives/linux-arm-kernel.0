From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 03 Aug 2011 08:20:56 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110803052333.GA16141@opensource.wolfsonmicro.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<s5h4o1zsn6o.wl%tiwai@suse.de>
	<20110803052333.GA16141@opensource.wolfsonmicro.com>
Message-ID: <s5hvcufqalz.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 3 Aug 2011 14:23:35 +0900,
Mark Brown wrote:
> 
> On Tue, Aug 02, 2011 at 08:06:23PM +0200, Takashi Iwai wrote:
> 
> > example.  So, alternatively, we can put the condition in some generic
> > filter function like readable/writeble things.
> 
> Yes, I suggested that already, these are just unreadable and unwritable
> registers :/

BTW, looking through snd_soc_get_reg_access_index() for *_readable() & 
co , I wonder what would be the merit of using rbtree if this kind of
indexed array is present. If the actual value is also kept in that
array, we can drop the whole complex stuff like rbtree and lzo.

In addition, the default values aren't necessary to be in a flat array
form at all.  What we need is a copy function to expand the data
appropriately to reg_def_copy.
Or, we can consider dropping the flat reg_def_copy since it's just
wasteful to keep the flat array for all types unconditionally, but let
the codec driver provide an iterator and an look-up or such.


thanks,

Takashi
