From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 27 Feb 2012 01:40:47 +0100
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <20120227001838.GE4706@n2100.arm.linux.org.uk>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <201202270047.01509.marek.vasut@gmail.com>
 <20120227001838.GE4706@n2100.arm.linux.org.uk>
Message-ID: <201202270140.47236.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Feb 27, 2012 at 12:47:01AM +0100, Marek Vasut wrote:
> > > On Sun, Feb 26, 2012 at 11:20:27PM +0100, Marek Vasut wrote:
> > > > > On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
> > > > > > Bootloader can clobber PWER value, so save it state on suspend.
> > > > > 
> > > > > What boot loader is this,
> > > > 
> > > > U-Boot, patched, not mainline.
> > > > 
> > > > > and why is it being so idiotic?
> > > > 
> > > > Mainline doesn't touch PWER, so please be careful about your
> > > > accusations.
> > > > 
> > > > > Why can't it
> > > > > be fixed?
> > > > 
> > > > Yes, either by using mainline uboot (to rule out the bootloader
> > > > problem), finding bug in linux kernel or reading the CPU manual.
> > > 
> > > Was there supposed to be any useful information in your reply, or are
> > > you just trying to be your usual antagonistic self?
> > 
> > Um ...
> > 
> > 1) PWER isn't reconfigured by uboot (see above)
> 
> Given that virtually everyone seems to use a modified version of uboot,
> how can you be so sure?

It's impossible to support every single version of some bootloader patched in 
various obscure ways, sorry.

> 
> > 2) That you should try mainline uboot to avoid debugging problems with
> > not- mainlined patches
> 
> Why should _I_ try anything with uboot?  I'm not the one experiencing
> problems.
> 
> I'll point out that Vasily is reporting that _his_ boot loader, whatever
> it is, is clobbering the PWER register.  That's *his* statement in the
> commit log, and I have no reason *not* to think that he's put in the
> research to confirm that.  Otherwise, why make such a positive statement
> about where the problem lies?

Well if it does clober the register, he should use bootloader that's not broken.

> 
> > 3) That the bug with PWER is likely in kernel, since there's an issue
> > with gpio_set_wake() on PXA
> 
> I've reviewed this function and its associated data, and can't see
> anything wrong with it (see below).
> 
> > 4) That the CPU might not preserve PWER throughout the suspend and that
> > this information might be found in the CPU manual
> 
> No.  The PXA270 manual says that this register is preserved on exit from
> deep sleep and sleep modes.  It appends a note against each bit in the
> reset status for the PWER register which says "Exit from sleep or
> deep sleep mode does not clear or set this bit".
> 
> The setup for GPIO0 is:
> 
>         for (i = 0; i <= 15; i++) {
>                 /* skip GPIO2, 5, 6, 7, 8 */
>                 if (GPIO_bit(i) & 0x1e4)
>                         continue;
> 
>                 gpio_desc[i].can_wakeup = 1;
>                 gpio_desc[i].mask = GPIO_bit(i);
>         }
> 
> So, gpio_desc[0].can_wakeup = 1 and gpio_desc[0].mask is the bitmask for
> GPIO0.
> 
> gpio_set_wake() does this:
> 
>         d = &gpio_desc[gpio];
>         c = d->config;
> 
>         if (!d->valid)
>                 return -EINVAL;
> 
> well, that's already been set valid by pxa27x_mfp_init().
> 
>         if (d->keypad_gpio && (MFP_AF(d->config) == 0) &&
> 
> it's not a keypad gpio...
> 
>         mux_taken = (PWER & d->mux_mask) & (~d->mask);
>         if (on && mux_taken)
>                 return -EBUSY;
> 
> well, d->mux_mask is zero, so this check fails.
> 
>         if (d->can_wakeup && (c & MFP_LPM_CAN_WAKEUP)) {
>                 if (on) {
>                         PWER = (PWER & ~d->mux_mask) | d->mask;
> 
> Now, we know d->can_wakeup is true.  However, what about the MFP
> configuration?
> 
> Well, that depends on the platform.  I suspect that's where the problem
> with wakeup sources not working is located, because the MFP configuration
> hasn't been properly set, and that comes from platform code.

Ok, agreed.
> 
> So please, stop blaming PXA code without full and proper analysis of
> bugs.

I said in kernel, not in PXA code.

> It's a waste of everyone's time, and it hurts proper kernel
> maintenance if these ill-researched 'workarounds' get merged instead
> of proper fixes.

Agreed. So this all boils down to the point where Vasily should check his MFP 
settings.

M
