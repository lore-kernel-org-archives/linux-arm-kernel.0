From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 26 Sep 2018 09:21:23 -0700
Subject: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
In-Reply-To: <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
Message-ID: <D93C2C15-DC70-4A95-9350-AD4036C9556A@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Sep 26, 2018, at 7:02 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> (+ Herbert, Thomas)
> 
>> On Wed, 26 Sep 2018 at 15:33, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> 
>> Hi Ard,
>> .
> 
>> And if it becomes one,
>> this is something we can address *later*, but certainly there's no use
>> of adding additional complexity to the initial patchset to do this
>> now.
>> 
> 
> You are introducing a very useful SIMD abstraction, but it lets code
> run with preemption disabled for unbounded amounts of time, and so now
> is the time to ensure we get it right.
> 
> Part of the [justified] criticism on the current state of the crypto
> API is on its complexity, and so I don't think it makes sense to keep
> it simple now and add the complexity later (and the same concern
> applies to async support btw).

Are, is what you?re saying that the Zinc chacha20 functions should call simd_relax() every n bytes automatically for some reasonable value of n?  If so, seems sensible, except that some care might be needed to make sure they interact with preemption correctly.

What I mean is: the public Zinc entry points should either be callable in an atomic context or they should not be.  I think this should be checked at runtime in an appropriate place with an __might_sleep or similar.  Or simd_relax should learn to *not* schedule if the result of preempt_enable() leaves it atomic. (And the latter needs to be done in a way that works even on non-preempt kernels, and I don?t remember whether that?s possible.). And this should happen regardless of how many bytes are processed. IOW, calling into Zinc should be equally not atomic-safe for 100 bytes and for 10 MB.

As for async, ISTM a really good WireGuard accelerator would expose a different interface than crypto API supports, and it probably makes sense to wait for such hardware to show up before figuring out how to use it.  And no matter what form it takes, I don?t think it should complicate the basic Zinc crypto entry points.
