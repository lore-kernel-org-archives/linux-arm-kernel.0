From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 14 Jul 2015 13:55:27 -0400
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
In-Reply-To: <20150714172953.GA19135@fifo99.com>
References: <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com>
 <20150714154040.GA3912@redhat.com>
 <20150714154833.GA18883@fifo99.com>
 <20150714161612.GH10792@redhat.com>
 <87a8uyoeig.fsf@x220.int.ebiederm.org>
 <20150714172953.GA19135@fifo99.com>
Message-ID: <20150714175527.GI10792@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 05:29:53PM +0000, dwalker at fifo99.com wrote:

[..]
> > >> > If a machine is failing, there are high chance it can't deliver you the
> > >> > notification. Detecting that failure suing some kind of polling mechanism
> > >> > might be more reliable. And it will make even kdump mechanism more
> > >> > reliable so that it does not have to run panic notifiers after the crash.
> > >> 
> > >> I think what your suggesting is that my company should change how it's hardware works
> > >> and that's not really an option for me. This isn't a simple thing like checking over the
> > >> network if the machine is down or not, this is way more complex hardware design.
> > >
> > > That means you are ready to live with an unreliable design. There might be
> > > cases where notifier does not get run properly and you will not do switch
> > > despite the fact that OS has failed. I was just trying to nudge you in
> > > a direction which could be more reliable mechanism.
> > 
> > Sigh I see some deep confusion going on here.
> > 
> > The panic notifiers are just that panic notifiers.  They have not been
> > nor should they be tied to kexec.   If those notifiers force a switch
> > over of between machines I fail to see why you would care if it was
> > kexec or another panic situation that is forcing that switchover.
> 
> Hidehiro isn't fixing the failover situation on my side, he's fixing register
> information collection when crash_kexec_post_notifiers is used.

Sure. Given that we have created this new parameter, let us fix it so that
we can capture the other cpu register state in crash dump.

I am little disappointed that it was not tested well when this parameter was
introuced. We should have atleast tested it to the extent to see if there
is proper cpu state present for all cpus in the crash dump.

At that point of time it looked like a simple modification
to allow panic notifiers before crash_kexec().

Thanks
Vivek
