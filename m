From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 25 Jul 2015 22:17:23 +0200
Subject: [PATCH 0/7] Another posting of the Dove PMU series
In-Reply-To: <20150715185859.GC7557@n2100.arm.linux.org.uk>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
Message-ID: <20150725201723.GD604@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 07:58:59PM +0100, Russell King - ARM Linux wrote:
> What it says in the subject.  Not hopeful of a successful outcome, so I'm
> not going to bother wasting time writing stuff here.

Hi Gregory

I took at look at Russell's patches. I rebased them onto -rc1. There
were a few minor merge problems, all easy to fix. I added
Signed-off-by: since i did make changes, but 99.9% of the credit for
these patches is definitely to Russell.

The last patch, which is converting mach-dove to use the new PMU
driver however does not build. With mvebu_v7_defconfig i get:

  CC      drivers/soc/dove/pmu.o
drivers/soc/dove/pmu.c: In function dove_init_pmu_legacy?:
drivers/soc/dove/pmu.c:400:46: error: IRQ_DOVE_PMU_START undeclared (first use in this function)
   irq_domain_associate_many(pmu->irq_domain, IRQ_DOVE_PMU_START,
                                              ^
drivers/soc/dove/pmu.c:400:46: note: each undeclared identifier is reported only once for each function it appears in

and dove_defconfig:

  CC      arch/arm/mach-dove/common.o
arch/arm/mach-dove/common.c:381:15: error: PWR_VPU_PWR_DWN_MASK undeclared here (not in a function)
   .pwr_mask = PMU_PWR_VPU_PWR_DWN_MASK,
               ^
arch/arm/mach-dove/common.c:382:15: error: PMU_SW_RST_VIDEO_MASK undeclared here (not in a function)
   .rst_mask = PMU_SW_RST_VIDEO_MASK,
               ^
arch/arm/mach-dove/common.c:383:15: error: PMU_ISO_VIDEO_MASK undeclared here (not in a function)
   .iso_mask = PMU_ISO_VIDEO_MASK,
               ^
arch/arm/mach-dove/common.c:386:15: error: PMU_PWR_GPU_PWR_DWN_MASK undeclared here (not in a function)
   .pwr_mask = PMU_PWR_GPU_PWR_DWN_MASK,
               ^
arch/arm/mach-dove/common.c:387:15: error: PMU_SW_RST_GPU_MASK undeclared here (not in a function)
   .rst_mask = PMU_SW_RST_GPU_MASK,
               ^
arch/arm/mach-dove/common.c:388:15: error: PMU_ISO_GPU_MASK undeclared here (not in a function)
   .iso_mask = PMU_ISO_GPU_MASK,

So i've dropped the last patch.

I boot tested mvebu_v7_defconfig with these patches, and ran the
rtctest, which shows the RTC interrupt it working. The vpu and gpu
power domains are in /sys, but i don't have anything connected to the
HDMI port in order to test them.

You can find the patches here:

https://github.com/lunn/linux.git v4.2-rc1-dove-pmu

	  Andrew
