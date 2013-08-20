From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Aug 2013 22:44:56 +0200
Subject: [RFC 02/17] ARM: call clk_of_init from time_init
In-Reply-To: <52138F56.6030008@wwwdotorg.org>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <52138F56.6030008@wwwdotorg.org>
Message-ID: <201308202244.56782.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 August 2013, Stephen Warren wrote:
> On 08/19/2013 08:04 PM, Sebastian Hesselbarth wrote:
> > Most DT ARM machs require common clock providers initialized before timers.
> > Currently, arch/arm machs use .init_time to call clk_of_init right before
> > clocksource_of_init. This prevents to remove that hook and use the default
> > hook instead. clk_of_init now checks for multiple calls to it, so add
> > the call to ARM arch time_init by default.
> 
> Some SoCs call this function in .init_irq() rather than .init_time().
> Perhaps we adjust this patch to do that instead. That way, we can
> presumably get rid of patch 1/17 since we can eliminate any duplicate
> calls, and adjust patch 14/17 (Tegra board file) to remove its custom
> call to of_clock_init(NULL)?

I think we should do thinks as late as possible in general. We probably
need clocks running on most platforms before we can set up timers, so
it makes sense to do the clocks first, but very few platforms require
clocks to be running before the interrupt controller is set up.

A nicer solution would be to change the tegra code to not require this
to be called this early, if at all possible.

	Arnd
