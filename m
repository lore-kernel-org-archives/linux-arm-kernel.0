From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Jul 2011 01:55:04 -0700
Subject: [PATCH] OMAP: hwmod: add kernel cmdline flag to avoid
	resetting IP blocks during init
In-Reply-To: <20110703010206.19046.85293.stgit@dusk>
References: <20110703010204.19046.85186.stgit@dusk>
	<20110703010206.19046.85293.stgit@dusk>
Message-ID: <20110704085503.GQ23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110702 17:58]:
> On some boards, it's not possible to reset certain IP blocks during
> kernel initialization.  Some boards connect GPIO lines to external
> voltage controllers, so resetting them may cause voltage to drop on a
> critical supply[1].  Other boards connect GPIO lines to reset pins on
> external devices without open documentation, so if the GPIO blocks are
> reset, the external devices cannot currently be reconfigured[2].
> 
> The correct way to fix these issues on OMAP is to add a
> hwmod_no_setup_reset(hwmod) call to the board file, that references
> the IP block that must preserve its state.  This allows the OMAP core
> code to reset the remaining IP blocks.
> 
> However, during initial bring-up of a new board, it may be desirable
> to not reset any IP block, for ease of debugging.  This patch adds a
> kernel command line parameter, 'hwmod_no_setup_reset', that prevents
> the OMAP hwmod code from resetting any IP block during init.
> 
> 1. Nayak, Rajendra.  _[PATCH 7/7] 4460sdp/blaze/panda: hwmod: Prevent
>    gpio1 reset during hwmod init_.  1 July 2011.  E-mail to the
>    linux-omap at vger.kernel.org mailing list.  Retrieved from
>    http://www.mail-archive.com/linux-omap at vger.kernel.org/msg51992.html
> 
> 2. Buesch, Michael.  _Nokia n810 LCD (MIPID/blizzard) on 2.6.38_.  28
>    Feb 2011.  E-mail to the linux-omap at vger.kernel.org mailing list.
>    Retrieved from http://www.spinics.net/lists/linux-omap/msg47277.html

Also related is the gptimer12 on secure omaps as reported by Aaro.
 
> +	hwmod_no_setup_reset
> +			[OMAP] During kernel initialization,
> +			prevent the subarchitecture code from resetting
> +			IP blocks before the driver loads.  Useful for
> +			initial bring-up of boards which require some
> +			bootloader configuration to be retained on GPIO or
> +			other IP blocks.
> +

How about just make it hwmod_reset=1 with 0 being the default value
for now?

Regards,

Tony
