From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 23:31:15 +0100
Subject: [PATCH v3 0/5] Add SMP bringup support for mt65xx socs
In-Reply-To: <4831607.pyCH8elj8i@ubix>
References: <1436851111-2369-1-git-send-email-yingjoe.chen@mediatek.com>
 <4831607.pyCH8elj8i@ubix>
Message-ID: <20150805223115.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 08:44:11PM +0200, Matthias Brugger wrote:
> On Tuesday, July 14, 2015 01:18:26 PM Yingjoe Chen wrote:
> > This series add SMP brinup support for MediaTek SoCs. This is based
> > on v4.2-rc1 and Matthias' next branch (for dts parts).
> > 
> > There are similar but different SMP bringup up methods on MediaTek
> > mt65xx and mt81xx. On MT8135 & MT8127, system boots with a trustzone
> > firmware. Others, like MT6589, doesn't have trustzone, and run kernel
> > directly in secure world.
> > 
> > Patch 1 enable arch timer support.
> > Patch 2,3 add support for cpu enable-method "mediatek,mt6589-smp" and
> > "mediatek,mt81xx-tz-smp", which support Mediatek SMP bringup for non-TZ
> > and TZ platform.
> > Patch 4,5 finally enable SMP bringup for mt8135 and mt8127.
> > 
> > Changes in v3:
> > - The first 2 patches in v2 are merged in v4.2-rc1.
> > - Patch 3~4 in v2 are moved to another series [1]
> > - platsmp.c changes based on Stephen's suggestion
> > - Change cpu enable-method name to "mediatek,mt6589-smp"
> > 
> > Changes in v2:
> > - Fix boot issue for THUMB2 kernel.
> > - Not enable GPT_CLK_EVT when setup to fix GPT spurious interrupt issue
> > - Change platsmp.c according to Matthias' suggestion
> > http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000714.html
> > 
> > v1:
> > http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000528.html
> > 
> > [1]
> > http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001544.html
> > 
> > Matthias Brugger (1):
> >   ARM: mediatek: enable gpt6 on boot up to make arch timer working
> > 
> > Yingjoe Chen (4):
> >   devicetree: bindings: add new SMP enable method Mediatek SoC
> >   ARM: mediatek: add smp bringup code
> >   ARM: dts: mt8135: enable basic SMP bringup for mt8135
> >   ARM: dts: mt8127: enable basic SMP bringup for mt8127
> > 
> >  Documentation/devicetree/bindings/arm/cpus.txt |   2 +
> >  arch/arm/boot/dts/mt8127.dtsi                  |  16 +++
> >  arch/arm/boot/dts/mt8135.dtsi                  |  16 +++
> >  arch/arm/mach-mediatek/Makefile                |   3 +
> >  arch/arm/mach-mediatek/mediatek.c              |  27 +++++
> >  arch/arm/mach-mediatek/platsmp.c               | 144
> > +++++++++++++++++++++++++ 6 files changed, 208 insertions(+)
> >  create mode 100644 arch/arm/mach-mediatek/platsmp.c
> 
> Applied to v4.2-next/soc-2 and v4.2-next/dts-2 

I've just NAK'd one of the patches in this set; I don't tend to even see
mediatek patches normally, as they all head into my junk mailfolder
because mediatek's mail server setup is truely abysmal (it has broken
reverse DNS - the DNS positively says that the mail server is not a
legit owner of the name it claims to be.)

The problem is that this patch series uses memblock_reserve() way after
the memory has been transitioned out of memblock's control, so actually
this has no effect.

I've seen a number of patches doing this.  I'm not sure what's soo friggin
hard for people to understand: memblock is about the EARLY stages of
getting the system up and running.  Once the memory has been handed
over to the kernel's memory management, memblock MUST NOT BE USED to
reserve memory.

There is one place, and one place only in the ARM kernel where
memblock_reserve() is possible, and that's in the ->reserve machine
callback.  NOWHERE ELSE is permissible.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
