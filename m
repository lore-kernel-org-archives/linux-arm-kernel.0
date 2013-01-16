From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Jan 2013 15:37:05 +0000
Subject: [RFC PATCH 3/4] ARM: bL_entry: Match memory barriers to
 architectural requirements
In-Reply-To: <20130116150533.GA31318@arm.com>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
 <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
 <50F64DC7.6040707@ti.com> <20130116150533.GA31318@arm.com>
Message-ID: <20130116153705.GD1963@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 03:05:34PM +0000, Catalin Marinas wrote:
> Santosh,
> 
> On Wed, Jan 16, 2013 at 06:50:47AM +0000, Santosh Shilimkar wrote:
> > On Tuesday 15 January 2013 10:18 PM, Dave Martin wrote:
> > > For architectural correctness even Strongly-Ordered memory accesses
> > > require barriers in order to guarantee that multiple CPUs have a
> > > coherent view of the ordering of memory accesses.
> > >
> > > Virtually everything done by this early code is done via explicit
> > > memory access only, so DSBs are seldom required.  Existing barriers
> > > are demoted to DMB, except where a DSB is needed to synchronise
> > > non-memory signalling (i.e., before a SEV).  If a particular
> > > platform performs cache maintenance in its power_up_setup function,
> > > it should force it to complete explicitly including a DSB, instead
> > > of relying on the bL_head framework code to do it.
> > >
> > > Some additional DMBs are added to ensure all the memory ordering
> > > properties required by the race avoidance algorithm.  DMBs are also
> > > moved out of loops, and for clarity some are moved so that most
> > > directly follow the memory operation which needs to be
> > > synchronised.
> > >
> > > The setting of a CPU's bL_entry_vectors[] entry is also required to
> > > act as a synchronisation point, so a DMB is added after checking
> > > that entry to ensure that other CPUs do not observe gated
> > > operations leaking across the opening of the gate.
> > >
> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > Sorry to pick on this again but I am not able to understand why
> > the strongly ordered access needs barriers. At least from the
> > ARM point of view, a strongly ordered write will be more of blocking
> > write and the further interconnect also is suppose to respect that
> > rule. SO read writes are like adding barrier after every load store
> > so adding explicit barriers doesn't make sense. Is this a side
> > effect of some "write early response" kind of optimizations at
> > interconnect level ?
> 
> SO or Device memory accesses are *not* like putting a proper barrier
> between each access, though it may behave in some situations like having
> a barrier. The ARM ARM (A3.8.3, fig 3.5) defines how accesses must
> *arrive* at a peripheral or block of memory depending on the memory type
> and in case of Device or SO we don't need additional barriers because
> such accesses would *arrive* in order (given the minimum 1KB range
> restriction). But it does not say anything about *observability* by a
> different *master*. That's because you can't guarantee that your memory
> accesses go to the same slave port.
> 
> For observability by a different master, you need an explicit DMB even
> though the memory type is Device or SO. While it may work fine in most
> cases (especially when the accesses by various masters go to the same
> slave port), you can't be sure what the memory controller or whatever
> interconnect do.
> 
> As Dave said, it's more about what the ARM ARM doesn't say rather than
> what it explicitly states.

OK, so I talked to one of the ARM architects and he strongly recommends
having the DMBs.

The fact that SO accesses are shareable guarantees a coherent view of
access order only per memory location (i.e., per address), _not_
per slave.  This is what was missing from my original assumption.

For different memory locations, even within a single block of memory,
you don't get that guarantee about what other masters see, except for
the precise documented situations where there are address, control,
or data dependencies between instructions which imply a particular
observation order by other masters.  (See A3.8.2, Ordering requirements
for memory accesses).

For this locking code, we're concerned about ordering between different
memory locations in almost all instances, so most or all of the
barriers will be needed, for strict correctness.

Cheers
---Dave
