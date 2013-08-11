From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Aug 2013 16:17:07 -0700
Subject: [GIT PULL] Samsung PWM support cleanup
In-Reply-To: <2197909.dzUDYPGiF0@flatron>
References: <3573853.gDiLaTfgOu@flatron> <520173EF.1040808@samsung.com>
 <2197909.dzUDYPGiF0@flatron>
Message-ID: <20130811231707.GF26757@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 02:16:48PM +0200, Tomasz Figa wrote:
> Hi Kukjin,
> 
> On Wednesday 07 of August 2013 07:08:47 Kukjin Kim wrote:
> > On 08/06/13 08:32, Tomasz Figa wrote:
> > > Hi Olof, Arnd,
> > > 
> > > Here is the Samsung PWM cleanup series for you. Particular patches of
> > > the> 
> > > series involve following modifications:
> > >   1) fixing up few things in samsung_pwm_timer clocksource driver,
> > >   2) moving remaining Samsung platforms to the new clocksource driver,
> > >   3) removing old clocksource driver,
> > >   4) adding new multiplatform- and DT-aware PWM driver,
> > >   5) moving all Samsung platforms to use the new PWM driver,
> > >   6) removing old PWM driver,
> > >   7) removing all PWM-related code that is not used anymore.
> > > 
> > > This is my first pull request ever, so I hope I haven't screwed up
> > > anything. ;)
> > > 
> > > Best regards,
> > > Tomasz
> > > 
> > > The following changes since commit 
> c095ba7224d8edc71dcef0d655911399a8bd4a3f:
> > >    Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)
> > > 
> > > are available in the git repository at:
> > >    git://github.com/tom3q/linux.git v3.12-next/pwm-cleanup
> > > 
> > > for you to fetch changes up to 
> 519e8e0da7509fcc71c12bcd3a681bb62770f692:
> > >    ARM: SAMSUNG: Remove plat/regs-timer.h header (2013-08-06 01:21:55
> > >    +0200)> 
> > > ----------------------------------------------------------------
> > > 
> > > Tomasz Figa (20):
> > >        clocksource: samsung_pwm_timer: Do not request PWM mem region
> > >        clocksource: samsung_pwm_timer: Correct definition of
> > >        AUTORELOAD bit
> > >        clocksource: samsung_pwm_timer: Cache clocksource register
> > >        address
> > >        clocksource: samsung_pwm_timer: Do not use clocksource_mmio
> > >        clocksource: samsung_pwm_timer: Handle suspend/resume correctly
> > >        ARM: SAMSUNG: Unify base address definitions of timer block
> > >        ARM: SAMSUNG: Add new PWM platform device
> > >        ARM: SAMSUNG: Set PWM platform data
> > >        ARM: SAMSUNG: Move all platforms to new clocksource driver
> > >        ARM: SAMSUNG: Remove old samsung-time driver
> > >        ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
> > >        pwm: samsung: Rename to pwm-samsung-legacy
> > >        pwm: Add new pwm-samsung driver
> > >        ARM: SAMSUNG: Rework private data handling in dev-backlight
> > >        ARM: SAMSUNG: Modify board files to use new PWM platform device
> > >        pwm: Remove superseded pwm-samsung-legacy driver
> > >        ARM: SAMSUNG: Remove old PWM timer platform devices
> > >        ARM: SAMSUNG: Remove pwm-clock infrastructure
> > >        ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
> > >        ARM: SAMSUNG: Remove plat/regs-timer.h header
> > >   
> > >   arch/arm/Kconfig                                   |  11 +-
> > >   arch/arm/mach-s3c24xx/Kconfig                      |   6 -
> > >   arch/arm/mach-s3c24xx/clock-s3c2410.c              |   1 -
> > >   arch/arm/mach-s3c24xx/clock-s3c2412.c              |   1 -
> > >   arch/arm/mach-s3c24xx/clock-s3c2416.c              |   2 -
> > >   arch/arm/mach-s3c24xx/clock-s3c2443.c              |   2 -
> > >   arch/arm/mach-s3c24xx/common.c                     |  27 +
> > >   arch/arm/mach-s3c24xx/include/mach/map.h           |   2 +
> > >   arch/arm/mach-s3c24xx/mach-h1940.c                 |   4 +-
> > >   arch/arm/mach-s3c24xx/mach-rx1950.c                |   5 +-
> > >   arch/arm/mach-s3c64xx/Kconfig                      |   2 -
> > >   arch/arm/mach-s3c64xx/clock.c                      |   2 -
> > >   arch/arm/mach-s3c64xx/common.c                     |  32 +-
> > >   arch/arm/mach-s3c64xx/include/mach/irqs.h          |   8 -
> > >   arch/arm/mach-s3c64xx/include/mach/map.h           |   1 +
> > >   arch/arm/mach-s3c64xx/irq-pm.c                     |   2 -
> > >   arch/arm/mach-s3c64xx/mach-crag6410.c              |   4 +-
> > >   arch/arm/mach-s3c64xx/mach-hmt.c                   |   4 +-
> > >   arch/arm/mach-s3c64xx/mach-smartq.c                |   4 +-
> > >   arch/arm/mach-s3c64xx/mach-smdk6410.c              |   5 +-
> > >   arch/arm/mach-s5p64x0/Kconfig                      |   2 -
> > >   arch/arm/mach-s5p64x0/clock-s5p6440.c              |   2 -
> > >   arch/arm/mach-s5p64x0/clock-s5p6450.c              |   2 -
> > >   arch/arm/mach-s5p64x0/common.c                     |  27 +
> > >   arch/arm/mach-s5p64x0/include/mach/irqs.h          |   2 -
> > >   arch/arm/mach-s5p64x0/include/mach/map.h           |   1 +
> > >   arch/arm/mach-s5p64x0/mach-smdk6440.c              |   5 +-
> > >   arch/arm/mach-s5p64x0/mach-smdk6450.c              |   5 +-
> > >   arch/arm/mach-s5p64x0/pm.c                         |   3 -
> > >   arch/arm/mach-s5pc100/Kconfig                      |   1 -
> > >   arch/arm/mach-s5pc100/clock.c                      |   2 -
> > >   arch/arm/mach-s5pc100/common.c                     |  28 +
> > >   arch/arm/mach-s5pc100/include/mach/irqs.h          |   2 -
> > >   arch/arm/mach-s5pc100/include/mach/map.h           |   1 +
> > >   arch/arm/mach-s5pc100/mach-smdkc100.c              |   5 +-
> > >   arch/arm/mach-s5pv210/Kconfig                      |   1 -
> > >   arch/arm/mach-s5pv210/clock.c                      |   1 -
> > >   arch/arm/mach-s5pv210/common.c                     |  28 +
> > >   arch/arm/mach-s5pv210/include/mach/irqs.h          |   2 -
> > >   arch/arm/mach-s5pv210/include/mach/map.h           |   1 +
> > >   arch/arm/mach-s5pv210/mach-smdkv210.c              |   5 +-
> > >   arch/arm/mach-s5pv210/pm.c                         |  10 -
> > >   arch/arm/plat-samsung/Kconfig                      |  14 -
> > >   arch/arm/plat-samsung/Makefile                     |   3 -
> > >   arch/arm/plat-samsung/dev-backlight.c              |  61 +-
> > >   arch/arm/plat-samsung/devs.c                       |  42 +-
> > >   arch/arm/plat-samsung/include/plat/clock.h         |   4 -
> > >   arch/arm/plat-samsung/include/plat/devs.h          |   1 +
> > >   arch/arm/plat-samsung/include/plat/irq-vic-timer.h |  13 -
> > >   arch/arm/plat-samsung/include/plat/irqs.h          |   9 -
> > >   arch/arm/plat-samsung/include/plat/pwm-clock.h     |  81 ---
> > >   arch/arm/plat-samsung/include/plat/pwm-core.h      |  22 +
> > >   arch/arm/plat-samsung/include/plat/regs-timer.h    | 124 ----
> > >   arch/arm/plat-samsung/include/plat/samsung-time.h  |  23 -
> > >   arch/arm/plat-samsung/irq-vic-timer.c              |  98 ---
> > >   arch/arm/plat-samsung/pwm-clock.c                  | 474
> > >   --------------
> > >   arch/arm/plat-samsung/s5p-irq.c                    |   4 -
> > >   arch/arm/plat-samsung/samsung-time.c               | 394
> > >   ------------
> > >   drivers/clocksource/Kconfig                        |   1 -
> > >   drivers/clocksource/samsung_pwm_timer.c            | 108 ++--
> > >   drivers/pwm/pwm-samsung.c                          | 709
> > >   ++++++++++++++------- 61 files changed, 786 insertions(+), 1660
> > >   deletions(-)
> > >   delete mode 100644
> > >   arch/arm/plat-samsung/include/plat/irq-vic-timer.h
> > >   delete mode 100644 arch/arm/plat-samsung/include/plat/pwm-clock.h
> > >   create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h
> > >   delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h
> > >   delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
> > >   delete mode 100644 arch/arm/plat-samsung/pwm-clock.c
> > >   delete mode 100644 arch/arm/plat-samsung/samsung-time.c
> > 
> > Just note that I also have pulled into samsung tree because of
> > dependency with others, this will be pulled directly by Olof though.
> 
> Have you already pulled this into your tree? There was a patch[1] that was 
> posted for 3.11 at the time this series was merged in your for-next 
> branch, before it got dropped, that fixed one found build issue that I 
> missed.
> 
> In the end the series got dropped, that patch was not applied and I forgot 
> about this issue. This was caught by Andrew Bresticker after I already 
> sent my pull request.
> 
> According to Olof, he hasn't pulled this yet and you don't seem to have it 
> in your public tree either, so we could either drop this pull request and 
> send another one with the fixup patch squashed or apply the fixup patch 
> separately on top of this. What do you think?

I have not pulled anything from Kukjin yet, so please respin your branch as
needed, Tomasz. Also, see the reply about making a signed tag.


-Olof
