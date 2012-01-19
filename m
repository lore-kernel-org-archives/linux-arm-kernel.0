From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 14:53:13 +0000
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <20120119031726.GA2247@S2101-09.ap.freescale.net>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <20246.30805.391940.766120@ipc1.ka-ro>
 <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
 <20120119031726.GA2247@S2101-09.ap.freescale.net>
Message-ID: <20120119145313.GZ1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 11:17:34AM +0800, Shawn Guo wrote:
> >From power saving point of view, I'm not sure you want to keep saif
> clock on all the time.  So if the clock is off when you try to call
> clk_set_rate(), you may want to turn it back to off after clk_set_rate()
> is done.

You really shouldn't expose these kinds of SoC specific oddities outside
of the API - it makes a mockery of having an API in the first place.

Can you not do:

clk_set_rate(clk, rate)
{
	clk_prepare(clk);

	reprogram_clock(clk);

	clk_unprepare(clk);
}

A clk_prepare() call on an already prepared clock should have no impact
other than incrementing the counter, which will be balanced on the other
side by the clk_unprepare().
