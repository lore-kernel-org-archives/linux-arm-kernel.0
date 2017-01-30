From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Jan 2017 09:39:48 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <CAKv+Gu_jEvKdWFWB2Ofxb5ruoTYUEt1puZXBb=9Cn2kEOZO1hg@mail.gmail.com>
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost> <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <20170130141308.GV27312@n2100.armlinux.org.uk>
 <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
 <20170130165837.GE27312@n2100.armlinux.org.uk>
 <CAKv+Gu_jEvKdWFWB2Ofxb5ruoTYUEt1puZXBb=9Cn2kEOZO1hg@mail.gmail.com>
Message-ID: <877f5cih0b.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

> On 30 January 2017 at 16:58, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Mon, Jan 30, 2017 at 02:50:23PM +0000, Ard Biesheuvel wrote:
> [..]
>>> I see. I was indeed mainly referring to userspace, which is what this
>>> thread is about, specifically setend and the CP15 barrier
>>> instructions. You can disagree with ARM's policy to deprecate and
>>> remove some instructions, but given the reality of it, I think it is
>>> perfectly reasonable to warn by default about setend instructions
>>> issued in 32-bit userspace when running under the 64-bit ARMv8 kernel.
>>
>> Linus has commented on this in the past, and his reaction (iirc) was
>> that deprecating instructions that userspace uses is not a sane
>> behaviour, pointing out that instructions that i386 supported still
>> work today on the latest Intel CPUs.
>>
>> He has a point, it's the same argument against breaking userspace
>> through making a change to the kernel.  It gives users a painful
>> experience.
>>
>> That said, no one expects that you can run an i386 binary on ARM,
>> which is pretty much understood by users.  However, ARM vs ARM64
>> where ARM64 provides a 32-bit ARM compatible environment is a
>> totally different story - it's _not_ compatible if it complains
>> about instructions that _were_ legal with 32-bit ARM binaries.
>> It makes me question the value of providing what is an incompatible
>> environment to run older binaries.
>>
>> The purpose of such an environment is to provide _compatibility_ to
>> older binaries.  You aren't providing a compatible environment if
>> you then decide to noisily warn about deprecated instructions.
>>
>> You might as well just rebuild the binaries for a 64-bit environment
>> and stop the illusion of a 32-bit compatible environment, because it
>> isn't.
>>
>
> Well, the question is really how to deal with 32-bit compatibility
> given the fact that the ARM architecture will drop such instructions
> in its next revision. Whether we agree with that, and whether we
> should argue our positions with the architects if we don't is not
> relevant here.
>
> What is relevant is whether we inform userspace if we spot such a
> deprecated instruction, and I think we should.
>
> Note that this is not only an issue for the arm64 kernel. The 32-bit
> kernel will have the exact same issue when you try to run it on
> hardware that no longer has support for those instructions.

It sounds like you should not expose a 32-bit compat environment on
future systems without all the 32-bit instructions.  I don't see why a
future processor not having compatibility means we need to break binary
compatiblity by default for today's processors.  And yes, spamming dmesg
is definitely breakage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/81bc62e7/attachment.sig>
