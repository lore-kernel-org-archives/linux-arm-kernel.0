From: b08248@gmail.com (Stuart Yoder)
Date: Mon, 28 Jul 2014 13:40:27 -0500
Subject: EL3 firmware init of cores ( was Re: [PATCH] arm64: Flush the
 process's mm context TLB entries when switching)
Message-ID: <CALRxmdCxnOmZdY=_CCYRT8YYBkVdS-ch6RRbkfZa2B-sF_FkKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 3:02 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 15, 2014 at 03:00:24AM +0100, Ding Tianhong wrote:
>> On 2014/4/14 21:01, Will Deacon wrote:
>> > Hi Ding,
>> >
>> > On Mon, Apr 14, 2014 at 01:03:12PM +0100, Ding Tianhong wrote:
>> >> I met a problem when migrating process by following steps:
>> >>
>> >> 1) The process was already running on core 0.
>> >> 2) Set the CPU affinity of the process to 0x02 and move it to core 1,
>> >>    it could work well.
>> >> 3) Set the CPU affinity of the process to 0x01 and move it to core 0 again,
>> >>    the problem occurs and the process was killed.
>> >
>> > [...]
>> >
>> >> It was a very strange problem that the PC and LR are both 0, and the esr is
>> >> 0x83000006, it means that the used for instruction access generated MMU faults
>> >> and synchronous external aborts, including synchronous parity errors.
>> >>
>> >> I try to fix the problem by invalidating the process's TLB entries when switching,
>> >> it will make the context stale and pick new one, and then it could work well.
>> >>
>> >> So I think in some situation that after the process switching, the modification of
>> >> the TLB entries in the new core didn't inform all other cores to invalidate the old
>> >> TLB entries which was in the inner shareable caches, and then if the process schedule
>> >> to another core, the old TLB entries may occur MMU faults.
>> >
>> > Yes, it sounds like you don't have your TLBs configured correctly. Can you
>> > confirm that your EL3 firmware is configuring TLB broadcasting correctly
>> > please?
>> >
>>
>> Hi will:
>>
>> Do you mean the SCR_EL3.NS?
>
> No, there's usually a CPU-specific register (called something like actlr or
> ectlr) which contains bit(s) to enable TLB broadcasting in hardware. Which
> CPU are you using?

Hi Will,

We ran into this same issue as well for an A57-based system.  We are using
u-boot and it seems that some early EL3 init was missing the setting of the
SMPEN bit.

I'm concerned now that there may be other bits we have missed as well.  Is
there any documentation you know of that details A57 initialization or do we
just have to extract that from the reference manual?

Also, for ARM development systems like the Versatile Express or fast model
is there existing "EL3 firmware" source available that shows how to properly
initialize an A57 that we can refer to?    Any pointer to reference code doing
this initialization would be really appreciated.

Thanks,
Stuart Yoder
Freescale
