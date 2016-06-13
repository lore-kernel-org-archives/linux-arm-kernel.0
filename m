From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 21:26:49 +0200
Subject: [PATCH 01/48] clk: at91: replace usleep() by udelay() calls
In-Reply-To: <20160613152409.GD3240@piout.net>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <11395561.bQatt85IOg@wuerfel> <20160613152409.GD3240@piout.net>
Message-ID: <6120818.MyeJZ74hYa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 13, 2016 5:24:09 PM CEST Alexandre Belloni wrote:
> On 11/06/2016 at 00:30:36 +0200, Arnd Bergmann wrote :
> > On Saturday, June 11, 2016 12:03:04 AM CEST Alexandre Belloni wrote:
> > > From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> > > 
> > > Fix the main and slow clock .prepare() implementations which used to call
> > > usleep() when the scheduler wasn't ready yet.
> > > 
> > 
> > Does this have to be called that early? It seems wasteful to always
> > call udelay() here, when these are functions that are normally
> > allowed to sleep.
> > 
> 
> So I've tested it and something like that would work:
> 
>         if (system_state < SYSTEM_RUNNING)
>                 udelay(osc->startup_usec);
>         else
>                 usleep_range(osc->startup_usec, osc->startup_usec + 1);

I think that's reasonable in this case.

> But I'm afraid it would be the first driver to actually do something
> like that (however, it is already the only driver trying to sleep). 

We have a lot of drivers that call potentially sleeping function from
the .prepare callback, e.g. when they go to an i2c controller.

	Arnd
