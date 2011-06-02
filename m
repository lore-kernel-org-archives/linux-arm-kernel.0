From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Thu, 2 Jun 2011 08:59:39 +0200
Subject: ep93xx: status/future of the sparsemem support
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F381FC4934@AUSP01VMBX24.collaborationhost.net>
References: <20110529130644.GI16318@ibawizard.net>
	<ADE657CA350FB648AAC2C43247A983F001F381FC4934@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110602065939.GM16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten <hartleys@visionengravers.com> [2011-05-31 13:23:32]:

> Then because of the way the ep93xx sdram controller uses the address bus,
> which is shared with the external memory (flash, etc.), the sdram memory
> gets broken up into banks of 2MB, 4MB, 8MB, 16MB, 32MB, or 128MB depending
> on the type of sdram used.  To make matters even more confusing, the sdram
> can operate with either a 16-bit or 32-bit wide data bus.  See [2] for the
> details.

D'oh.

> The patch above is optimized for the nSDCS3 (ASDO=1) and nSDCS2 configuration
> with 8MB banks.  In order for the ep93xx to support sparsemem I think it needs
> a bit of work to handle the other configurations.

Yes, I completly agree, that we need some more generic solution. I also
wonder, how much is the current "EP93xx first SDRAM bank selection" hardcoded
kernel config option multimachine friendly.

I don't know the internals that much, so it might sound completly silly, but I
think, that we might need to resurrect the Lennert's runtime PHYS_OFFSET
detection (or something similar to that idea) to detect the first memory bank,
then read the memory configuration passed via atags from there and setup the
sparsemem (or some kind of flexible virt<->phys implementation) accordingly?

I don't know the flatmem+highmem that much either, so I'm quite unsure if it
should work on such fragmented memory (ts7300+128MB in my use case), or if the
oops I'm just hitting now needs fixing and then it should start working. I've
looked into that code, but it's quite complex for me :P

What's your idea of handling this utter mess? What does "bit of work" mean
from your POV?

-- ynezz
