From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 3 May 2011 00:41:23 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DBF30FA.5000708@bluewatersys.com>
References: <20110502153852.GI1212@game.jcrosoft.org>
	<4DBF1342.6070406@bluewatersys.com>
	<20110502202449.GB13724@game.jcrosoft.org>
	<4DBF164C.7030900@bluewatersys.com>
	<20110502205154.GC13724@game.jcrosoft.org>
	<4DBF21B0.5060202@bluewatersys.com>
	<20110502212920.GD13724@game.jcrosoft.org>
	<4DBF2A9E.5010201@bluewatersys.com>
	<20110502220643.GF13724@game.jcrosoft.org>
	<4DBF30FA.5000708@bluewatersys.com>
Message-ID: <20110502224123.GH13724@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:32 Tue 03 May     , Ryan Mallon wrote:
> On 05/03/2011 10:06 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> The boards are different. They have a common base pinout, but their
> >> peripheral pinouts are different. Multiple mach-types cost nothing and
> >> are a well understood part of ARM Linux. Your proposed cpu detection
> >> code adds complexity and code, and has zero benefit for any of the
> >> boards currently in mainline.
> > So we will do an other re-architecture in the few months
> > Linus is going to said no
> > We do need to stop to do changset again and again just because we don't solve
> > the issue at the beginning
> 
> Agreed. That is why I am saying that we should focusing on reducing the
> size and complexity of AT91 and getting a single kernel working for all
> of the at91 boards which are currently in mainline.
> 
> >> Carrier boards are a separate issue, and there has not really been a
> >> consensus on what the best way to solve the issue of combining system on
> >> modules (SoMs) with carrier boards. Should the mach-type belong to the
> >> SoM or to the system as a whole (SoM + carrier board)? There is
> >> currently a push to get ARM to consolidate on things rather than each
> >> sub-architecture doing things its own way.
> > Sorry but cpu detection is soc specific
> 
> The method for specifying the setup of a system including SoM and
> carrier board(s) is not cpu/soc specific and does not necessarily need
> to be done via cpu detection. In fact, I think cpu detection is a bad
> way to do it.
> 
> > hardcode it via machine ID is not good
> >> So if you want a way to
> >> differentiate carrier boards, then I think that needs to be discussed
> >> with other sub-architecture maintainers so that a common approach can be
> >> devised. I don't think that cpu detection is a robust solution. Device
> >> tree is probably the long-term solution to this.
> >>
> >> In short, your soc detection patches add additional complexity, but have
> >> zero effect on the possibility of supporting all of the current mainline
> >> at91 platforms in a single kernel. We need to fix the other barriers to
> >> this support first (such as the work Andrew Victor is doing).
> > Which can be also simply be knowning the CPU you are on
> > 
> > If you take a look on other arch they do cpu detection and there is nothing
> > wrong about it.
> 
> There is nothing wrong with the current solution for at91, yet you are
> trying to add code which is confusing (two sets of cpu_is macros) and
> adds more lines for something which _already works_.
> 
> This argument is getting frustrating. My current objections to this
> patch are:
> 
> - The current solution (explicitly specifying the soc type) works for
> all of the at91 boards currently in mainline.
why do you we redisign the 5series are based on som so when we will add the
cpu from Atmel we will have to solve this again wow great
> - It adds two sets of cpu_is macros (second set with __ prefix), which
> is confusing and pointless.
> - You have implied that the __cpu_is macros will be removed at a later
> date. Since they are basically useless now, this is just more code churn
> when we are trying to reduce it on ARM.
so we will re-add it later no-way
> - The patch as it stands won't work in a unified at91 kernel because the
> address of the DBGU registers is different on some at91 platforms.
we just have 2 diffents register common stop it
it's not the case we have one for each soc
> - By itself this patch adds complexity without fixing anything and
> without introducing any functional change.
except you propose to add 100s of new function for each soc when the soc init
is exactly the same same add copy paste for nothing
> - There are other barriers to having a unified at91 kernel which need to
> be solved first. This patch is trying to jump ahead and solve problems
> that don't exist yet.
except the swtich to the common AT91_BASE_SYS, switch of the timers, gpio to
platfrom_device, clkdev do fix it

Best Regards,
J.
