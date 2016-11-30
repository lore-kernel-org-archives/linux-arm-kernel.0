From: fweimer@redhat.com (Florian Weimer)
Date: Wed, 30 Nov 2016 13:38:28 +0100
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161130120654.GJ1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
Message-ID: <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2016 01:06 PM, Dave Martin wrote:

> I'm concerned here that there may be no sensible fixed size for the
> signal frame.  We would make it ridiculously large in order to minimise
> the chance of hitting this problem again -- but then it would be
> ridiculously large, which is a potential problem for massively threaded
> workloads.

What's ridiculously large?

We could add a system call to get the right stack size.  But as it 
depends on VL, I'm not sure what it looks like.  Particularly if you 
need determine the stack size before creating a thread that uses a 
specific VL setting.

> For setcontext/setjmp, we don't save/restore any SVE state due to the
> caller-save status of SVE, and I would not consider it necessary to
> save/restore VL itself because of the no-change-on-the-fly policy for
> this.

Okay, so we'd potentially set it on thread creation only?  That might 
not be too bad.

I really want to avoid a repeat of the setxid fiasco, where we need to 
run code on all threads to get something that approximates the 
POSIX-mandated behavior (process attribute) from what the kernel 
provides (thread/task attribute).

> I'm not familiar with resumable functions/executors -- are these in
> the C++ standards yet (not that that would cause me to be familiar
> with them... ;)  Any implementation of coroutines (i.e.,
> cooperative switching) is likely to fall under the "setcontext"
> argument above.

There are different ways to implement coroutines.  Stack switching (like 
setcontext) is obviously impacted by non-uniform register sizes.  But 
even the most conservative variant, rather similar to switch-based 
emulation you sometimes see in C coroutine implementations, might have 
trouble restoring the state if it just cannot restore the saved state 
due to register size reductions.

Thanks,
Florian
