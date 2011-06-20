From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 22:16:55 +0100
Subject: [PATCH] omap2+: pm: Fix section mismatch in pm_dbg_init()
In-Reply-To: <87tybk6wh8.fsf@ti.com>
References: <1308256260-15597-1-git-send-email-premi@ti.com>
	<87tybk6wh8.fsf@ti.com>
Message-ID: <20110620211655.GN2082@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 02:09:39PM -0700, Kevin Hilman wrote:
> Sanjeev Premi <premi@ti.com> writes:
> 
> > Fix the section mismatch warning:
> >
> >   WARNING: vmlinux.o(.text+0x21118): Section mismatch
> >   in reference from the function pm_dbg_init() to the
> >   function .init.text:pwrdms_setup()
> >   The function pm_dbg_init() references
> >   the function __init pwrdms_setup().
> >   This is often because pm_dbg_init lacks a __init
> >   annotation or the annotation of pwrdms_setup is wrong.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  Applies to current linux-omap master
> 
> A previous commit just removed the __init annotation here because of a
> different conflict with the regset init.   The regset code is now
> removed in my queue for 3.1, so this patch is fine on top of that
> series.
> 
> Queueing for v3.1 (branch: for_3.1/pm-misc)

Sigh.  Please put some thought into it first and stop applying patches
without first doing some analysis and test-buliding the thing.  Otherwise
you're going to be applying patches for ever which add and delete
these things.

If you make pm_dbg_init() __init, then you also have to make
pm_dbg_regset_init() __init too.  What about the callers to
pm_dbg_regset_init() - are these marked __init or not?  If not,
they too will have to be marked __init, etc.

If that's not possible, then the __init attribute must be deleted
from pwrdms_setup().
