From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 16:13:00 +0100
Subject: [PATCH v4 3/7] arm/imx: add gic_handle_irq function
In-Reply-To: <20110929140804.GJ19318@S2100-06.ap.freescale.net>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<1317200808-6275-4-git-send-email-shawn.guo@linaro.org>
	<20110929093409.GG23944@n2100.arm.linux.org.uk>
	<20110929140804.GJ19318@S2100-06.ap.freescale.net>
Message-ID: <20111001151300.GC11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:08:05PM +0800, Shawn Guo wrote:
> Can you please share your position on Marc's PPI and GIC
> MULTI_IRQ_HANDLER series?  Are you possibly going to merge them in the
> coming merge window?  If you are, I would directly move my imx6q onto
> those series and save the local gic_handle_irq().  Otherwise, I may
> have to add a wrapper for do_IPI() and do_local_timer() to work around
> the pt_regs issue you pointed out here.

My personal opinion of Marc's PPI patches hasn't changed: I think
integrating them into genirq just makes the whole thing a lot more
complicated (and error-prone) than it otherwise needs to be.

For example, it is completely invalid to call any of the existing
genirq APIs for a PPI interrupt, because there is no sane way to ensure
that the intended CPU is targetted - unless we're operating from a thread
which is bound specifically to a single CPU.

However, Marc has been working with Thomas to produce something more
generic (and not ARM specific) and I don't have an opinion on that.
This addresses the issues (like the one I mention above) but I've not
been following it any further than that.
