From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jul 2014 19:30:55 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <4840595.cpHbY6hJKL@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
Message-ID: <20140703183055.GC32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 08:15:32PM +0200, Arnd Bergmann wrote:
> The default answer is "as long as anybody is using it". I had the
> same idea with making it gradually slower but in reality that isn't
> going to help. I think the best option is to make it easy to find
> and debug any application that is using deprecated instructions so
> people stop relying on them, and encourage distros to turn the emulation
> code off as soon as they are ready.

If you read the musl thread from last week, you'll understand why
there's a problem there.

Yes, SWP is deprecated in ARMv6 and ARMv7.  However, it is required to
implement atomics in ARMv5 - there is _no_ other way.

So, let's say that you want to build an application which will run on
Android from ARMv5 through to ARMv8.

You may need to make the decision about when to use SWP and when to
use the new exclusives.  One possible way is to hook SIGILL, and
try executing a LDREX.  If it succeeds, great, they can be used.

Now, consider this.  You build your application for ARMv5.  The toolchain
in this instance will *not* warn you that SWP is deprecated.  You've been
running it on Android platforms from ARMv5 upwards.  You have never had
a report of failure.

An ARMv8 Android device comes to market, and you now start getting lots
of bug reports...

Nothing before that point told you that there was a problem.

To prove this, I just ran this on iMX6DL:

#include <stdio.h>

int val = 5;

extern int swap(int v, int *a);

asm(""
"       .arm\n"
"swap:  swp     r2, r0, [r1]\n"
"       mov     r0, r2\n"
"       bx      lr\n"
"       .type   swap, #function\n"
"       .size   swap, . - swap\n"
"       .thumb");

int main()
{
        int v = swap(1, &val);

        printf("%u\n", v);
        return 0;
}

which produces the correct answer of 5.  SWP_EMULATE is off.  HWCAP_SWP
is set (as it always has been).  There's no warning in the kernel
message log.

Now look at the situation on ARMv8.  Executing the above suddenly fails
with SIGILL.

This means that from the developer and user point of view, there has
been *no* visible deprecation of this instruction.  There's only
"it used to work on ARMv7 but doesn't on ARMv8".

Yes, SWP_EMULATE was introduced.  Great, that has the power to issue
warnings, except it doesn't because they're at DEBUG level, which
normally gets compiled out.  So that doesn't help warn people.

Even with SWP_EMULATE enabled and with the debug problem fixed... does
it help warn people?  Only if you're running on a CPU with virtualisation
extensions, because it silently continues to work on CPUs without.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
