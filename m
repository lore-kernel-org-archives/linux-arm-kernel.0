From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 27 Feb 2015 13:25:25 -0500
Subject: [RFC PATCH] ARM64: cmpxchg.h: Clear the exclusive access bit on
 fail
In-Reply-To: <20150227100612.GB3628@arm.com>
References: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
 <20150227100612.GB3628@arm.com>
Message-ID: <CAJhHMCC98dPnx=ng3zp5ZZmzOZkdPXaA1bmcQJuhQj9wb7CRhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 5:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Feb 27, 2015 at 05:46:55AM +0000, Pranith Kumar wrote:
>> In cmpxchg(), we do a load exclusive on an address and upon a comparison fail,
>> we skip the store exclusive instruction. This can result in the exclusive bit
>> still set. If there was a store exclusive after this to the same address, that
>> will see the exclusive bit set. This should not happen.
>
> ... and the problem with that is?

Consider the following scenario:

            P0                    P1
            ---------------------------------
            ldxr x7, [B]                         // exclusive bit set
            add  x7, x7, #1
                                str ..., [B]     // exclusive bit cleared
cmpxchg:
            ldxr x0, [B]                         // exclusive bit set
            cmp  x0, #0                        // cmp fails
            b.ne 1f                               // branch taken
            stxr x1, [B]                         // end of cmpxchg
1:
            stxr x7, [B]                        // succeeds?


    The last store exclusive succeeds since the exclusive bit is set which
should not happen. Clearing the exclusive bit before returning from cmpxchg
prevents this happening.

Now I am not sure how likely this will happen. One can argue that a cmpxchg()
will not happen between an external ldxr/stxr. But isn't clearing the exclusive
bit better?

-- 
Pranith
