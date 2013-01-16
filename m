From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 16 Jan 2013 12:20:47 +0530
Subject: [RFC PATCH 3/4] ARM: bL_entry: Match memory barriers to
 architectural requirements
In-Reply-To: <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
 <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
Message-ID: <50F64DC7.6040707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Catalin, RMK

Dave,

On Tuesday 15 January 2013 10:18 PM, Dave Martin wrote:
> For architectural correctness even Strongly-Ordered memory accesses
> require barriers in order to guarantee that multiple CPUs have a
> coherent view of the ordering of memory accesses.
>
> Virtually everything done by this early code is done via explicit
> memory access only, so DSBs are seldom required.  Existing barriers
> are demoted to DMB, except where a DSB is needed to synchronise
> non-memory signalling (i.e., before a SEV).  If a particular
> platform performs cache maintenance in its power_up_setup function,
> it should force it to complete explicitly including a DSB, instead
> of relying on the bL_head framework code to do it.
>
> Some additional DMBs are added to ensure all the memory ordering
> properties required by the race avoidance algorithm.  DMBs are also
> moved out of loops, and for clarity some are moved so that most
> directly follow the memory operation which needs to be
> synchronised.
>
> The setting of a CPU's bL_entry_vectors[] entry is also required to
> act as a synchronisation point, so a DMB is added after checking
> that entry to ensure that other CPUs do not observe gated
> operations leaking across the opening of the gate.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---

Sorry to pick on this again but I am not able to understand why
the strongly ordered access needs barriers. At least from the
ARM point of view, a strongly ordered write will be more of blocking
write and the further interconnect also is suppose to respect that
rule. SO read writes are like adding barrier after every load store
so adding explicit barriers doesn't make sense. Is this a side
effect of some "write early response" kind of optimizations at
interconnect level ?
Will you be able to point to specs or documents which puts
this requirement ?

Regards
santosh
