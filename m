From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jan 2010 12:45:37 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <001a01ca9a96$0f7024a0$2e506de0$@deacon@arm.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<20100121093917.GB4908@wear.picochip.com>
	<20100121103803.GA15663@n2100.arm.linux.org.uk>
	<201001211321.44682.jpihet@mvista.com>
	<001a01ca9a96$0f7024a0$2e506de0$@deacon@arm.com>
Message-ID: <20100121124537.GA19210@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 12:34:22PM -0000, Will Deacon wrote:
> For the v7 PMU, we can do a bit better than that because the PMU
> is defined by the architecture. If you read the DIDR[19:16] and it
> returns either 3 or 4, you have a v7 PMU present so you can make use of
> the architecturally defined events regardless of the implementer.

However, you can't just check DIDR - DIDR doesn't exist unless you have
the new ID scheme - and you can tell that by:

if MIDR[31:28] != 0x41 || (MIDR[12:15] != 0 && MIDR[12:15] != 7)
	newid = MIDR[19:16] == 15
else
	newid = 0

or currently check for cpu_architecture() >= CPU_ARCH_ARMv6 &&
MIDR[19:16] == 15 (the additional qualification is needed because ARMv6
CPUs can have either the old or new schemes.)

However, what also needs checking is how DIDR is specified for ARMv6,
and whether that clashes with the ARMv7 version - as I mentioned before,
the new ID scheme is not without its own set of weird changes as well.
