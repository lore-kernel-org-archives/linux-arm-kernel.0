From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Jan 2012 18:10:02 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20120116174039.GD32049@n2100.arm.linux.org.uk>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CADMYwHzE0HeBKjA55ApQo0k5AW8+Za3kT8u5HnMorXEk4PQxjA@mail.gmail.com>
 <20120116162933.GG14252@pengutronix.de>
 <20120116174039.GD32049@n2100.arm.linux.org.uk>
Message-ID: <20120116181002.GC12267@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 05:40:39PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 16, 2012 at 05:29:33PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Dec 21, 2011 at 07:31:56PM +0200, Ohad Ben-Cohen wrote:
> > > Hi Uwe,
> > > 
> > > 2011/12/21 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > > > If you're interested in the details I can publish my tree I think.
> > > 
> > > Definitely interested - it could be very nice if you can publish that tree.
> > OK, it's online now at
> > 
> > 	http://git.pengutronix.de/?p=ukl/linux-2.6.git;a=shortlog;h=refs/heads/efm32
> > 	git://git.pengutronix.de/git/ukl/linux.git efm32
> > 
> > Please note that this is work in progress and has some rough edges. ...
> > but at least it boots on my machine.
...
> This looks buggy:
> +#if defined(CONFIG_CPU_V7M)
> +       .macro  setmode, mode, reg
> +       .endm
> +#elif defined(CONFIG_THUMB2_KERNEL)
>         .macro  setmode, mode, reg
>         mov     \reg, #\mode
>         msr     cpsr_c, \reg
> 
> as it does nothing about the interrupt mask.

The interrupt mask is not part of CPSR on the M profile, so setmode
didn't make much sense. Looking through the kernel, there are only two
calls to setmode that would disable interrupts, so we need to make sure
they are indeed disabled (though given how the M profile works, with
priorities, we could already be safe; it needs checking though).

> The VFP stuff - adding 'clean' which is kernel state to the _user_
> _exported_ VFP hardware structure is a bad idea.  So this needlessly
> causes a variation in the kernels userspace API.  Please find somewhere
> else to keep kernel internal state.  (As that patch comes from Catalin,
> then that comment is directed to Catalin.)

Are you sure we export vfp_hard_struct to user? That's a kernel-only
structure (and it's not by any means stable, given the number of
#ifdef's it has). I would also argue that 'clean' is a hardware state
(inferred from the exception return value).

-- 
Catalin
