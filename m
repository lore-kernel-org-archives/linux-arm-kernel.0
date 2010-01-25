From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 25 Jan 2010 12:54:39 +0200
Subject: [PATCH 2/2] mx25: properly initialize clocks, fix time accounting
In-Reply-To: <20100122075733.GS7200@pengutronix.de>
References: <cover.1264085584.git.baruch@tkos.co.il>
	<d05c786d8d87c1bb35e3f13d4fc9b8f4ddf18b3b.1264085584.git.baruch@tkos.co.il>
	<20100122075733.GS7200@pengutronix.de>
Message-ID: <20100125105439.GE6724@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, Jan 22, 2010 at 08:57:33AM +0100, Sascha Hauer wrote:
> On Thu, Jan 21, 2010 at 05:00:23PM +0200, Baruch Siach wrote:
> > For some odd reason the GPT module has run the timer counter at 100MHz, while
> > the rate reported by the gpt_clk has been 133MHz. This caused a significant
> > drift in time accounting.
> > 
> > This patch disables all unnecessary clock in mx25_clocks_init() to make a clean
> > start, the same as is being done for the rest of the i.MX chips.
> > 
> > To preserve the uart and fec functionality, this patch temporarily enables the
> > respective clocks in mx25_clocks_init(). The real fix for this is to use the
> > .secondary field of the mxc clk struct, and enable these clocks from there.
> 
> Then lets implement it the real way, it's not too hard. The following
> two patches should do it. It's compile tested only, can you test them on
> hardware please? The patches do not include your timer rate fixup and
> clock disabling fix.

Your .secondary implementation works like a charm on the i.MX25 PDK.

My following patches add the fref removal, clock disabling, and the time 
accounting fix. Another patch reverses the primary/secondary ordering of the 
fec clock to make it consistent with the uart clock.

Let me know what you think.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
