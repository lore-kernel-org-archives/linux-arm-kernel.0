From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 19:37:39 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703183055.GC32514@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
 <20140703183055.GC32514@n2100.arm.linux.org.uk>
Message-ID: <20140703183739.GA21086@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 07:30:55PM +0100, Russell King - ARM Linux wrote:
> which produces the correct answer of 5.  SWP_EMULATE is off.  HWCAP_SWP
> is set (as it always has been).  There's no warning in the kernel
> message log.

Even more worrying, that swp you just executed probably wasn't atomic. Try
it with a multithreaded program...

> Now look at the situation on ARMv8.  Executing the above suddenly fails
> with SIGILL.
> 
> This means that from the developer and user point of view, there has
> been *no* visible deprecation of this instruction.  There's only
> "it used to work on ARMv7 but doesn't on ARMv8".
> 
> Yes, SWP_EMULATE was introduced.  Great, that has the power to issue
> warnings, except it doesn't because they're at DEBUG level, which
> normally gets compiled out.  So that doesn't help warn people.
> 
> Even with SWP_EMULATE enabled and with the debug problem fixed... does
> it help warn people?  Only if you're running on a CPU with virtualisation
> extensions, because it silently continues to work on CPUs without.

Not *quite* true; SWP_EMULATE=y disables the h/w SWP instruction by
configuring the sctlr accordingly. So even without virtualisation
extensions (more specifically, on cores with MP extensions), you would
still see the warning if it was fixed.

Will
