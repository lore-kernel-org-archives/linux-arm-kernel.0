From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 10:26:50 +0100
Subject: [PATCH] Prevent process migration during vfp_init()
In-Reply-To: <20120508180430.GL2263@mudshark.cambridge.arm.com>
References: <CAOsG7tqktqxxU9gtyqojP7KP87cy1jpgT8H==wOe0cQj8=LV+Q@mail.gmail.com>
 <20120508111332.GG2263@mudshark.cambridge.arm.com>
 <CAOsG7tqr__yWp1zmMfy3myRGFmY690f8i8emuXq5d7E=o3E7Vw@mail.gmail.com>
 <20120508180430.GL2263@mudshark.cambridge.arm.com>
Message-ID: <20120509092650.GR26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 07:04:30PM +0100, Will Deacon wrote:
> On Tue, May 08, 2012 at 06:24:27PM +0100, Hyungwoo Yang wrote:
> > I think we don't need preempt_disable()/preempt_enable() call in your proposal.
> > I mean, since we have enabled on every VFPs in cores online(
> > on_each_cpu() ), we don't need to worry about accessing a VFP which is
> > disabled. So we don't need to worry about migration after
> > "on_each_cpu()", right?
> 
> Yes, that sounds reasonable to me since any thread migration will imply the
> barriers we need for the VFP exception vector to be correct. In which case the
> patch can be further reduced to what I've got below.
> 
> It seems happy enough on my quad A9 running a bunch of paranoia FP tests --
> do you have a particular testcase which was exhibiting this failure when you
> reported the issue?

It's pointless doing FP tests for this level of change - the code you're
modifying is only run at startup to enable access to VFP.  If you can
execute a single VFP instruction in userspace on each CPU, then your test
has passed.  Further VFP instructions do not gain you any additional test
coverage.

The only comment I have is whether that BUG_ON(preemptible()) - preferably
WARN_ON() - should be inside get_copro_access() itself, in a similar way
to smp_processor_id().
