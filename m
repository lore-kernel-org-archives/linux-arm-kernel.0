From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Jan 2017 14:50:23 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <20170130141308.GV27312@n2100.armlinux.org.uk>
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost> <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <20170130141308.GV27312@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2017 at 14:13, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Sun, Jan 22, 2017 at 01:01:53PM +0000, Ard Biesheuvel wrote:
>> Emulating unaligned access in the ARM kernel was a mistake: it even
>> emulates unaligned accesses for instructions like ldm and ldrd, which
>> require word alignment at the hardware level even in the latest v8
>> version of the architecture. In contrast, the v8 deprecation warnings
>> are about enforcing compliance.
>
> Ard, you're totally wrong on the unaligned access thing.  Unaligned
> accesses are a fundamental requirement of the kernel's networking
> stack.  If you don't have support for unaligned accesses, then you
> don't have network support - it's as simple as that.
>
> So, in order for ARMv5 and earlier to have network support, there
> was no option to add support for emulating those accesses.
>

I wasn't aware of that. But does that mean it is simply too much work
to remove those alignment assumptions? It does not seem like a
fundamental networking issue to me, but rather a tacit assumption that
has infected the software implementation.

> The dubious thing was whether to add that for userspace as well.
> Since soo many applications were broken at the time, and ARM wasn't
> a sufficiently large community for the applications people to care
> one shit about, the applications people weren't going to fix their
> code to avoid unaligned accesses.
>
> So, back in the 1990s, we were stuck between having broken userspace
> and a huge amount of effort needed to maintain ARM specific patches
> out of tree for lots of applications, or functional userspace.
>

I see. I was indeed mainly referring to userspace, which is what this
thread is about, specifically setend and the CP15 barrier
instructions. You can disagree with ARM's policy to deprecate and
remove some instructions, but given the reality of it, I think it is
perfectly reasonable to warn by default about setend instructions
issued in 32-bit userspace when running under the 64-bit ARMv8 kernel.

> Today, the ARM architecture has moved on a long way, and application
> people care about whether their stuff works on the ARM architecture.
> It wasn't like that when the unaligned emulation was added.
>
> It was not a mistake.  It's one of the reasons why ARM has got where
> it is today, and probably why the light was finally seen to add
> hardware support for unaligned accesses to the later CPU architectures.
>

OK, I stand corrected. I haven't been around nearly as long as Russell
or some others here on LAKML, so I don't have the historical
background. On the arm64 side, it is *much* easier to take a normative
stance, given how new it is.
