From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 11 Jul 2011 18:00:46 +0100
Subject: ARM cortex A9 performance issue
In-Reply-To: <CAE_nTV4t64A7JGN117Pkg1dmqnEvPFkE1AqoyRbeVhN3dN1Q8g@mail.gmail.com>
References: <CAE_nTV4VgcNB0gc64zEPEfHp-hnDBsw6QsM=GqEObXAwzMTzTA@mail.gmail.com>
	<20110707152740.GG2486@arm.com>
	<CAE_nTV7PuEJx0WJKCtbGU-4HjEBzFxPRmPLue1toktS27Htbzg@mail.gmail.com>
	<20110708133315.GB2115@arm.com>
	<CAE_nTV4t64A7JGN117Pkg1dmqnEvPFkE1AqoyRbeVhN3dN1Q8g@mail.gmail.com>
Message-ID: <20110711170032.GA3137@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 01:56:35PM +0530, rd bairva wrote:
> Attaching the new code.
> 
> On Fri, Jul 8, 2011 at 7:03 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > On Fri, Jul 08, 2011 at 05:08:38PM +0530, rd bairva wrote:
> >> Now i have modified a source a little bit. Now I am doing a pingpong
> >> using msgsnd and msgrcv. using this I am getting 40000req/sec and 55%
> >> CPU usage.
> >> In another version I have taken the same lock in both the processes to
> >> ensure same thread is unlocking the mutex. But CPU usage is 100%.
> >> Shouldn't be the behaviour 50%.
> >
> > Possibly. ?Do you see that behaviour on all platforms, or just A9?
> On single processor it is always 100% on ARM as well as X86. but on
> X86, cpu is >50% free.

For me, on x86:

With WITH_MSG, the test consumes about 56-57% on two CPUs.
Without WITH_MSG, the test consumes about 59-60% on two CPUs.

(as reported by running top during the test)

For me, this is as expected: there is some latency involved in signalling
between CPUs, so there should be a bit less than 50% of useful work per
CPU.  However, there is overhead in both process, and this can parallelise
against the signalling latency, giving an overall load of a bit more than
50% per CPU.  The total is about the same on each CPU, since both processes
are doing essentially the same thing.

I quickly hacked up a completely different implementation using pthreads
condition variables to signal between threads and got similar results (though
with a bit more CPU load).

Someone borrowed by pandaboard, but I'll try on there when I get a chance...

Cheers
---Dave

-------------- next part --------------
A non-text attachment was scrubbed...
Name: pingpong.c
Type: text/x-csrc
Size: 3602 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110711/18ac98eb/attachment.bin>
