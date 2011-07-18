From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Jul 2011 18:09:52 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E24446C.4060204@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
	<20110714113625.GB20903@e102144-lin.cambridge.arm.com>
	<4E241E60.7040403@st.com>
	<20110718125719.GA7410@e102144-lin.cambridge.arm.com>
	<4E24446C.4060204@st.com>
Message-ID: <20110718170952.GC7410@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 03:34:20PM +0100, Wolfgang BETZ wrote:
> Hi Will,
> 
> On 07/18/2011 02:57 PM, Will Deacon wrote:
> 
>     No, don't use trace events. Use a thread notifier and when you get
>     THREAD_NOTIFY_SWITCH you can read the context ID, write the PID to the top
>     bits and write it back. This will occur after switch_mm so the ASID will
>     already be in place. You will need to disable interrupts during this so that
>     you don't get an ASID rollover during the read-modify-write. You will also
>     need to change switch_mm so that it preserves the upper bits of the context
>     ID.
> 
> OK, I think I understood now your idea and do believe that this would be
> feasible absolutely from the kernel's point of view.

Good stuff.

> 
>         However, this is not enough. The kernel itself writes the CONTEXTIDR (together
>         with the wrapper id) *after* the scheduler called the event trace.
>         Consequently, in the ETM trace there would be two writes to the CONTEXTIDR
>         register, and it would be difficult (or even impossible) to find out, if it was
>         the additional write for a thread switch or the original "Linux" write for a
>         process switch. That's why a patch to the original writing of the CONTEXTIDR is
>         still necessary.
>         What do you think about this?
> 
>     I don't understand the problem here. Seeing two context ID writes in your
>     event stream is up to your tools to handle. How do you handle ASID rollover
>     broadcasts where the context ID can be updated at any point? That surely is
>     far more complicated than the case of a process switch, where we switch the
>     mm and then write the PID.
> 
> Well, the tools are not interested in the ASID at all, they are interested in
> getting a correct PID representing a real thread. Therefore ASID rollover isn't
> a problem for the tools, while I think that the major problem with your
> solution is, how a tool can distinguish between a "fake" PID which is used for
> ASID rollover handling and a real PID as written by the notifier. Honestly, I
> would not know how to do this :-(   ... any idea would be welcome.

We don't use fake PIDs for anything. The only thing that can go wrong is
during task switch where we switch the mm and then switch the PID in your
thread notifier. Reading the context ID between these two points will give
you the PID of the previous task. I don't think this is a big problem since
we're in the middle of context switch anyway, so it's hard to define when
the thread switch has completed. You just have to be aware that the
current mm_struct / ASID may not correspond to the PID. One nice property is
that you can be sure the PID is correct once you've returned to userspace.

Will
