From: hector@marcansoft.com (Hector Martin)
Date: Wed, 24 Feb 2010 10:27:18 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100224084259.GA8068@pengutronix.de>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
	<20100224084259.GA8068@pengutronix.de>
Message-ID: <4B84F0F6.40902@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> Hello
> 
> [expanded Cc:]
> 
> On Tue, Feb 23, 2010 at 02:57:17PM +0100, hector at marcansoft.com wrote:
>> From: Hector Martin <hector@marcansoft.com>
>>
>> The -Dstatic= stuff in the Makefile is a hack and subtly breaks the
>> current inflate implementation, because the fixed inflate tables are
>> included into a function and removing static places them in the stack,
> Maybe this is the problem that people see after e7db7b4270?  Is this the
> final hint that we should revert that one?

Quite likely it is this same issue. The switch to the other inflate
implementation is probably what introduced the breakage. However,
e7db7b4270 itself is perfectly fine. The problem has been lurking all
along in the -Dstatic= thing, and that would've caused issues with
several perfectly valid C constructs in the kernel lib/inflate stuff.

I can also 'fix' the issue with a two-line patch to the new deflate
code, but that's not a proper solution, just an ugly workaround. I don't
think restricting the inflate code to a weird subset of C due to ARM
peculiarities is a good idea.

This can also break with GCC updates - the current code depends on
unspecified behavior of the compiler. Essentially, the split relocation
is something that is not allowed nor expected by the compiler, and
-Dstatic= is a crude hack to attempt to modify code so it doesn't
trigger the cases where the hack breaks down. But it doesn't work, and
breaks legitimate code. Even worse, the bugs it introduces can be subtle
heisenbugs, as was the case here - I spent two afternoons tracking it
down through the bowels of inflate and comparing the output vs. an x86
build. In a worst-case scenario, the bug could've caused corrupted
kernel output (not just a flat-out hang or crash while uncompressing),
which would've been so much fun to debug (*cough*).

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
