From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 24 Apr 2011 09:34:20 +1000
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <4DB221D7.4030703@codeaurora.org>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421120656.GF15233@pengutronix.de>
	<alpine.LFD.2.02.1104211632240.3323@ionos>
	<BANLkTikU9RLy9VR+tOPMt0u6zJp-bW5_Cw@mail.gmail.com>
	<alpine.LFD.2.02.1104221124270.3323@ionos>
	<BANLkTim8GUuMxwfHFoVv=LfQFuh4QaPn+Q@mail.gmail.com>
	<alpine.LFD.2.02.1104221857060.3323@ionos>
	<4DB20091.1070509@codeaurora.org>
	<alpine.LFD.2.02.1104230054260.3323@ionos>
	<4DB221D7.4030703@codeaurora.org>
Message-ID: <1303601660.2513.135.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-22 at 17:48 -0700, Saravana Kannan wrote:
> 
> They are completely independent. No synchronization is needed between 
> these clock trees. It's basically a bunch of clocks controlled by 
> another processor that has it's own set of PLLs, etc. 

In fact the common struct clk work that Jeremy picked up from initial
patches I did for powerpc was intended for just that ... ie by moving
the implementation out to have the clock "provider" being the one
creating the clock objects.

There's many other similar cases, ie, you can have a multifunction
device (wifi + bt + mmc reader for example) which has its own internal
clock network and might want to use struct clk to handle clocks between
those parts.

None of that should sit in the arch or platform code.

In fact, with the device-tree, you could completely represent the
binding between those objects without involving any platform code, that
was the original intend and I hope that ARM eventually gets there.

Cheers,
Ben.
