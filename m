From: mingo@elte.hu (Ingo Molnar)
Date: Tue, 17 May 2011 20:34:59 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <alpine.LRH.2.00.1105172317060.5404@tundra.namei.org>
References: <20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
	<20110516150837.GA513@elte.hu>
	<alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
	<20110517131058.GE21441@elte.hu>
	<alpine.LRH.2.00.1105172317060.5404@tundra.namei.org>
Message-ID: <20110517183459.GB16689@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* James Morris <jmorris@namei.org> wrote:

> On Tue, 17 May 2011, Ingo Molnar wrote:
> 
> > I'm not sure i get your point.
> 
> Your example was not complete as described.  After an apparently simple 
> specification, you've since added several qualifiers and assumptions, [...]

I havent added any qualifiers really (i added examples/description), the opt-in 
method i mentioned in my first mail should be pretty robust:

 | Firstly, using the filter code i deny the various link creation syscalls so 
 | that sandboxed code cannot escape for example by creating a symlink to 
 | outside the permitted VFS namespace. (Note: we opt-in to syscalls, that way 
 | new syscalls added by new kernels are denied by defalt. The current symlink 
 | creation syscalls are not opted in to.)

> [...] and I still doubt that it's complete.

I could too claim that i doubt that the SELinux kernel implementation is 
secure!

So how about we both come up with specific examples about how it's not secure, 
instead of going down the fear-uncertainty-and-doubt road? ;-)

> A higher level goal would look like
> 
> "Allow a sandbox app access only to approved resources, to contain the 
> effects of flaws in the app", or similar.

I see what you mean.

I really think that "restricting sandboxed code to only open files within a 
given VFS namespace boundary" is the most useful highlevel description here - 
which is really a subset of a "allow a sandbox app access only to an easily 
approved set of files" highlevel concept.

There's no "to contain ..." bit here: *all* of the sandboxed app code is 
untrusted, so there's no 'remote attacker' and we do not limit our threat to 
flaws in the app. We want to contain apps to within a small subset of Linux 
functionality, and we want to do that within regular apps (without having to be 
superuser), full stop.

> Note that this includes a threat model (remote attacker taking control of the 
> app) and a general and fully stated strategy for dealing with it.

Attacker does not have to be remote - most sandboxing concepts protect against 
locally installed plugins/apps/applets. In sandboxing the whole app is 
considered untrusted - not just some flaw in it, abused remotely.

> From there, you can start to analyze how to implement the goal, at which 
> point you'd start thinking about configuration, assumptions, filesystem 
> access, namespaces, indirect access (e.g. via sockets, rpc, ipc, shared 
> memory, invocation).

Sandboxed code generally does not have access to anything fancy like that - if 
it is added then all possible side effects have to be examined.

Thanks,

	Ingo
