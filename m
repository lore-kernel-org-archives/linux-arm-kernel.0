From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 26 May 2011 10:35:13 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110526062752.GA14622@localhost.ucw.cz>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
	<20110526062752.GA14622@localhost.ucw.cz>
Message-ID: <20110526083513.GC26775@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Pavel Machek <pavel@ucw.cz> wrote:

>   On Mon 2011-05-16 10:36:05, James Morris wrote:
> > On Fri, 13 May 2011, Ingo Molnar wrote:
> > How do you reason about the behavior of the system as a whole?
> > 
> > 
> > > I argue that this is the LSM and audit subsystems designed right: in the long 
> > > run it could allow everything that LSM does at the moment - and so much more 
> > > ...
> > 
> > Now you're proposing a redesign of the security subsystem.  That's a 
> > significant undertaking.
> > 
> > In the meantime, we have a simple, well-defined enhancement to seccomp 
> > which will be very useful to current users in reducing their kernel attack 
> > surface.
> 
> Well, you can do the same with subterfugue, even without kernel 
> changes. But that's ptrace -- slow. (And it already shows that 
> syscall based filters are extremely tricky to configure).

Yes, if you use syscall based filters to implement access to 
underlying objects where the access methods do not capture essential 
lifetime events properly (such as files) they you'll quickly run into 
trouble achieving a secure solution.

But you can robustly use syscall filters to control the underlying 
primary *resource*: various pieces of kernel code with *negative* 
utility to the current app - which have no use to the app but pose 
risks in terms of potential exploits in them.

But you can use event filters to implement arbitrary security 
policies robustly.

For example file objects: if you generate the right events for a 
class of objects then you can control access to them very robustly.

It's not a surprise that this is what SELinux does primarily: it has 
lifetime event hooks at the inode object (and socket, packet, etc.) 
level and captures those access attempts and validates them against 
the permissions of that object, in light of the accessing task's 
credentials.

Exactly that can be done with Will's patch as well, if its potential 
scope of event-checking points is not stupidly limited to the syscall 
boundary alone ...

Thanks,

	Ingo
