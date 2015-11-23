From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 15:41:22 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <56532748.4010508@redhat.com>
References: <564CA29A.9050905@arm.com> <20151118162932.GA13355@leverpostej>
 <564CB1DA.4090304@arm.com> <20151118180434.GB13355@leverpostej>
 <564CD206.9040402@arm.com> <20151119112923.GA24570@leverpostej>
 <20151120195243.GC14942@leverpostej>
 <20151123121514.GB32300@e104818-lin.cambridge.arm.com>
 <20151123134911.GB28293@leverpostej> <56532748.4010508@redhat.com>
Message-ID: <20151123154122.GG4236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy,

On Mon, Nov 23, 2015 at 08:48:40AM -0600, Jeremy Linton wrote:
> On 11/23/2015 07:49 AM, Mark Rutland wrote:
> >Jeremy, for reference, have you tried kasan on m400? Or DEBUG_RODATA?
> 
> No, because the machine has a list of issues that keep it from booting a
> mainline kernel in a functional state. Once those are cleared up I will
> revisit this patch.
> 
> The goal was to create a conceptually safe fix for the problem, which isn't
> all this hypothetical stuff being discussed, but the fact that the TLBs are
> not being flushed properly (with or without the CONT bit stuff) resulting in
> a tlb conflict fault long after this code path has finished executing.

I appreciate that you just want to get something working, and we've
established that a TLBIALL probably does solve the problem, however there's
more to it than that.

If we start adding TLBI/DSB/ISB/NOP/cache flush/read from config space
type operations in arbitrary places, we run a very real risk of masking
future bugs. Then, when the original problem that prompted the temporary
bodge is fixed properly, we uncover a whole raft of problems that we didn't
even realise were there. Consequently, we get stuck with the bodge forever
and, crucially, we lose the ability to reason about the state of the CPU
under Linux. That reasoning is incredibly useful when developing new
architectural features, debugging, profiling or assessing whether or
not Linux is susceptible to hardware errata and is precisely why the
"hypothetical stuff" matters.

For these reasons, we have no viable option other than reverting the
offending series until the underlying problem is fixed properly. With
any luck, that's the 4.5 timeframe so we really only lose a single
release (providing that you have time to rebase and repost).

Sorry about this; I hope it doesn't dissuade you from reporting bugs in
the future.

Will
