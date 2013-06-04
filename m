From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 17:12:10 +0200
Subject: [PATCH v3] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <51ADF5C8.80007@free-electrons.com>
References: <1369651702-9207-1-git-send-email-alexandre.belloni@free-electrons.com>
 <51ADF04D.3040703@atmel.com> <51ADF5C8.80007@free-electrons.com>
Message-ID: <1900947.vroxSJEyuA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 16:12:24 Alexandre Belloni wrote:
> On 04/06/2013 15:49, Nicolas Ferre wrote:
> >
> > ... simply use this "IS_BUILTIN(CONFIG_PHYLIB)" here -----^^^^^^^^^
> > (and not above as suggested by Arnd).
> >
> > Jean-Christophe, Alexandre: do you agree with this conclusion?
> >
> > I plan to stack this patch for next at91-fixes batch.
> >
> 
> Yeah, I prepared and tested that last week but didn't send it yet. I can
> do it now if you want but you could probably just edit my patch. I'd
> like to fix the other platforms too but that probably can wait.
> 
> I believe we would still have to fix the phy_register_fixup*() works as
> it is always called from arch/ and is clearly not fool proofed enough.
> Maybe DT could help ?
> 
> Arnd, do you have any input ?

I've replied to the earlier thread now. Using if(IS_ENABLED(CONFIG_NET))
or if(IS_ENABLED(CONFIG_PHYLIB)) in platform code should be just fine and
is not a lof of extra effort.

As I explained in the other mail, I think IS_ENABLED() is better than
IS_BUILTIN() because the case where the network driver is a loadable
module would cause a silent run-time error with IS_BUILTIN, but a
link time error with IS_ENABLED, and we can prevent that error by
correctly expressing the dependency in Kconfig, e.g.

config THIS_BOARD
	select PHYLIB if THIS_BOARDS_NIC

	Arnd
