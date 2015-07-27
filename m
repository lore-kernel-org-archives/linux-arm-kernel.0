From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jul 2015 12:21:19 +0100
Subject: [PATCH] ARM: asm/unified.h: guard the IT macros against
 redefinition when using LTO
In-Reply-To: <20150727111613.GL10670@e103592.cambridge.arm.com>
References: <alpine.LFD.2.20.1507241739280.1806@knanqh.ubzr>
 <20150727111613.GL10670@e103592.cambridge.arm.com>
Message-ID: <20150727112119.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 12:16:15PM +0100, Dave Martin wrote:
> Another scary thing with LTO is asms that use directives like
> .arch_extension, .fpu etc. that will stay active for the rest of the LTO
> unit of nothing is done about it.

That would be a problem, especially for things like the neon support,
as we specifically want stuff like that to be built separately.  The
same probably applies where we want to build with different architecture
options.

So, maybe the answer is to build most of the kernel with LTO enabled, but
those bits which require explicit -march= or -mfpu= options need to remain
separate non-LTO-able objects.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
