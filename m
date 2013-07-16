From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 16 Jul 2013 09:48:56 +0200
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <20130716073101.GB25043@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch> <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
Message-ID: <13fe673f255.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, Thomas,

In the discussion about orion clocksource Russell was proposing a generic 
thread-safe write. That puts a single lock around all those writes. Of 
course, it will also blocked by totally unrelated thread-safe register 
accesses but should prevent us from having dozens of locks and solves the 
symbol issue.

Sebastian



On July 16, 2013 9:31:01 AM Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jul 16, 2013 at 09:20:59AM +0200, Thomas Petazzoni wrote:
> > Dear Andrew Lunn,
> > On Tue, 16 Jul 2013 08:59:52 +0200, Andrew Lunn wrote:
> > > Maybe i'm missing something here. You are making use of
> > > orion_timer_ctrl_clrset() from time-orion.c. How will this work on
> > > 370/XP which has a different clocksource driver?
> > I *think* the idea is that the Armada 370/XP driver will expose the
> > same function, so from the point of view of the watchdog driver, it
> > will just work.
>
> Hi Thomas
>
> That was what i was thinking would happen. And then i started to
> wonder how well the kernel linker deals with multiple definitions of
> the same symbol. Dove and 370/XP can end up in the same kernel. So we
> need to have both orion-timer and the 370/XP timer in the same kernel,
> so we end up with the same symbol in the kernel twice...
>
> Lets wait for Ezequiel to answer.
>
>    Andrew
