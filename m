From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 11 Mar 2010 08:29:14 +0900
Subject: [PATCH 04/11] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <20100310221652.GS2900@atomide.com>
References: <1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<63386a3d1003092140o67a6c943rdee3a6c905cea7ef@mail.gmail.com>
	<4B973CF6.4030009@st.com>
	<63386a3d1003100131v7027e44cu5031c9ee3bf6ec73@mail.gmail.com>
	<4B977067.3050108@st.com> <20100310141645.GB22729@linux-sh.org>
	<alpine.LFD.2.00.1003101732010.22855@localhost.localdomain>
	<20100310221652.GS2900@atomide.com>
Message-ID: <20100310232914.GC22729@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 02:16:53PM -0800, Tony Lindgren wrote:
> * Thomas Gleixner <tglx@linutronix.de> [100310 08:38]:
> > On Wed, 10 Mar 2010, Paul Mundt wrote:
> > > This is hardly a unique situation for your platform, this is true for
> > > most platforms. There's no reason why clockevents couldn't just be
> > > extended and drivers could then just grab unused clockevents and pin them
> > > accordingly. Most of the infrastructure is already in place for something
> > > like that, without really having to do anything special.
> > > 
> > > Having said that, most drivers have pretty lame reasons for trying to get
> > > at fixed timer channels, and most of the time they can easily get by with
> > > an hrtimer instead. There's also the issue that you're effectively
> > > bypassing nohz by having some timer channel off on the side doing who
> > > knows what. You would need a pretty compelling reason for why you are
> > > sidestepping all of the existing infrastructure anyways.
> > 
> > Right, and that's exactly the reason why we did not add the few
> > missing bits to make clock events directly usable from drivers.
> 
> Yeah still no direct users so far for the 12 hardware timers on
> omaps.. I guess the only use I could see is bit banging data
> over a few GPIO lines using a FIQ handler.
> 
> Another thing to consider is that most likely all hardware timers
> are not able to wake up the system from idle, which would easily
> cause some mysterious errors for drivers.
> 
Even if most drivers shouldn't be touching clockevents directly, there
are still legitimate cases. In SMP configurations where a single timer
block is shared across multiple CPUs it would be easier to have the boot
CPU register all of the timer channels under clockevents and have the
secondaries grab one at random for setting up their local timers. (Even
if they're not truly "local" timers, it's still a better situation than
broadcast IPIs). clockevents would need some minor extension, including
dealing with unregistration for the CPU hotplug case, but it's a pretty
good fit for the problem otherwise.

If all timer channels are equal then there's also the possibility of
matching device IDs against the CPU's struct device, but depending on the
CPU topology is a pretty dire hack, particularly as most timer channels
have differing capabilities.
