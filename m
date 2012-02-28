From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Feb 2012 10:55:14 +0000
Subject: [PATCH 3/4] ARM: perf: check that we have an event in the PMU
 IRQ handlers
In-Reply-To: <CACVXFVNVhd_65Kr7h6KEtaOvZ6GmZhA9wz9Xe8z-O2EET=SEGw@mail.gmail.com>
References: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
 <1330012696-13472-4-git-send-email-will.deacon@arm.com>
 <CACVXFVM6HOMeJCMznLqO6-jMT8owoK65Ap6c_CNCJbwWxphCBA@mail.gmail.com>
 <20120224101130.GB13504@mudshark.cambridge.arm.com>
 <20120227175646.7c39e542@tom-ThinkPad-T410>
 <20120227193635.GC24605@mudshark.cambridge.arm.com>
 <CACVXFVNVhd_65Kr7h6KEtaOvZ6GmZhA9wz9Xe8z-O2EET=SEGw@mail.gmail.com>
Message-ID: <20120228105514.GG25625@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 12:53:28AM +0000, Ming Lei wrote:
> On Tue, Feb 28, 2012 at 3:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> > A single 32-bit store is not interruptible in the same way as load/store
> > multiple instructions are, so this isn't a problem.
> 
> In fact, I have tried to look for the similar description in ARMv7 manual, but
> didn't find it unfortunately, so could you point out where it is
> stated explicitly?

It's the section about Single-copy atomicity (3.5.3 in revision C). All word
accesses to word-aligned locations are single-copy atomic. We rely on this
for our atomic_{read,set} implementations.

> >
> >> So suggest to take the correct way in theory, IMO.
> >
> > I don't like checking the used_mask, because then we have to throw in some
> > barriers to ensure ordering between updates of the event arrays and the
> > mask. If we do have to change something, I think putting ACCESS_ONCE around
> 
> Both used_mask and event arrays are defined as percpu variables, so are you sure
> barriers are required for it?

I expect the compiler could still re-order the statements.

I heard back from the tools guys and they say that the store will not be
split up, but may be coalesced with others in the form of a store-multiple.
Referring back to the ARM ARM, that's ok since `each 32-bit word access is
guaranteed to be single-copy atomic'.

So I'm still in favour of the original patch. It's easy to read, fairly minimal
and will work correctly.

Will
