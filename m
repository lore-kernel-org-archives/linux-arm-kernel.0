From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 16:58:37 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost>
 <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <20170130141308.GV27312@n2100.armlinux.org.uk>
 <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
Message-ID: <20170130165837.GE27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 02:50:23PM +0000, Ard Biesheuvel wrote:
> On 30 January 2017 at 14:13, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Sun, Jan 22, 2017 at 01:01:53PM +0000, Ard Biesheuvel wrote:
> >> Emulating unaligned access in the ARM kernel was a mistake: it even
> >> emulates unaligned accesses for instructions like ldm and ldrd, which
> >> require word alignment at the hardware level even in the latest v8
> >> version of the architecture. In contrast, the v8 deprecation warnings
> >> are about enforcing compliance.
> >
> > Ard, you're totally wrong on the unaligned access thing.  Unaligned
> > accesses are a fundamental requirement of the kernel's networking
> > stack.  If you don't have support for unaligned accesses, then you
> > don't have network support - it's as simple as that.
> >
> > So, in order for ARMv5 and earlier to have network support, there
> > was no option to add support for emulating those accesses.
> >
> 
> I wasn't aware of that. But does that mean it is simply too much work
> to remove those alignment assumptions? It does not seem like a
> fundamental networking issue to me, but rather a tacit assumption that
> has infected the software implementation.

When it first came up, it was discussed, and the reaction from the
networking people is that they were not going to accept any patches
that "fixed" the networking code for this issue.

They later added the NET_IP_ALIGN thing to offset received ethernet
packets by two bytes to align the 32-bit addresses in the IP header
to a natural 32-bit word boundary, which gave a performance improvement
on many platforms.  I see there has been some discussion about removing
this as there's some evidence in the opposite direction (which will
then mean that the networking stack will be pretty much guaranteed to
make unaligned accesses for every networking packet it handles.)

Then there's TCP options, which can result in unaligned accesses being
generated even when the IP headers are aligned.

Unfortunately, this is stuff from around 20 years ago, so trying to
use google to find references to it is pretty much hopeless.

However, even today, on ARMv7, the networking code still occasionally
provokes the unaligned handler:

System:         2 (nsm_get_handle+0x200/0x484)
DWord:          2

That's in a protected environment though - out in the wild of the
Internet, it's most likely a different story...

> I see. I was indeed mainly referring to userspace, which is what this
> thread is about, specifically setend and the CP15 barrier
> instructions. You can disagree with ARM's policy to deprecate and
> remove some instructions, but given the reality of it, I think it is
> perfectly reasonable to warn by default about setend instructions
> issued in 32-bit userspace when running under the 64-bit ARMv8 kernel.

Linus has commented on this in the past, and his reaction (iirc) was
that deprecating instructions that userspace uses is not a sane
behaviour, pointing out that instructions that i386 supported still
work today on the latest Intel CPUs.

He has a point, it's the same argument against breaking userspace
through making a change to the kernel.  It gives users a painful
experience.

That said, no one expects that you can run an i386 binary on ARM,
which is pretty much understood by users.  However, ARM vs ARM64
where ARM64 provides a 32-bit ARM compatible environment is a
totally different story - it's _not_ compatible if it complains
about instructions that _were_ legal with 32-bit ARM binaries.
It makes me question the value of providing what is an incompatible
environment to run older binaries.

The purpose of such an environment is to provide _compatibility_ to
older binaries.  You aren't providing a compatible environment if
you then decide to noisily warn about deprecated instructions.

You might as well just rebuild the binaries for a 64-bit environment
and stop the illusion of a 32-bit compatible environment, because it
isn't.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
