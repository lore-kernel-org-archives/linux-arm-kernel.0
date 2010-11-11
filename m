From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 11 Nov 2010 14:19:01 -0500 (EST)
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <alpine.LFD.2.00.1011111958460.2900@localhost6.localdomain6>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.1011111054010.2900@localhost6.localdomain6>
	<4CDBC60F.8070905@stericsson.com>
	<alpine.LFD.2.00.1011111203140.2900@localhost6.localdomain6>
	<alpine.LFD.2.00.1011111330170.13911@xanadu.home>
	<alpine.LFD.2.00.1011111958460.2900@localhost6.localdomain6>
Message-ID: <alpine.LFD.2.00.1011111413410.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Nov 2010, Thomas Gleixner wrote:

> On Thu, 11 Nov 2010, Nicolas Pitre wrote:
> > On Thu, 11 Nov 2010, Thomas Gleixner wrote:
> > > Well, you don't need the keepwarm() timer, if you just call
> > > sched_clock() in the idle wakeup path, so the magic in the NOHZ code
> > > will ensure that you reread the thing timely.
> > 
> > You still have to make sure you get out of idle before 16 secs has 
> > passed.
> 
> No, I meant to put it into the idle loop, right after mach_idle() or
> whatever is called to put the CPU into deep power sleep. The
> clockevents core code makes sure that you get interrupted in time.

OK, if the clockevents core code takes care of that then fine.

Of course one could claim that the sched_clock() code could be called 
needlessly when frequently entering and leaving idle mode.  That's why 
I've used a simple timer for this purpose so far, which also makes the 
implementation and its algorithm constraint workaround close together.


Nicolas
