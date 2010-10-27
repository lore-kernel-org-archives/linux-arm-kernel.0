From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Oct 2010 14:33:00 +0100
Subject: PL310 and QoS logic
In-Reply-To: <AANLkTim2zXNP976TyWAQX+qTr4D2+0f_UzDEgYGo1MLf@mail.gmail.com>
References: <4C56D9DC.9010008@st.com>
	<AANLkTi=tbFt9TyRL2oTDvgJu9BAxsc=mrpApCCMuQdrd@mail.gmail.com>
	<AANLkTim2zXNP976TyWAQX+qTr4D2+0f_UzDEgYGo1MLf@mail.gmail.com>
Message-ID: <1288186380.17877.75.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-27 at 14:09 +0100, shiraz hashim wrote:
> We were going through ARM PL310 errata list and we came across bug
> #738415, which says
> "738415:   A cacheable read with address bits [20:5] equal to 0x0000
> can be stalled by non-cacheable read traffic targeting other address
> region 2"
> 
> We believe this could be one of the potential problems which we are
> facing, and the
> errata says the implication could be that there could be a deadlock if
> there are dependent
> reads.
> 
> Now, how do we ensure that this is the root cause. What is the best
> way in which I
> can prevent kernel from using cache-lines at each 2MB boundary.
> Have you come across this bug? Any information would be really helpful.

I think more information or conditions for this to happen can be given
by support at arm.com. I don't know the hardware details around this.

In general you don't have any cacheable/non-cacheable dependent reads in
Linux to be able to trigger the deadlock. That's a situation where one
CPU is polling some non-cacheable memory location and a different CPU
cannot continue. The only situation I'm aware of is during secondary CPU
booting or if you boot Linux with CPU with a maxcpus less than the total
number of CPUs (so some of them keep polling the pen_release even at
run-time). But that's easily solvable with a WFE in the pen polling loop
(if your platform has such booting protocol).

On the RealView platforms, the secondary CPUs are waiting in a WFI in
the boot monitor code and waken up one by one via an IPI, so they don't
usually wait in the pen polling loop.

If you want to prevent such memory from being used, you can hack the
memory initialisation code in Linux to reserve a 4K physical page for
every 2MB.

Catalin
