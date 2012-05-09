From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 May 2012 10:57:28 +0100
Subject: [PATCH] Prevent process migration during vfp_init()
In-Reply-To: <20120509092650.GR26481@n2100.arm.linux.org.uk>
References: <CAOsG7tqktqxxU9gtyqojP7KP87cy1jpgT8H==wOe0cQj8=LV+Q@mail.gmail.com>
 <20120508111332.GG2263@mudshark.cambridge.arm.com>
 <CAOsG7tqr__yWp1zmMfy3myRGFmY690f8i8emuXq5d7E=o3E7Vw@mail.gmail.com>
 <20120508180430.GL2263@mudshark.cambridge.arm.com>
 <20120509092650.GR26481@n2100.arm.linux.org.uk>
Message-ID: <20120509095727.GA7779@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 10:26:50AM +0100, Russell King - ARM Linux wrote:
> On Tue, May 08, 2012 at 07:04:30PM +0100, Will Deacon wrote:
> > It seems happy enough on my quad A9 running a bunch of paranoia FP tests --
> > do you have a particular testcase which was exhibiting this failure when you
> > reported the issue?
> 
> It's pointless doing FP tests for this level of change - the code you're
> modifying is only run at startup to enable access to VFP.  If you can
> execute a single VFP instruction in userspace on each CPU, then your test
> has passed.  Further VFP instructions do not gain you any additional test
> coverage.

Agreed -- I ran the tests to ensure that we did execute user VFP instructions
on each CPU since I'm not sure how VFPified my basic userspace is.

> The only comment I have is whether that BUG_ON(preemptible()) - preferably
> WARN_ON() - should be inside get_copro_access() itself, in a similar way
> to smp_processor_id().

I guess the BUG vs WARN debate comes down to what the consequences are of
continuing if we are preemptible. In the latter case, don't we leave
ourselves open to kernel exceptions if we try to migrate a VFP-using thread
onto a CPU without the co-processor permissions set correctly? From a
debugging point-of-view, the BUG_ON might then be more informative. Why do
you prefer WARN for this?

We could move the BUG/WARN into get_copro_access, although it will likely be
used as a pair with set_copro_access so really we want the preempt check to
be across the two calls.

Cheers,

Will
