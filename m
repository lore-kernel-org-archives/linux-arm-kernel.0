From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sat, 18 Feb 2012 23:43:06 +0200
Subject: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
In-Reply-To: <1329320246-1548-1-git-send-email-peter.ujfalusi@ti.com>
References: <1329320246-1548-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <CANOLnONVm47DmMv8MdU1Y_Nx-387SZ5MBHwjO4cxkQ_caJ5dWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 5:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Comments, testers are welcome...

Tried these on current mainline and they break sound on pandora:
# aplay /dev/urandom
Playing raw data '/dev/urandom' : Unsigned 8 bit, Rate 8000 Hz, Mono
[   81.306304] omap-mcbsp: clks: could not clk_set_parent() to pad_fck
[   81.313110] ASoC omap3pandora: can't set cpu system clock
[   81.319244] asoc: machine hw_params failed
aplay: set_params:1022: Unable to install hw params:

I've retried without these patches to confirm it works like that, and it did.

>
> CC-ing Samuel as well since he is the original author of the plat-omap/mcbsp.c
> driver.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (11):
> ?ARM: OMAP: mcbsp: Convert core driver to proper platform driver
> ?OMAP: mcbsp: Move core driver under sound/soc/omap
> ?ASoC: OMAP: McBSP: Consolidate plat/mcbsp.h content
> ?ASoC: core - Add API call to register dai kcontrols.
> ?ASoC: omap-mcbsp: Create a single driver for McBSP
> ?ARM: OMAP: Do not register omap-mcbsp-dai device
> ?ASoC: OMAP: mcbsp.h: Clean up bit definitions
> ?ASoC: OMAP McBSP: Remove redundant accessors
> ?ASoC: omap-mcbsp: Cleanup of module probe/remove code
> ?ASoC: omap-mcbsp: Merge the omap_mcbsp_data into omap_mcbsp structure
> ?ASoC: omap-mcbsp: Simplify DMA configuration
>
> ?arch/arm/mach-omap1/devices.c ? ? ? ? ? ? ? ? ?| ? ?9 -
> ?arch/arm/mach-omap1/mcbsp.c ? ? ? ? ? ? ? ? ? ?| ? 14 +-
> ?arch/arm/mach-omap2/devices.c ? ? ? ? ? ? ? ? ?| ? 22 --
> ?arch/arm/mach-omap2/mcbsp.c ? ? ? ? ? ? ? ? ? ?| ? ?8 +-
> ?arch/arm/plat-omap/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?8 -
> ?arch/arm/plat-omap/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?2 -
> ?arch/arm/plat-omap/include/plat/mcbsp.h ? ? ? ?| ?321 ----------------
> ?include/sound/soc.h ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?sound/soc/omap/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? | ? ?4 +
> ?sound/soc/omap/Makefile ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?sound/soc/omap/am3517evm.c ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?sound/soc/omap/ams-delta.c ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?sound/soc/omap/igep0020.c ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?{arch/arm/plat-omap => sound/soc/omap}/mcbsp.c | ?463 ++++--------------------
> ?sound/soc/omap/mcbsp.h ? ? ? ? ? ? ? ? ? ? ? ? | ?337 +++++++++++++++++
> ?sound/soc/omap/n810.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?sound/soc/omap/omap-mcbsp.c ? ? ? ? ? ? ? ? ? ?| ?287 ++++++++-------
> ?sound/soc/omap/omap-mcbsp.h ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?sound/soc/omap/omap-pcm.h ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?sound/soc/omap/omap3beagle.c ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?sound/soc/omap/omap3evm.c ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?sound/soc/omap/omap3pandora.c ? ? ? ? ? ? ? ? ?| ? ?4 +-
> ?sound/soc/omap/osk5912.c ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?sound/soc/omap/overo.c ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?sound/soc/omap/rx51.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?4 +-
> ?sound/soc/omap/sdp3430.c ? ? ? ? ? ? ? ? ? ? ? | ? ?4 +-
> ?sound/soc/omap/zoom2.c ? ? ? ? ? ? ? ? ? ? ? ? | ? ?4 +-
> ?sound/soc/soc-core.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 31 ++
> ?28 files changed, 631 insertions(+), 914 deletions(-)
> ?rename {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c (69%)
> ?create mode 100644 sound/soc/omap/mcbsp.h
>
> --
> 1.7.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html

-- 
Gra?vydas
