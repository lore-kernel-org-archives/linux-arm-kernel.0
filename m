From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 18 Nov 2010 22:29:20 -0700 (MST)
Subject: [PATCH 5/8] OMAP2+: hwmod: rename omap_hwmod_mutex to
	_hwmod_list_mutex
In-Reply-To: <4CE2C01D.8010703@ti.com>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
	<20101116101808.22777.52852.stgit@twilight.localdomain>
	<4CE2C01D.8010703@ti.com>
Message-ID: <alpine.DEB.2.00.1011182225480.7544@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

On Tue, 16 Nov 2010, Cousson, Benoit wrote:

> Funny, I was about to send you a RFC to get rid of that mutex :-)
> 
> Today that mutex is preventing us to be re-entrant during hwmod lookup and
> for_each_by_class iteration, and we'd like to in order to manage link between
> 2 hwmods.
> 
> The context is the link between mcbsp and sidetone on OMAP3. Since this module
> are tightly coupled, I was suggesting to Kishon to add the sidetone reference
> directly in the mcbsp hwmod in order to create a omap_device that will handle
> the 2 hwmods at the same time.
> 
> Since we are using the iteration to get all the hwmod that belongs to the
> mcbsp class we cannot call the lookup function to get the sidetone hwmod at
> that time.
> For the moment we need to do 2 iteration and use intermediate storage to
> workaround that.
> 
> After checking the purpose of the mutex, I was wondering if this is useful.
> For the moment the creation of the hwmod list is done only at init time, and
> nothing is supposed to change that at runtime except the unregister function.
> 
> So I've started to get rid of this function, then of the mutex and I added the
> __init to all these registration functions to avoid the usage at runtime. It
> will save a little bit of memory as well.
> 
> Thanks to that we can now use the omap_hwmod_lookup inside the
> omap_hwmod_for_each_by_class.
> 
> Does that make sense to you?
> I can send you the patches if you want.

Yep, that sounds fine to me.  I'll plan to drop the mutex rename patch 
once you send your patch to avoid the noise.  I guess that 
omap_hwmod_register() can become static also, and can be renamed to 
_register(), and we'll just use omap_hwmod_init() as the entry point to 
register hwmods.


- Paul
