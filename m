From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Jan 2013 09:31:02 +0000
Subject: ARM: hw_breakpoint mismatch breakpoint behaves unexpectedly like
 a match breakpoint on ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmKJaYf6M4iHKuNcHgYZi5R8M7fXdXta34Q=1C0cHKimkyQ@mail.gmail.com>
References: <CAPfQmKJaYf6M4iHKuNcHgYZi5R8M7fXdXta34Q=1C0cHKimkyQ@mail.gmail.com>
Message-ID: <20130122093102.GC12295@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 04:28:35AM +0000, Valentin Pistol wrote:
> Hi Will,

Hi Valentin,

> I am trying to single-step each instruction in a target process by
> using the hardware breakpoints with the mismatch set (bit 22) and I am
> experiencing unexpected behavior: with mismatch set it behaves as a
> match breakpoint.
> I checked that my Debug Arch ARM_DEBUG_ARCH_V7_ECP14 has mismatch
> breakpoint support.
> The BCR (0x4001e5) value and DSCR (0x3070002) seem to be correct
> according to the manual, so I am confused what is causing the odd
> behavior.

[...]

> I should note that I am able to set a match breakpoint using the
> ptrace interface, have it trigger a SIGTRAP and capture it in my own
> user space handler. When attempting to use mismatch instead, the
> behavior appears to be same as a match breakpoint: breaks on the
> specified PC value.

The ptrace interface doesn't support mismatch breakpoints, and ignores those
bits in the user request, hence why you see a normal breakpoint being
created. Note that mismatch breakpoints are used internally for stepping
over breakpoints set by perf.

If you wanted to add single-step using mismatch breakpoints, I think we'd be
better off re-introducing the SINGLESTEP ptrace request for ARM to use
hw_breakpoints.

Will
