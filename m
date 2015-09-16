From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Sep 2015 20:13:15 +0100
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <20150916162157.GB21084@n2100.arm.linux.org.uk>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <87d1zj6fq2.fsf@eliezer.anholt.net> <55F5CD80.3020700@tronnes.org>
 <20150914090853.GF21084@n2100.arm.linux.org.uk>
 <87wpvtjcka.fsf@eliezer.anholt.net>
 <20150914143459.GN21084@n2100.arm.linux.org.uk>
 <87613a31jb.fsf@eliezer.anholt.net>
 <20150916162157.GB21084@n2100.arm.linux.org.uk>
Message-ID: <20150916191314.GI21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 05:21:57PM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 16, 2015 at 10:02:32AM -0400, Eric Anholt wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > On Mon, Sep 14, 2015 at 07:33:09AM -0700, Eric Anholt wrote:
> > >> So, while FIQ isn't used in upstream, I think it's worthwhile to merge.
> > >> It is another step to bringing the downstream developers into the fold.
> > >
> > > I want to see the code _first_.  Until then, I'm sorry, this patch can't
> > > go in.
> > 
> > If you just want to see "Yes, GPL-compatible code using this is
> > available", then that is:
> 
> It's got nothing to do with "GPL-compatible code".  I want to audit
> _all_ code that makes use of FIQ.  It disgusts me that you're trying
> to dress this up as a licensing issue.  It isn't.
> 
> > https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_stub.S
> > https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.c

Some comments on the FIQ aspects of the code I find in
https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/
as a whole:

* For non-FIQ taking of your special FIQ lock, please add a couple of
  functions called something like fiq_fsm_spin_lock_disable() and
  fiq_fsm_spin_unlock_enable() which wraps up this detail.

* Please remove the "local_fiq_enable();" at the end of hcd_init_fiq() -
  FIQs should be enabled already (please check, and if not, please say
  so, because that's a bug.)

* You run the FIQ on CPU1 when there's two CPUs present - I hope you
  conditionalise this on CPU hotplug support being disabled, or have
  a means to deal with CPU1 being taken offline while the driver is
  operational.

* It's good that you run set_fiq_regs() from a smp-called-function,
  where we're guaranteed to be non-preemptible; I've a couple of patches
  which cause set_fiq_regs() to complain if called in a preemptible
  context, and the good news is that this driver won't be affected by
  that change.

* The comments in dwc_otg_fiq_fsm.c are incorrect; you now have locking
  so the bit about requiring FIQ and SGI on the same CPU seems to no
  longer apply - or does it?  However, even if they're running on the
  same core, I'm completely unconvinced that the comment has ever been
  correct - the SGI can be interrupted by the FIQ at any moment.

* AAPCS requires stacks to be aligned to 64-bits:

  regs.ARM_sp = (long) dwc_otg_hcd->fiq_stack + (sizeof(struct fiq_stack) - 4);

  where:

  struct fiq_stack {
    int magic1;
    uint8_t stack[2048];
    int magic2;
  };

  does not provide for that.  It's also an incredibly inefficient size
  to allocate - do you absolutely need 2048 bytes or will 2036 bytes do?
  (Also note that C99 types are frowned upon in the kernel.)
  So, I'd suggest:

  struct fiq_stack {
    u32 magic1;
    u32 stack[2040 / sizeof(u32)];
    u32 magic2;
  };

  and:

  /* Get top of stack, which must be 64-bit aligned */
  regs.ARM_sp = (long)&dwc_otg_hcd->fiq_stack->magic2;
  WARN_ON(regs.ARM_sp & 7);

I think that's all the comments I have on the FIQ implementation there.
What are the plans to get some of this USB code posted for review and
potential merging?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
