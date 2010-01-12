From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 00:06:06 +0000
Subject: [PATCH 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <20100111100253.GA30556@n2100.arm.linux.org.uk>
References: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
	<20100111100253.GA30556@n2100.arm.linux.org.uk>
Message-ID: <20100112000606.GR3738@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 10:02:54AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 06:44:32PM +0900, Kukjin Kim wrote:
> > This patch adds common idle functionality for all Samsung SoC's.
> 
> NAK.  Please use the existing support already provided.  There's no point
> in double-indirection - it just makes the code harder to follow.
> 
> Just set pm_idle to your idle function.

Hmm, the default_idle() function that pm_idle is set to at init time does
more than what arch_idle() does. We'd end up having to copy the logic in
default_idle() into each of our idle routines. How difficult would it be
to change the callers of pm_idle() to check whether it actually needs
calling and to re-enable the interrupt state after calling it?

We did this originally as before we issue the WFI co-processor instruction
we need to set the sleep mode. A number of the Samsung SoC have the WFI
line on the cpu routed via a mux to various functions, such as IDLE or
much deeper sleep modes such as the SUSPEND state.

I've no data on whether the write is needed before each sleep or not, so
my preference would be to ensure that this mux is setup before each call,
but it might be possible to simply ensure that it is setup correctly on
init and after suspend/resume.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
