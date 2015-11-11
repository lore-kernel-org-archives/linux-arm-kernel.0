From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Nov 2015 13:37:19 -0800
Subject: [PATCH v3 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
In-Reply-To: <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
Message-ID: <20151111213718.GH3218@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [151030 09:11]:
> Hi P?ter
> 
> On Fri, 30 Oct 2015, Peter Ujfalusi wrote:
> 
> > Changes since v2:
> > - DTS patch added which is needed because of the clock handling changes
> > 
> > Felip Balbi reported that linux-next is broken right now since the DTS part of
> > the earlier series has been applied, but we do not have the mcasp hwmod in the
> > kernel:
> > ...
> > [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
> > ...
> > [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
> > [    6.130790] ------------[ cut here ]------------
> > [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x220/0x34c()
> > [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3 (Read): Data Access in User mode during Functional access
> > ...
> > 
> > This is the followup series for the hwmod changes needed to get audio working
> > on DRA7xx family based boards.
> > The DTS patches has been applied by Tony from the original series:
> > http://www.spinics.net/lists/linux-omap/msg121473.html
> > 
> > I have addressed your comments in the hwmod data and did some research also
> > regarding to the use of ahclkx as fclk in the original submission.
> > It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
> > ahclkx/r) to be able to access registers. The original patch where we handled
> > the ahclkx as fclk worked, because the fclk clock got enabled in the HW w/o
> > any SW interaction.
> > All in all, the McASP found in DRA7 needs all clocks to be enabled.
> > To satisfy this I have introduced a new flag to hwmod, which means that the
> > listed optional clocks need to be handled alongside with the fclk clock.
> 
> Thanks.  I'm happy with your series and appreciate the indepth 
> investigation.  As you probably saw last week, we've hit the limit for 
> v4.4-rc1:
> 
> http://marc.info/?l=linux-omap&m=144564929721826&w=2
> 
> This is why I haven't done anything with this series at this time.  
> Unfortunately I don't have a DRA7xx board, so I can't do any testing.  
> But if this series fixes a problem with DRA7xx in linux-next, we should 
> definitely merge it.
> 
> Tony, if you want to take this now, you can either take it with my ack, or 
> I can send a pull request.  Or, if you'd prefer to take it for v4.4-rc2, 
> I can send a pull request after v4.4-rc1.

OK I'll add your ack to the hwmod patches and apply all theree patches into
omap-for-v4.4/fixes as it fixes the splat on beagle x15 Felipe reported.

Regards,

Tony
