From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2012 16:55:17 +0000
Subject: [PATCH 1/1] ARM: oprofile: add A5/A7/A15 entries in op_perf_name
In-Reply-To: <20121120163158.GO2504@rric.localhost>
References: <1351853016-4476-1-git-send-email-jgq516@gmail.com>
 <20121105113102.GF3351@mudshark.cambridge.arm.com>
 <20121120121747.GJ2504@rric.localhost>
 <20121120155717.GD26475@mudshark.cambridge.arm.com>
 <20121120163158.GO2504@rric.localhost>
Message-ID: <20121120165517.GC27765@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 04:31:58PM +0000, Robert Richter wrote:
> On 20.11.12 15:57:17, Will Deacon wrote:
> > On Tue, Nov 20, 2012 at 12:17:47PM +0000, Robert Richter wrote:
> > > 
> > > since this is just an update of cpu detection I would be willing to
> > > include this into kernel code anyway.
> > 
> > Perhaps, but one day we might like to remove this compatibility layer as
> > tools move over to the perf system call, so adding new CPUs here is actively
> > going against that.
> 
> This would help people to use oprofile as they did before with legacy
> oprofile tools. There is not much effort to keep oprofile kernel
> support for these tools if in-kernel perf_event support exists for new
> hardware. As this is not much effort to maintain, we could keep
> supporting this.  Forcing users to use operf since this is the only
> way to connect to newer hardware might not be what they want.

For arch/arm/, yes, it's not a lot of work but I'm thinking more of things
like heterogeneous multi-core (big/little) and arm64, which we definitely
don't want to deal with in the old tools.

I think newer hardware really will require operf.

> > > We could further move the cpu detection to userspace if perf_event
> > > exists. We let the kernel enable oprofile with cpu_type="unknown".
> > > User space then could either bind mount the file (user could do this
> > > manually) or we implement to write to cpu_type. Doing so oprofile
> > > could use in-kernel perf_events if it exists always as fallback.
> > 
> > Not sure I follow you... operf already does the CPU detection from
> > userspace, so I guess that code could simply be re-used. What does the bind
> > mount involve?
> 
> I am thinking of the following:
> 
>  # cat /root/cpu_type
>  arm/armv7-ca5
>  # cat /dev/oprofile/cpu_type
>  unknown
>  # mount --bind /root/cpu_type /dev/oprofile/cpu_type
>  # cat /dev/oprofile/cpu_type
>  arm/armv7-ca5
> 
> From here legacy oprofile tools work as expected using oprofilefs. (I
> think. Did not test it.) We need to change the kernel for this a bit
> to return 'unknown'. The mount could be done by the oprofile tools
> using existing cpu detection code. This is only one way to setup
> cpu_type from userland, there could be other ways too.

Ok, this is functionally equivalent to the patch that was submitted at the
start of this thread: it solves the problem of mapping a single ARM core to
a oprofile's CPU ID string. Technically, I don't mind doing that in the
kernel (at least, it means you don't need to do your trick above) but going
forward it *will* fall apart and people will have to move to newer tools.

So the question is: do we want to migrate users now or later?

Cheers,

Will
