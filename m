From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 7 Sep 2011 21:12:31 +0200
Subject: [PATCH 00/22] OMAP: voltage cleanup part A
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Message-ID: <CAORVsuVQQof_LwLQepJiEqRdJmHwL_8aBwxAxrsT=9LBR-ouew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> This is the first phase of the OMAP voltage layer cleanup. ?The
> primary goal is to cleanup/reorganize data structures to facilitate
> splitting apart the voltage processor (VP) and voltage controller (VC)
> into separate layers.
>
> Based on v3.1-rc3
>
> Series available in branch pm-wip/voltdm_a in my linux-omap-pm tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git


Some comments have been sent on this patch set, otherwise OK after review.

FWIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
> Benoit Cousson (1):
> ?OMAP4: powerdomain data: add voltage domains
>
> Kevin Hilman (21):
> ?OMAP2+: hwmod: remove unused voltagedomain pointer
> ?OMAP2+: voltage: move PRCM mod offets into VC/VP structures
> ?OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
> ?OMAP2+: voltage: start towards a new voltagedomain layer
> ?OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
> ?OMAP3: voltagedomain data: add wakeup domain
> ?OMAP3+: voltage: add scalable flag to voltagedomain
> ?OMAP2+: powerdomain: add voltagedomain to struct powerdomain
> ?OMAP2: add voltage domains and connect to powerdomains
> ?OMAP3: powerdomain data: add voltage domains
> ?OMAP2+: powerdomain: add voltage domain lookup during register
> ?OMAP2+: voltage: keep track of powerdomains in each voltagedomain
> ?OMAP2+: voltage: split voltage controller (VC) code into dedicated
> ? ?layer
> ?OMAP2+: voltage: move VC into struct voltagedomain, misc. renames
> ?OMAP2+: voltage: enable VC bypass scale method when VC is initialized
> ?OMAP2+: voltage: split out voltage processor (VP) code into new layer
> ?OMAP2+: VC: support PMICs with separate voltage and command registers
> ?OMAP2+: add PRM VP functions for checking/clearing VP TX done status
> ?OMAP3+ VP: replace transaction done check/clear with VP ops
> ?OMAP2+: PRM: add register access functions for VC/VP
> ?OMAP3+: voltage: convert to PRM register access functions
>
> ?arch/arm/mach-omap2/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?5 +-
> ?arch/arm/mach-omap2/io.c ? ? ? ? ? ? ? ? ? ? ? ? | ? ?5 +
> ?arch/arm/mach-omap2/omap_hwmod_3xxx_data.c ? ? ? | ? ?4 +-
> ?arch/arm/mach-omap2/omap_twl.c ? ? ? ? ? ? ? ? ? | ? 20 +-
> ?arch/arm/mach-omap2/pm.c ? ? ? ? ? ? ? ? ? ? ? ? | ? ?4 +-
> ?arch/arm/mach-omap2/powerdomain.c ? ? ? ? ? ? ? ?| ? 23 +
> ?arch/arm/mach-omap2/powerdomain.h ? ? ? ? ? ? ? ?| ? 10 +
> ?arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c | ? ?2 +
> ?arch/arm/mach-omap2/powerdomains2xxx_data.c ? ? ?| ? ?4 +
> ?arch/arm/mach-omap2/powerdomains3xxx_data.c ? ? ?| ? 16 +
> ?arch/arm/mach-omap2/powerdomains44xx_data.c ? ? ?| ? 16 +
> ?arch/arm/mach-omap2/prm2xxx_3xxx.c ? ? ? ? ? ? ? | ? 56 ++
> ?arch/arm/mach-omap2/prm2xxx_3xxx.h ? ? ? ? ? ? ? | ? 12 +
> ?arch/arm/mach-omap2/prm44xx.c ? ? ? ? ? ? ? ? ? ?| ? 71 ++
> ?arch/arm/mach-omap2/prm44xx.h ? ? ? ? ? ? ? ? ? ?| ? 12 +
> ?arch/arm/mach-omap2/sr_device.c ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/vc.c ? ? ? ? ? ? ? ? ? ? ? ? | ?259 +++++++
> ?arch/arm/mach-omap2/vc.h ? ? ? ? ? ? ? ? ? ? ? ? | ? 34 +-
> ?arch/arm/mach-omap2/vc3xxx_data.c ? ? ? ? ? ? ? ?| ? 10 +-
> ?arch/arm/mach-omap2/vc44xx_data.c ? ? ? ? ? ? ? ?| ? 14 +-
> ?arch/arm/mach-omap2/voltage.c ? ? ? ? ? ? ? ? ? ?| ?889 +++++-----------------
> ?arch/arm/mach-omap2/voltage.h ? ? ? ? ? ? ? ? ? ?| ? 61 +-
> ?arch/arm/mach-omap2/voltagedomains2xxx_data.c ? ?| ? 32 +
> ?arch/arm/mach-omap2/voltagedomains3xxx_data.c ? ?| ? 53 +-
> ?arch/arm/mach-omap2/voltagedomains44xx_data.c ? ?| ? 69 +-
> ?arch/arm/mach-omap2/vp.c ? ? ? ? ? ? ? ? ? ? ? ? | ?367 +++++++++
> ?arch/arm/mach-omap2/vp.h ? ? ? ? ? ? ? ? ? ? ? ? | ? 45 +-
> ?arch/arm/mach-omap2/vp3xxx_data.c ? ? ? ? ? ? ? ?| ? 21 +-
> ?arch/arm/mach-omap2/vp44xx_data.c ? ? ? ? ? ? ? ?| ? 28 +-
> ?arch/arm/plat-omap/include/plat/omap_hwmod.h ? ? | ? ?1 -
> ?30 files changed, 1281 insertions(+), 864 deletions(-)
> ?create mode 100644 arch/arm/mach-omap2/vc.c
> ?create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
> ?create mode 100644 arch/arm/mach-omap2/vp.c
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
