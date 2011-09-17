From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 11:45:18 +0100
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
	<CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
Message-ID: <20110917104518.GD16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 11:24:36AM +0800, Barry Song wrote:
> if we have a save/restore interface, it looks it will be very
> complicated. different l2 need to save different registers.

Why?  It's quite simple as far as I can see:

static u32 l2_aux_ctrl;

void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
{
	...
	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);

	aux &= aux_mask;
	aux |= aux_val;

	l2_aux_ctrl = aux;
	...
}

void l2x0_resume(void)
{
	bool need_setup = false;

	if (l2_aux_ctrl != readl_relaxed(l2x0_base + L2X0_AUX_CTRL))
		need_setup = true;
	        
	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
		/* Make sure that I&D is not locked down when starting */
		l2x0_unlock(cache_id);

		/* l2x0 controller is disabled */
		writel_relaxed(l2_aux_ctrl, l2x0_base + L2X0_AUX_CTRL);

		l2x0_inv_all();

		/* enable L2X0 */
		writel_relaxed(1, l2x0_base + L2X0_CTRL);
	}
}

and we can do a similar thing when initializing the PL310 and resuming
the PL310 - add a new outer_cache callback called 'resume' to be pointed
at the relevant resume function which knows which registers to restore.

> when we resume, we must disable l2 if bootloader has enabled it and
> restore all registers.

That's not possible in SoCs operating in non-secure mode from generic
code, as some of these registers will not be accessible.  They can only
be programmed from platform specific code due to the complexities of
dealing with the abhorrent secure monitor stuff.

I'm now starting to think that we don't actually want any resume code
at the L2 level - most SoCs will be operating in non-secure mode (I
believe it's only ARM's development platforms which operate in secure
mode) and so most of the generic code which will need to write to the
L2 control registers on resume will fail.

Even re-calling the initialization functions probably does nothing on
parts operating in secure mode - whether at boot or at resume.
