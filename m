From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 May 2015 11:00:41 -0700
Subject: [PATCH v7 0/6] Add common clock support for Broadcom iProc
 architecture
In-Reply-To: <55511DB5.9090201@broadcom.com>
References: <1430849603-15849-1-git-send-email-rjui@broadcom.com>
 <55511DB5.9090201@broadcom.com>
Message-ID: <55539149.6050604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/15 14:23, Ray Jui wrote:
> Hi Mike,
> 
> Have you had a chance to review the iProc clock patches? If possible,
> I'd like to get feedback from you as early as possible so I can make
> changes if required. It would be really nice if we can get the iProc
> clock patches going into v4.2.
> 
> A lot of our iProc drivers depend on these clock patches.

I would like to take patch 5 (DTS changes) and submit a pull request
including it shortly, please let me know if there are additional binding
changes that would mandate a new version of this patchset, thanks!

> 
> Thanks,
> 
> Ray
> 
> On 5/5/2015 11:13 AM, Ray Jui wrote:
>> This patchset contains the initial common clock support for Broadcom's iProc
>> family of SoCs. The iProc clock architecture comprises of various PLLs, e.g.,
>> ARMPLL, GENPLL, LCPLL0, MIPIPLL, and etc. An onboard crystal serves as the
>> basic reference clock for these PLLs. Each PLL may have several leaf clocks.
>> One special group of clocks is the ASIU clocks, which are dervied directly
>> from the crystal reference clock.
>>
>> This patchset also contains the basic clock support for the Broadcom Cygnus
>> SoC, which implements the iProc clock architecture
>>
>> Changes from v6:
>>  - Rebase to v4.1-rc2
>>  - Consolidate iProc PLL and its leaf clocks into a single device node, based
>>    on feedback from Mike Turquette. The PLL and its leaf clocks are now exposed
>>    a clock consumer through indices of the same device node phandle
>>  - Update iProc device tree binding document based on the above change
>>  - Add SW override support to iProc PLL clocks
>>
>> Changes from v5:
>>  - Rebase to v4.0-rc4
>>  - Drop of_clk_get_parent_rate helper function from the clock framework
>>  - Get rid of custom "clock-frequency" support in iProc PLL code. Instead, add
>>    standard clock set_rate and round_rate support and make use of DT properties
>>    "assigned-clocks" and "assigned-clock-rates" to initialize PLL to the
>>    desired rate when registering to the clock framework
>>  - Add SW workaround for ASIC bug on MIPI PLL to always read back the same
>>    register following a write transaction, to ensure value is written to the
>>    correct register
>>
>> Changes from v4:
>>  - Add of_clk_get_parent_rate helper function into the clock framework
>>  - Switch to use of_clk_get_parent_rate in the iProc PLL clock driver
>>
>> Changes from v3:
>>  - Fix incorrect use of passing in of_clk_src_onecell_get when adding ARM PLL
>>    and other iProc PLLs as clock provider. These PLLs have zero cells in DT and
>>    thefore of_clk_src_simple_get should be used instead
>>  - Rename Cygnus MIPI PLL Channel 2 clock from BCM_CYGNUS_MIPIPLL_CH2_UNUSED
>>    to BCM_CYGNUS_MIPIPLL_CH2_V3D, since a 3D graphic rendering engine has been
>>    integrated into Cygnus revision B0 and has its core clock running off
>>    MIPI PLL Channel 2
>>  - Changed default MIPI PLL VCO frequency from 1.75 GHz to 2.1 GHz. This allows
>>    us to derive 300 MHz V3D clock from channel 2 through the post divisor
>>
>> Changes from v2:
>>  - Re-arrange Cygnus clock/pll init functions so each init function is right
>>    next to its clock table
>>  - Removed #defines for number of clocks in Cygnus. Have the number of clocks
>>    automatically determined based on array size of the clock table
>>
>> Changes from v1:
>>  - Separate drivers/clk/Makefile change for drivers/clk/bcm out to a standalone patch
>>
>> Ray Jui (6):
>>   clk: iproc: define Broadcom iProc clock binding
>>   clk: iproc: add initial common clock support
>>   clk: Change bcm clocks build dependency
>>   clk: cygnus: add clock support for Broadcom Cygnus
>>   ARM: dts: enable clock support for Broadcom Cygnus
>>   clk: cygnus: remove Cygnus dummy clock binding
>>
>>  .../devicetree/bindings/clock/bcm-cygnus-clock.txt |   34 -
>>  .../bindings/clock/brcm,iproc-clocks.txt           |  132 ++++
>>  arch/arm/boot/dts/bcm-cygnus-clock.dtsi            |   89 ++-
>>  drivers/clk/Makefile                               |    2 +-
>>  drivers/clk/bcm/Kconfig                            |    9 +
>>  drivers/clk/bcm/Makefile                           |    2 +
>>  drivers/clk/bcm/clk-cygnus.c                       |  265 ++++++++
>>  drivers/clk/bcm/clk-iproc-armpll.c                 |  282 ++++++++
>>  drivers/clk/bcm/clk-iproc-asiu.c                   |  276 ++++++++
>>  drivers/clk/bcm/clk-iproc-pll.c                    |  716 ++++++++++++++++++++
>>  drivers/clk/bcm/clk-iproc.h                        |  178 +++++
>>  include/dt-bindings/clock/bcm-cygnus.h             |   68 ++
>>  12 files changed, 1990 insertions(+), 63 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>>  create mode 100644 drivers/clk/bcm/clk-cygnus.c
>>  create mode 100644 drivers/clk/bcm/clk-iproc-armpll.c
>>  create mode 100644 drivers/clk/bcm/clk-iproc-asiu.c
>>  create mode 100644 drivers/clk/bcm/clk-iproc-pll.c
>>  create mode 100644 drivers/clk/bcm/clk-iproc.h
>>  create mode 100644 include/dt-bindings/clock/bcm-cygnus.h
>>


-- 
Florian
