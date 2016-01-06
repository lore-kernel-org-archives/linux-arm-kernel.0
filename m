From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 6 Jan 2016 18:40:40 +0100
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160105224929.GF12777@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
Message-ID: <20160106174039.GA14271@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 05, 2016 at 02:49:29PM -0800, Tony Lindgren wrote:
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
> unified the GPMC debug for the SoCs with GPMC. The commit also left
> out the option for HWMOD_INIT_NO_RESET as we now require proper timings
> for GPMC to be able to remap GPMC devices out of address 0.
> 
> Unfortunately on 900, onenand now only partially works with the device

You may want to change 900 to n900 (maybe even Nokia N900) before
actually committing this.

> tree provided timings. It works enough to get detected but the clock
> rate supported by the onenand chip gets misdetected. This in turn causes
> the GPMC timings to be miscalculated and this leads into file system
> corruption on n900.
> 
> Looks like onenand needs CS_CONFIG1 bit 27 WRITETYPE set for for sync
> write. This is needed also for async timings when we write to onenand
> with omap2_onenand_set_async_mode(). Without sync write bit set, the
> async read for the onenand ONENAND_REG_VERSION_ID will return 0xfff.
> 
> Let's exit with an error if onenand rate is not detected. And let's
> remove the extra call to omap2_onenand_set_async_mode() as we only
> need to do this once at the end of omap2_onenand_setup_async().
> 
> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/c87fc87d/attachment-0001.sig>
