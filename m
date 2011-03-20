From: julia@diku.dk (Julia Lawall)
Date: Sun, 20 Mar 2011 22:42:42 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <20110320213045.GA27943@pengutronix.de>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
	<Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
	<20110320192451.GA19808@pengutronix.de>
	<Pine.LNX.4.64.1103202143070.27008@ask.diku.dk>
	<20110320213045.GA27943@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1103202238190.27008@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Mar 2011, Wolfram Sang wrote:

> On Sun, Mar 20, 2011 at 09:51:32PM +0100, Julia Lawall wrote:
> > I guess that the !GPIOLIB issue is related to a configuration option, that 
> > can't very easily be detected from looking at the C file alone?
> 
> Yes, that is a configuration option at the moment. It shouldn't be IMO, that's
> what my patch is addressing.
> 
> > Ignoring that issue, the following semantic patch addresses the common 
> 
> Sigh, here goes my chance to play with coccinelle again ;)

Well, there are still 300 or so cases that my rules don't catch :)

> > case where there is no error checking for the input or output call, but 
> > there may be error checking for the gpio_request call.  This transforms 
> > over 500 occurrences.
> 
> In my book, converting the ones which do not check errors at all is not worth
> the trouble. Proper error-checking should be the main benefit, not one saved
> line. So, this is mindwork. If gpio_request is checked, merging seems sensible
> (but should be audited).

OK.  One could put rules like:

@@
expression E1,E2;
@@

-      gpio_request(E1,E2);
+      BAD_CALL(gpio_request_one(E1,GPIOF_IN,E2));
       ... when != E1
-      gpio_direction_input(E1);

to more easily find those cases.  There are 265 of them.

julia
