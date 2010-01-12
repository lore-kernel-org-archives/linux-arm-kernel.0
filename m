From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 10:12:26 +0000
Subject: [PATCH 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <20100112000606.GR3738@trinity.fluff.org>
References: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
	<20100111100253.GA30556@n2100.arm.linux.org.uk>
	<20100112000606.GR3738@trinity.fluff.org>
Message-ID: <20100112101226.GA27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 12:06:06AM +0000, Ben Dooks wrote:
> On Mon, Jan 11, 2010 at 10:02:54AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 11, 2010 at 06:44:32PM +0900, Kukjin Kim wrote:
> > > This patch adds common idle functionality for all Samsung SoC's.
> > 
> > NAK.  Please use the existing support already provided.  There's no point
> > in double-indirection - it just makes the code harder to follow.
> > 
> > Just set pm_idle to your idle function.
> 
> Hmm, the default_idle() function that pm_idle is set to at init time does
> more than what arch_idle() does. We'd end up having to copy the logic in
> default_idle() into each of our idle routines. How difficult would it be
> to change the callers of pm_idle() to check whether it actually needs
> calling and to re-enable the interrupt state after calling it?

Not possible without changing all the other architectures - pm_idle() is
the standard interface for hooking into the idle code, and is used by
things like cpuidle, APM, ACPI, etc.

Please use the standard cross-architecture pm_idle() hook if you want to
dynamically override the default idle code.
