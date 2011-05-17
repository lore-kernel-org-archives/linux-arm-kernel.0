From: mingo@elte.hu (Ingo Molnar)
Date: Tue, 17 May 2011 14:57:00 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <BANLkTimcYyTxUDN4QysyOitTJYJP9ZavZA@mail.gmail.com>
References: <20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<1305299455.2076.26.camel@localhost.localdomain>
	<20110514073015.GB9307@elte.hu>
	<BANLkTi=1CBKevjg3+fYFZF9zWtQVw-W9hQ@mail.gmail.com>
	<20110516124304.GC7128@elte.hu>
	<BANLkTimcYyTxUDN4QysyOitTJYJP9ZavZA@mail.gmail.com>
Message-ID: <20110517125700.GD21441@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Will Drewry <wad@chromium.org> wrote:

> > This is *far* more generic still yields the same short-term end result as 
> > far as your sandboxing is concerned.
> 
> Almost :/ [...]

Hey that's a pretty good result from a subsystem that was not written with your 
usecase in mind *at all* ;-)

> [...]  I still need to review the code you've pointed out, but, at present, 
> the ftrace hooks occur after the seccomp and syscall auditing hooks.  This 
> means that that code is exposed no matter what in this model.  To trim the 
> exposed surface to userspace, we really need those early hooks.  While I can 
> see both hacky and less hacky approaches around this, it stills strikes me 
> that the seccomp thread flag and early interception are good to reuse.  One 
> option might be to allow seccomp to be a secure-syscall event source, but I 
> suspect that lands more on the hack-y side of the fence :)

Agreed, there should be no security compromise imposed on your usecase, at all.

You could move the event callback sooner into the syscall-entry sequence to 
make sure it's the highest priority thing to process?

There's no semantic dependency on its current location so this can be changed 
AFAICS.

Thanks,

	Ingo
