From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 May 2014 14:27:54 +0100
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <20140515120152.7b0beb37@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqJy=dYpVFbgjGVRHrgwfaB7dkJVGazpfjf9qf7Z9poJuw@mail.gmail.com>
 <20140515120152.7b0beb37@free-electrons.com>
Message-ID: <20140515132754.GG27594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:01:52AM +0100, Thomas Petazzoni wrote:
> On Wed, 14 May 2014 12:07:28 -0500, Rob Herring wrote:
> 
> > > This hardware I/O coherency mechanism needs a set of ARM core
> > > requirements to operate properly:
> > >
> > >  * On Armada 370 (a single core processor)
> > >
> > >    - The cache policy of pages must be set to "write allocate".
> > 
> > Why do we want !SMP to be no write allocate in the first place? Seems
> > like we should always enable write-allocate at least for v7.
> 
> Ok, seems like it matches the suggestion from Catalin. I've sent a
> quick patch in my reply to Catalin, if you could have a look and tell
> if it's OK, I can use that in my next version.

It's probably also worth mentioning in your commit log that modern ARM CPUs
can change the allocation policy dynamically based on the access pattern
(e.g. switch to no-allocate when there is a series of streaming stores), so
historical reasons for forcing write-no-allocate aren't applicable on these
cores.

> I really don't see any justification for why it some situations the
> bootloader would be responsible for it, and why in some other
> situations the kernel would be responsible for it.

Well, for better or worse, we are moving in the direction of Linux running
non-secure with a non-trivial amount of higher privileged software running
in the system. We can use this as a basis to decide whether or not Linux
should be setting configuration bits by looking at whether or not these bits
are accessible from non-secure svc mode.

I'm not denying that we've not been following this rule in the past, but
given where we're going with ARMv8 and arm64, the sooner people realise that
the firmware and bootloader have some duties in the way of system
configuration, then the less pain they will have later on when they try to
boot Linux.

Will
