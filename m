From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 16:57:16 +0000
Subject: [PATCH 2/3] msm: add minimal board file for HTC Dream device
In-Reply-To: <a55d774e0911160843h22938604s8966a58ee71992a@mail.gmail.com>
References: <20091102104949.GA23456@elf.ucw.cz>
	<20091116163659.GB3568@n2100.arm.linux.org.uk>
	<a55d774e0911160843h22938604s8966a58ee71992a@mail.gmail.com>
Message-ID: <20091116165716.GD3568@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 08:43:20AM -0800, Brian Swetland wrote:
> What's the best way to handle a situation where there is no valid
> debug uart?  Could the arch/platform require DEBUG_LL be unset via
> Kconfig directives if it is configured in a way where there is no
> valid debug uart?

You're the first to have that issue.  Everyone else has a UART they
can always direct stuff at.

However, I believe you're making the issue far larger than it really is.

1. If you define the DEBUG_LL macros to be empty, printascii() etc will
   not touch any mapping.

2. If no mapping is going to be touched by printascii(), does it matter
   whether a UART is mapped via this early mapping stuff?

The answer to (2) is no.

So, you can still arrange for these fields to be populated with a valid
value even if you don't intend to use the resulting mapping.  And so
there's no need to force DEBUG_LL to be unset.

If you really have no values you can use, make sure you set io_pg_offst
to 0x3ffc - the last offset in the L1 page table.  This will cause the
code to write a single dummy entry at the very top of the page table,
which will then be overwritten by the generic ARM arch code for its own
use.
