From: gbean@codeaurora.org (Gregory Bean)
Date: Thu, 25 Aug 2011 11:14:04 -0700
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <20110825151210.GC31331@huya.qualcomm.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3BC0@HQMAIL01.nvidia.com>
	<CACRpkdaZfG4hiGf8vug3EGMRMc0c92xbj=L_HAQcS27DAXYc4Q@mail.gmail.com>
	<20110825151210.GC31331@huya.qualcomm.com>
Message-ID: <20110825181404.GA19345@gbean-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 08:12:10AM -0700, David Brown wrote:
> On Thu, Aug 25, 2011 at 12:12:59PM +0200, Linus Walleij wrote:
> 
> > mach-msm:
> > ----------------
> > 
> > Hard to tell how this works and what's available, support
> > seems to be incomplete. Currently it seems to be wired
> > to do either a dedicated function (like some UART pin)
> > or GPIO, like each pin can be used for two specific
> > things, and not phone-exchange type.
> 
> There are some pins on MSMs that can be connected to different hw
> blocks, we just haven't gotten the support into the kernel yet.
> 
> There are some things where two devices share pins, and you have to
> choose one or the other.
> 
> I believe there are also configurations where something such as the SD
> controller can either be configured in 8-bit data mode, or in 4-bit
> data mode, and those 4 pins connected to something else.
> 
> Much of the current pin configuration in our product kernel seems to
> be about current and pull up/down configuration.
> 
> I've added Rohit Vaswani, and Greg Bean to this thread who should have
> a bit better understanding of this.

The MSM pinmux system allows every pin to be independently controlled
in the following ways:

- function selection:  Every pin can be in GPIO mode, or connected to
  a specific piece of hardware.  The number of choices varies by pin -
  some pins have only two choices, some have eight.  When a pin is not in
  GPIO mode, it loses some configurability - for instance, its direction
  can no longer be set, as that's predetermined by the function selection.
  Pins can belong to many groups which overlap in all kinds of interesting
  ways - a pin may be part of this four-bit bus, or that eight-bit bus, or
  might stand alone for two settings...

- drive strength: Each pin can be set to have a different drive strength
  between 2MA and 16MA, in 2MA steps.

- pull settings: Each pin can be configured with a variety of pull
  settings: up, down, keeper, no pull.

Additionally, there are complexities involving delivering
interrupts from GPIOs:

- 'direct-connect' or 'summary' interrupts: pins which are being used as
  interrupt inputs can be 'summarized' through a single interrupt
  (requiring an additional pile of register reads to figure out which
  gpio triggered the interrupt) or as a 'direct-connect' interrupt.
  There are very few direct-connect lines available, so most gpio
  interrupts are summarized.

- processor interrupt assignment: Each pin can be assigned to deliver
  interrupts to a different processor on the board.  This pin might be
  assigned to the MSM, that pin might go to the DSP, the next might
  go to the modem, and so on...

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
