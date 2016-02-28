From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:51 +0000
Subject: [PATCH v5 00/20] add additional clocks and frac/mash support
Message-ID: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Fix issues found with current driver with regards to:
* coding style
* locking
* setting register instead of bits in register
* the use of BCM2835_CLOCK_COUNT in the device tree bindings

adds:
* frac/mash support (with correct limits)
* exposing of additional clock parameters in debugfs
  (registers, divider and parent)
* added all the missing pll dividers
* almost all so far undefined clocks

Clocks still missing:
* gnric - Eric says that this is not really a clock
          (but it has corresponding registers set)
* tcnt - this seems to be more of a counter clock gate
         used for some other purpose - there are 4 CNT registers
* pllt - totally unidentified clock with a strange mux size of
         8 clocks (3 bit, not the typical 4 or 16 bit)

Lots of information here has been gathered from the broadcom
provided header files for the VC4 and some information has
been inferred.

I also hope that all the feedback so far has been included
in this patch-set.

Complete mash clock divider support has been left out for now.
We now only support the basic fractional divider option (MASH=1)
but with the corresponding divider limits that apply to mash clocks.

Some measurements on I2S-DACs show unexpected noise levels using
different mash levels, so that an automatic "best" selection does
not seem wise - this exercise is left for a later patch-set.

Changelog:
        V1 -> V2: split the asoc/sound patches from the clock patches
                  enable frac/mash support
        V2 -> V3: clamp clock divider to be >= 2
                  clamp max clock divider to be integer (not fractional)
                  added additional limit checks for divider selection
                    allowing fallback to lower mash levels.
                  use a newer probing mechanism based on a single array
        V3 -> V4: fixed bad NULL pointer check in init
                  fixed (mash) limit checks
                  separated basic mash support from limits checks
                  really tested with I2S device (unfortunately V3 was
                  not well tested in this respect)
        V4 -> V5: major reorganisation of patchset
	      	  including fixes for newly discovered bugs
		  split up clock commits into several chunks
		  separate clamping for mash enabled clocks
		  made better use of static assignment reducing
		    efforts to add a new clock - see specifically patch 7

Martin Sperl (20):
  clk: bcm2835: pll_off should only set CM_PLL_ANARST
  clk: bcm2835: clean up coding style issues
  clk: bcm2835: add locking to pll*_on/off methods
  clk: bcm2835: remove uart0/1_pclk fixed clocks
  clk: bcm2835: enable clocks that have been enabled by firmware
  clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in driver
  clk: bcm2835: reorganize bcm2835_clock_array assignment
  clk: bcm2835: add fractional support
  clk: bcm2835: enable management of PCM clock
  clk: bcm2835: implement correct clamping for mash clocks
  clk: bcm2835: divider value has to be 1 or more
  clk: bcm2835: expose raw clock-registers via debugfs
  clk: bcm2835: expose current divider, parent and mash via debugfs
  clk: bcm2835: added missing PLL clock divider
  clk: bcm2835: add additional clocks
  clk: bcm2835: add the camera related clocks cam0, cam1 and ccp2
  clk: bcm2835: add the dsi clocks
  clk: bcm2835: add arm clock
  clk: bcm2835: add gates that require PM_DEBUG to be set
  clk: bcm2835: add the testdebug clock generators

 drivers/clk/bcm/clk-bcm2835.c       | 1536 +++++++++++++++++++++++------------
 include/dt-bindings/clock/bcm2835.h |   31 +-
 2 files changed, 1061 insertions(+), 506 deletions(-)

--
1.7.10.4
