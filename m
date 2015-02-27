From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Feb 2015 18:33:01 +0000
Subject: [RFC PATCH] ARM64: cmpxchg.h: Clear the exclusive access bit on
 fail
In-Reply-To: <CAJhHMCC98dPnx=ng3zp5ZZmzOZkdPXaA1bmcQJuhQj9wb7CRhw@mail.gmail.com>
References: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
 <20150227100612.GB3628@arm.com>
 <CAJhHMCC98dPnx=ng3zp5ZZmzOZkdPXaA1bmcQJuhQj9wb7CRhw@mail.gmail.com>
Message-ID: <20150227183301.GL17949@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 06:25:25PM +0000, Pranith Kumar wrote:
> On Fri, Feb 27, 2015 at 5:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Feb 27, 2015 at 05:46:55AM +0000, Pranith Kumar wrote:
> >> In cmpxchg(), we do a load exclusive on an address and upon a comparison fail,
> >> we skip the store exclusive instruction. This can result in the exclusive bit
> >> still set. If there was a store exclusive after this to the same address, that
> >> will see the exclusive bit set. This should not happen.
> >
> > ... and the problem with that is?
> 
> Consider the following scenario:
> 
>             P0                    P1
>             ---------------------------------
>             ldxr x7, [B]                         // exclusive bit set
>             add  x7, x7, #1
>                                 str ..., [B]     // exclusive bit cleared
> cmpxchg:
>             ldxr x0, [B]                         // exclusive bit set
>             cmp  x0, #0                        // cmp fails
>             b.ne 1f                               // branch taken
>             stxr x1, [B]                         // end of cmpxchg
> 1:
>             stxr x7, [B]                        // succeeds?

It's either badly formatted or I don't get it. Are the "stxr x1" and
"stxr x7" happening on the same CPU (P0)? If yes, that's badly written
code, not even architecturally compliant (you are not allowed other
memory accesses between ldxr and stxr).

>     The last store exclusive succeeds since the exclusive bit is set which
> should not happen. Clearing the exclusive bit before returning from cmpxchg
> prevents this happening.
> 
> Now I am not sure how likely this will happen. One can argue that a cmpxchg()
> will not happen between an external ldxr/stxr. But isn't clearing the exclusive
> bit better?

The only way cmpxchg() could happen between a different ldxr/stxr is
during an interrupt. But ERET automatically clears the exclusive
monitor, so the "stxr x7" would not succeed.

-- 
Catalin
