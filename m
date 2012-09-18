From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Tue, 18 Sep 2012 21:25:29 +0000
Subject: [RFC PATCH 00/10] Use common clk drivers for DaVinci
In-Reply-To: <1347993342-6099-1-git-send-email-m-karicheri2@ti.com>
References: <1347993342-6099-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041D14F3@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore the diagram which is ill formatted. Ref the pdf document instead for the clock hardware diagram.

Murali Karicheri
Software Design Engineer


>> -----Original Message-----
>> From: Karicheri, Muralidharan
>> Sent: Tuesday, September 18, 2012 2:36 PM
>> To: Nori, Sekhar; Hilman, Kevin; linux at arm.linux.org.uk; sshtylyov at mvista.com;
>> davinci-linux-open-source at linux.davincidsp.com; linux-arm-kernel at lists.infradead.org;
>> mturquette at linaro.org; arnd at arndb.de
>> Cc: Chemparathy, Cyril; Karicheri, Muralidharan
>> Subject: [RFC PATCH 00/10] Use common clk drivers for DaVinci
>> 
>> This is the RFC patch for implementing clock tree for DaVinci SoCs using
>> common clk framework.  Currently arch/arm/mach-davinci/clock.c and
>> arch/arm/mach-davinci/psc.c implements clock drivers for DaVinci. This
>> patch makes these code obsolete and migrate the SoC code to use the common
>> clk based drivers and initialization. This adds two clk drivers specific
>> to DaVinci and Keystone (found in c6x arch such as C6678) devices. Some
>> of the existing clk drivers such as clk-fixed-rate, clk-divider, and
>> clk-mux are re-used in addition to the DaVinci specific drivers to
>> initialize the clock tree for the SoCs. The figure below is provided
>> to help understand the hardware and the code implemented in this patch and
>> more details can be found in SoC specific documentation from Texas
>> Instruments. The figure below is borrowed from chapter 6 of
>> http://www.ti.com/lit/ug/sprue14c/sprue14c.pdf
>> 
>>             |-------|    |---------|       |-------|    |--------|
>>  CLKIN -----|       |    | PLL     |       |       |    |PLLDIV1 |--SYSCLK1
>>             | MUX   |----| mult    |-------|  MUX  |----|--------|
>>  OSCIN -----|       |  | | div     |       |       | |  |--------|
>>             |-------|  | |---------|   |---|-------| ---|PLLDIV2 |--SYSCLK2
>>                 |      |               |        |    |  ----------
>>              CLKMODE   |---------------|      PLLEN  |    ...
>>                        |                             |  |--------|
>>                        |                             ---|PLLDIV5 |--SYSCLK5
>>                        |                                ----------
>>                        |----AUXCLK
>>                        |  |--------|
>>                        |--| BPDIV  |---SYSCLKBP
>>                           |--------|
>> 
>>                   Main PLL1 structure in DM644x
>> 
>> There are two Main PLLs in DM644x. PLL1 and PLL2. Each of these generate
>> different clocks in the DM device through PLL dividers. Figure above shows this
>> for PLL1. Similar hardware exists for PLL2 and the related output clocks. The
>> hardware is similar in most of the DM SoCs. Some of the recent Keystone devices
>> (c6678 under c6x architecture) include a slight variant of the PLL that
>> implemented different registers for the multipliers and dividers. All of these
>> devices include PLL dividers (PLLDIVx) and Power Sleep controllers (PSC). The
>> SoCs defines various Power Domains and Clock domains and there are PSC modules
>> that controls power and clocks to various hardware IPs of the SoC.
>> 
>> Following drivers are used for various clock hardware blocks:-
>> 
>> CLKIN and OSCIN - clk-fixed-rate (existing driver)
>> MUX - clk-mux (existing driver)
>> PLLDIVx - clk-divider (existing driver)
>> PLL mult/div - clk-davinci-pll (new driver)
>>                clk-keystone-pll (new driver)
>> PSC - clk-davinci-psc.c (new driver
>> 
>> The patch series is split in two:- patch 1-5 for drivers and 6-10 for machine
>> specific code. Please note that initially only DM644x is supported. The idea
>> is to review the initial patch and get a feedback on the overall structure of
>> the code organization. The other SoCs will be added in subsequent patch
>> revisions. The driver code implements the features needed to support DM644x
>> and is expected to be enhanced in subsequent patch revisions to support
>> additional SoCs. I have boot tested this on DM6446 EVM I have. Also verified
>> reboot command works and the clock rates are set as before. The patches depends
>> on the following patches that I had sent for review earlier:
>> 
>> davinci spi driver preparation @
>> https://patchwork.kernel.org/patch/1389321/
>> davinci watchdog driver preparation @
>> https://lkml.org/lkml/2012/9/7/634
>> davinci nand driver preparation @
>> https://lkml.org/lkml/2012/9/7/635
>> davinci i2c driver preparation @
>> https://patchwork.kernel.org/patch/1388841/
>> davinci gpio driver preparation @
>> https://lkml.org/lkml/2012/8/31/341
>> 
>> [RFC - PATCH] base:pm: prepare driver for common clock framework
>> in the davinci mailing list
>> 
>> Following are to be discussed as part of this patch review.
>> 
>>  1. arch/arm/pm.c. This is configuring PLL controller registers for suspend and
>>     resume. It appears that we need to move this code to clk-davinci-pll.c. But
>>     I can't find APIs for suspend and resume in the common clk framework. How
>>     is this expected to work? Currently i have kept the code ASIS.
>> 
>>  2. There are usecount=1 in the old clock implementation for dsp, vicp and timer2
>>     clocks. CLK_IGNORE_UNUSED flag is used currently to implement the same as
>>     disabling these unused clocks causes issues in boot up,
>> 
>> NOTE: I am doing this work as a background activity and hence the progress will be
>> slow. Please volunteer to help me in this effort by offering to test or migrating
>> other devices to this framework.
>> 
>> Murali Karicheri (10):
>>   clk:davinci - add Main PLL clock driver
>>   clk:davinci - add PSC clock driver
>>   clk:keystone - add Main PLL clock driver
>>   clk:davinci - common clk driver initialization
>>   clk:davinci - add build infrastructure
>>   ARM:davinci - restructure header files for common clk migration
>>   ARM:davinci - adding new type for cpu_clks in soc_info
>>   ARM:davinci - migrating to use davinci_common_clk_init
>>   ARM:davinci - update the dm644x soc code to use common clk drivers
>>   ARM:davinci - switch to common clk framework
>> 
>>  arch/arm/Kconfig                               |    1 +
>>  arch/arm/mach-davinci/Kconfig                  |    2 +
>>  arch/arm/mach-davinci/Makefile                 |    9 +
>>  arch/arm/mach-davinci/common.c                 |    6 +
>>  arch/arm/mach-davinci/devices.c                |    2 +
>>  arch/arm/mach-davinci/dm644x.c                 |  301
>> +++++++++++++++++++++++-
>>  arch/arm/mach-davinci/include/mach/common.h    |    5 +
>>  arch/arm/mach-davinci/include/mach/pll.h       |   81 +++++++
>>  arch/arm/mach-davinci/include/mach/psc.h       |    2 +
>>  arch/arm/mach-davinci/include/mach/time.h      |    4 +-
>>  arch/arm/mach-davinci/pm.c                     |    4 +
>>  arch/arm/mach-davinci/sleep.S                  |    5 +
>>  arch/arm/mach-davinci/time.c                   |   13 +
>>  drivers/clk/Kconfig                            |    2 +
>>  drivers/clk/Makefile                           |    2 +
>>  drivers/clk/davinci/Kconfig                    |   42 ++++
>>  drivers/clk/davinci/Makefile                   |    3 +
>>  drivers/clk/davinci/clk-davinci-pll.c          |  128 ++++++++++
>>  drivers/clk/davinci/clk-davinci-psc.c          |  197 ++++++++++++++++
>>  drivers/clk/davinci/davinci-clock.c            |  210 +++++++++++++++++
>>  drivers/clk/keystone/Kconfig                   |    6 +
>>  drivers/clk/keystone/Makefile                  |    1 +
>>  drivers/clk/keystone/clk-keystone-pll.c        |   94 ++++++++
>>  include/linux/platform_data/clk-davinci-pll.h  |   52 ++++
>>  include/linux/platform_data/clk-davinci-psc.h  |   53 +++++
>>  include/linux/platform_data/clk-keystone-pll.h |   34 +++
>>  include/linux/platform_data/davinci-clock.h    |  125 ++++++++++
>>  27 files changed, 1382 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/mach-davinci/include/mach/pll.h
>>  create mode 100644 drivers/clk/davinci/Kconfig
>>  create mode 100644 drivers/clk/davinci/Makefile
>>  create mode 100644 drivers/clk/davinci/clk-davinci-pll.c
>>  create mode 100644 drivers/clk/davinci/clk-davinci-psc.c
>>  create mode 100644 drivers/clk/davinci/davinci-clock.c
>>  create mode 100644 drivers/clk/keystone/Kconfig
>>  create mode 100644 drivers/clk/keystone/Makefile
>>  create mode 100644 drivers/clk/keystone/clk-keystone-pll.c
>>  create mode 100644 include/linux/platform_data/clk-davinci-pll.h
>>  create mode 100644 include/linux/platform_data/clk-davinci-psc.h
>>  create mode 100644 include/linux/platform_data/clk-keystone-pll.h
>>  create mode 100644 include/linux/platform_data/davinci-clock.h
>> 
>> --
>> 1.7.9.5
