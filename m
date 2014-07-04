From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Jul 2014 09:57:45 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703183055.GC32514@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
 <20140703183055.GC32514@n2100.arm.linux.org.uk>
Message-ID: <20140704085745.GB16404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 07:30:55PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 03, 2014 at 08:15:32PM +0200, Arnd Bergmann wrote:
> > The default answer is "as long as anybody is using it". I had the
> > same idea with making it gradually slower but in reality that isn't
> > going to help. I think the best option is to make it easy to find
> > and debug any application that is using deprecated instructions so
> > people stop relying on them, and encourage distros to turn the emulation
> > code off as soon as they are ready.
> 
> Yes, SWP is deprecated in ARMv6 and ARMv7.  However, it is required to
> implement atomics in ARMv5 - there is _no_ other way.
> 
> So, let's say that you want to build an application which will run on
> Android from ARMv5 through to ARMv8.
> 
> You may need to make the decision about when to use SWP and when to
> use the new exclusives.  One possible way is to hook SIGILL, and
> try executing a LDREX.  If it succeeds, great, they can be used.
> 
> Now, consider this.  You build your application for ARMv5.  The toolchain
> in this instance will *not* warn you that SWP is deprecated.  You've been
> running it on Android platforms from ARMv5 upwards.  You have never had
> a report of failure.

With EABI, we tried to address the differences between architectures by
providing the kuser helpers. Most EABI distros moved to using them and
no longer executing SWP in user space (remember glibc having a cmpxchg
implementation based on SWP that "mostly" worked). Over the years the
hope was that it would completely disappear but I agree that we failed
to address this properly at the kernel level (e.g. more aggressive
warnings, remove HWCAP_SWP).

On arm64 we took a radical stance - SIGILL (and if you are still
worried, emulate it in user space).

> An ARMv8 Android device comes to market, and you now start getting lots
> of bug reports...

We should have started addressing these in ARMv7 but unfortunately we
didn't have a good plan for getting rid of emulated instructions.

> Even with SWP_EMULATE enabled and with the debug problem fixed... does
> it help warn people?  Only if you're running on a CPU with virtualisation
> extensions, because it silently continues to work on CPUs without.

Some clarification here. The virtualisation extensions made SWP
_optional_ (i.e. it may not be present at all). The ARMv7
multiprocessing extensions introduced the possibility to disable/trap
SWP via the SCTLR.SW bit because it was no longer atomic. So basically
native SWP only works (as expected, atomically) on ARMv7 UP and earlier.

-- 
Catalin
