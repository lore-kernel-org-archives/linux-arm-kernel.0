From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 14:13:08 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost>
 <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
Message-ID: <20170130141308.GV27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:01:53PM +0000, Ard Biesheuvel wrote:
> Emulating unaligned access in the ARM kernel was a mistake: it even
> emulates unaligned accesses for instructions like ldm and ldrd, which
> require word alignment at the hardware level even in the latest v8
> version of the architecture. In contrast, the v8 deprecation warnings
> are about enforcing compliance.

Ard, you're totally wrong on the unaligned access thing.  Unaligned
accesses are a fundamental requirement of the kernel's networking
stack.  If you don't have support for unaligned accesses, then you
don't have network support - it's as simple as that.

So, in order for ARMv5 and earlier to have network support, there
was no option to add support for emulating those accesses.

The dubious thing was whether to add that for userspace as well.
Since soo many applications were broken at the time, and ARM wasn't
a sufficiently large community for the applications people to care
one shit about, the applications people weren't going to fix their
code to avoid unaligned accesses.

So, back in the 1990s, we were stuck between having broken userspace
and a huge amount of effort needed to maintain ARM specific patches
out of tree for lots of applications, or functional userspace.

Today, the ARM architecture has moved on a long way, and application
people care about whether their stuff works on the ARM architecture.
It wasn't like that when the unaligned emulation was added.

It was not a mistake.  It's one of the reasons why ARM has got where
it is today, and probably why the light was finally seen to add
hardware support for unaligned accesses to the later CPU architectures.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
