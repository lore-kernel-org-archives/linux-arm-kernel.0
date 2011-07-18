From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Jul 2011 13:57:19 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E241E60.7040403@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
	<20110714113625.GB20903@e102144-lin.cambridge.arm.com>
	<4E241E60.7040403@st.com>
Message-ID: <20110718125719.GA7410@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 12:52:00PM +0100, Wolfgang BETZ wrote:
> Hello Will,
> 
> On 07/14/2011 01:36 PM, Will Deacon wrote:
> 
>     Looking again at the structure of your code (FrankH has already pointed out
>     a lot of the implementation issues), perhaps this would be better off as a
>     (configurable) thread notifier which reads the context ID, sets the upper
>     bits (taking care to preserve the ASID) and writes it back.

Wolfgang,

> Yes, there are already trace events in the kernel that can be used to trace a
> thread switch. The patch already uses it for writing the CONTEXTIDR.

No, don't use trace events. Use a thread notifier and when you get
THREAD_NOTIFY_SWITCH you can read the context ID, write the PID to the top
bits and write it back. This will occur after switch_mm so the ASID will
already be in place. You will need to disable interrupts during this so that
you don't get an ASID rollover during the read-modify-write. You will also
need to change switch_mm so that it preserves the upper bits of the context
ID.

> However, this is not enough. The kernel itself writes the CONTEXTIDR (together
> with the wrapper id) *after* the scheduler called the event trace.
> Consequently, in the ETM trace there would be two writes to the CONTEXTIDR
> register, and it would be difficult (or even impossible) to find out, if it was
> the additional write for a thread switch or the original "Linux" write for a
> process switch. That's why a patch to the original writing of the CONTEXTIDR is
> still necessary.
> What do you think about this?

I don't understand the problem here. Seeing two context ID writes in your
event stream is up to your tools to handle. How do you handle ASID rollover
broadcasts where the context ID can be updated at any point? That surely is
far more complicated than the case of a process switch, where we switch the
mm and then write the PID.

I still maintain that you will struggle to get this code past Russell (based
on his previous comments) so keeping the changes to a minimum is in your
best interest if you want to convince him to merge it.

Will
