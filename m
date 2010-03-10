From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 10 Mar 2010 23:16:46 +0900
Subject: [PATCH 04/11] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <4B977067.3050108@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<63386a3d1003092140o67a6c943rdee3a6c905cea7ef@mail.gmail.com>
	<4B973CF6.4030009@st.com>
	<63386a3d1003100131v7027e44cu5031c9ee3bf6ec73@mail.gmail.com>
	<4B977067.3050108@st.com>
Message-ID: <20100310141645.GB22729@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 03:41:51PM +0530, Viresh KUMAR wrote:
> On 3/10/2010 3:01 PM, Linus Walleij wrote:
> > 2010/3/10 Viresh KUMAR <viresh.kumar@st.com>:
> >> Linus Walleij:
> >>> If this file is only supposed to be used from plat-spear/time.c, move it down
> >>> into plat-spear/gpt.h and #include "gpt.h" so noone else will
> >>> accidentally use it.
> >>
> >> GPT's on SPEAr can be used from time.c, platform specific drivers and machine
> >> specific drivers or any driver wishing to use hardware timer.
> >> In first two cases "gpt.h" will work, but in rest of cases we need gpt.h to be
> >> in plat-spear/include/plat
> >>
> >> Is it okay?
> > 
> > If you have or have already planned to write such platform, machine
> > or subsystem drivers, it's OK, if there are no such users and you cannot
> > easily give one, it's overdesigned IMHO. Some realistic examples of such
> > drivers will make me change my mind :-)
> > 
> > The reason I persist is that I've seen such unutilized timer API:s before and
> > no other user than the system timer in sight. I never understood what they
> > were to be used for, and I still don't, so help me understand. The kernel
> > has many internal timer API:s based on clockevent available already so
> > why add yet another, platform-specific one?
> > 
> 
> As you may have seen in spear.h files in mach folders, we have multiple hardware
> timers in our design (3 in spear3xx, 4 in spear6xx and each timer have two
> independent channels. That doubles the timers count, so it is 6 and 8).
> One timer (or two channels) are used by clock event and clock source, but rest of
> the timers are still available. So we need some way to export this functionality
> of our hardware. It can be considered simply as a driver for GPT.
> 
> What do you say?
> 
This is hardly a unique situation for your platform, this is true for
most platforms. There's no reason why clockevents couldn't just be
extended and drivers could then just grab unused clockevents and pin them
accordingly. Most of the infrastructure is already in place for something
like that, without really having to do anything special.

Having said that, most drivers have pretty lame reasons for trying to get
at fixed timer channels, and most of the time they can easily get by with
an hrtimer instead. There's also the issue that you're effectively
bypassing nohz by having some timer channel off on the side doing who
knows what. You would need a pretty compelling reason for why you are
sidestepping all of the existing infrastructure anyways.

There are still some legitimate users for dedicated timers that we may
want to have decoupled from sched_clock() (like the trace clock) and so
on, but when people start rolling their own timer APIs it always sets off
warning bells, as it's almost always because they want to do something in
a driver that existing infrastructure already provides for them.

In cases like these, it's better to see what precisely you plan to do
with these timer channels before getting in to API semantics, though.
