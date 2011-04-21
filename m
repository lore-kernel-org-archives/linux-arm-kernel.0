From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Apr 2011 15:35:31 +0100
Subject: [PATCH] ARM: futex: add SMP futex support when !CPU_USE_DOMAINS
In-Reply-To: <alpine.LFD.2.00.1104201329520.24613@xanadu.home>
References: <1302267519-18156-1-git-send-email-will.deacon@arm.com>
	<1303313347.11314.4.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1104201329520.24613@xanadu.home>
Message-ID: <003201cc0031$5dd242c0$1976c840$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> On Wed, 20 Apr 2011, Will Deacon wrote:
> 
> > On Fri, 2011-04-08 at 13:58 +0100, Will Deacon wrote:
> > > This patch uses the load/store exclusive instructions to add SMP futex
> > > support for ARM.
> > >
> > > Since the ARM architecture does not provide instructions for
> > > unprivileged exclusive memory accesses, we can only provide SMP futexes
> > > when CPU domain support is disabled.
> > >
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/include/asm/futex.h |  137 +++++++++++++++++++++++++++--------------
> > >  1 files changed, 90 insertions(+), 47 deletions(-)
> >
> > Any comments on this patch? The LTP tests for {get,set}_robust_list seem
> > happy enough but any review would be welcome.
> 
> I looked at http://article.gmane.org/gmane.linux.ports.arm.kernel/81847
> back then, and one issue I found with that version was the fact that the
> #ifdef condition were wrong (not depending on !CONFIG_CPU_USE_DOMAINS.

Yes, I only noticed that patch after I'd written my version. Actually,
after looking at the current state of the domains code, I don't understand
why we have CONFIG_CPU_USE_DOMAINS at all since the definition of __range_ok
checks the address regardless of domain usage.
 
> Your version looks better though, just by looking at the net amount of
> lines added.

Ha, that's certainly the metric of the moment! I might be able to make
the exception table macros cleaner by taking some labels as arguments,
but I'm not sure if it's worth it or not.

Cheers,

Will
