From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 16 May 2011 17:08:37 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
Message-ID: <20110516150837.GA513@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* James Morris <jmorris@namei.org> wrote:

> On Fri, 13 May 2011, Ingo Molnar wrote:
> 
> > Say i'm a user-space sandbox developer who wants to enforce that sandboxed 
> > code should only be allowed to open files in /home/sandbox/, /lib/ and 
> > /usr/lib/.
> > 
> > It is a simple and sensible security feature, agreed? It allows most code 
> > to run well and link to countless libraries - but no access to other files 
> > is allowed.
> 
> Not really.
> 
> Firstly, what is the security goal of these restrictions? [...]

To do what i described above? Namely:

 " Sandboxed code should only be allowed to open files in /home/sandbox/, /lib/
   and /usr/lib/ "

> [...]  Then, are the restrictions complete and unbypassable?

If only the system calls i mentioned are allowed, and if the sandboxed VFS 
namespace itself is isolated from the rest of the system (no bind mounts, no 
hard links outside the sandbox, etc.) then its goal is to not be bypassable - 
what use is a sandbox if the sandbox can be bypassed by the sandboxed code?

There's a few ways how to alter (and thus bypass) VFS namespace lookups: 
symlinks, chdir, chroot, rename, etc., which (as i mentioned) have to be 
excluded by default or filtered as well.

> How do you reason about the behavior of the system as a whole?

For some usecases i mainly want to reason about what the sandboxed code can do 
and can not do, within a fairly static and limited VFS namespace environment.

I might not want to have a full-blown 'physical barrier' for all objects 
labeled as inaccessible to sandboxed code (or labeled as accessible to 
sandboxed code).

Especially as manipulating file labels is not also slow (affects all files) but 
is also often an exclusively privileged operation even for owned files, for no 
good reason. For things like /lib/ and /usr/lib/ it also *has* to be a 
privileged operation.

> > I argue that this is the LSM and audit subsystems designed right: in the 
> > long run it could allow everything that LSM does at the moment - and so 
> > much more ...
> 
> Now you're proposing a redesign of the security subsystem.  That's a 
> significant undertaking.

It certainly is.

> In the meantime, we have a simple, well-defined enhancement to seccomp which 
> will be very useful to current users in reducing their kernel attack surface.
> 
> We should merge that, and the security subsystem discussion can carry on 
> separately.

Is that the development and merge process along which the LSM subsystem got 
into its current state?

Thanks,

	Ingo
