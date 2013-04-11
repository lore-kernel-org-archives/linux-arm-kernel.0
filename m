From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 15:06:33 +0200
Subject: [RFC PATCHv2 arm: initial TI-Nspire support]
In-Reply-To: <C576ECFF-EF90-4995-AD28-1CEEE660DBAB@gmail.com>
References: <8E071E2D-4FF3-487E-A53B-B6A7C427E421@gmail.com>
 <201304111430.05528.arnd@arndb.de>
 <C576ECFF-EF90-4995-AD28-1CEEE660DBAB@gmail.com>
Message-ID: <201304111506.34229.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013, Daniel Tang wrote:
> >> +
> >> +CLOCKSOURCE_OF_DECLARE(nspire_classic_timer,
> >> +            DT_COMPAT, nspire_classic_timer_init)
> > 
> > Why do you need the logic to prevent it from being initilized
> > twice?  Can't you just remove the direct call to nspire_classic_timer_init
> > from platform code and rely on of_clk_init() to call it?
> > 
> 
> Ah, I wasn't aware that of_clk_init() would call the init functions. I thought it was up to clocksource_of_init() to do that.
> 
> Originally, I was adding a call to clocksource_of_init() to the platform code but
> that resulted in the timers being added twice. If of_clk_init() already calls the
> init functions, that would explain it. 

Sorry, I was confusing the calls, I meant clocksource_of_init() not of_clk_init().

I think the reason why they were added twice is that you have two nodes
matching "nspire-classic-timer", so you get called for each one, but the
existing code (pre linux-next) does not actually pass the node and you
end up looping through both for each of the two calls.

	Arnd
