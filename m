From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 8 Feb 2013 14:32:03 +0000
Subject: [PATCH] ARM: Allow modules to read cpu_logical_map
In-Reply-To: <20130208122604.GO17833@n2100.arm.linux.org.uk>
References: <1360325980-19089-1-git-send-email-dave.martin@linaro.org>
 <20130208122604.GO17833@n2100.arm.linux.org.uk>
Message-ID: <20130208143203.GB1973@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 12:26:04PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 08, 2013 at 12:19:40PM +0000, Dave Martin wrote:
> > It is reasonable for loadable modules to be CPU topology aware
> > (particular examples include cpufreq and cpuidle drivers).
> > 
> > This patch exports a new function cpu_get_hwid(cpu) to provide
> > suitable read-only access outside vmlinux.
> 
> And we have an export with no user... where are the patches which
> illustrate its usage?

That's a fair point.

The background is that ARM have an out-of-tree profiling driver,
which may need to look at cpu_logical_map in the presence of the
big.LITTLE in-kernel switcher code.

Although there is no in-tree code using this yet, the usage seems
legitimate.

If there are outstanding concerns about this, this patch could stay
out-of-tree too, but said driver would only work with a modified
kernel in that case.

If this is not considered relevant to the kernel proper yet, then
it could be posted via the big.LITTLE in-kernel switcher series
when those are finally published, since it is this that causes
cpu_logical_map to change in ways that a few specialised drivers
may need to respond to.  Without the switcher, no code should need
to look at cpu_logical_map (the present situation).

(Nico, please shout if you have any concerns about that approach.)

Cheers
---Dave
