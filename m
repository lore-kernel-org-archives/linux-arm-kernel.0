From: hector@marcansoft.com (Hector Martin)
Date: Thu, 25 Feb 2010 20:21:44 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002251332190.1946@xanadu.home>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>	<20100224223418.GB25587@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>	<20100224234215.GA21985@n2100.arm.linux.org.uk>	<4B85BCE0.7000903@marcansoft.com>	<20100225000114.GB21985@n2100.arm.linux.org.uk>	<4B85C4A4.4060005@marcansoft.com>	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>	<20100225093859.GA19870@n2100.arm.linux.org.uk>	<4B864B4C.9020805@marcansoft.com>
	<alpine.LFD.2.00.1002251332190.1946@xanadu.home>
Message-ID: <4B86CDC8.4080107@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Thu, 25 Feb 2010, Hector Martin wrote:
> 
>> If you can programmatically ensure that the decompressors do not use
>> anything but GOT entries to access data, that's certainly a better
>> solution than what we have now (I don't mean actually "fixing" them as
>> in -Dstatic=, just something that makes the build fail if this is not
>> the case so someone else can go and make the required changes). Maybe
>> building the object and then grepping the relocations for offenders, or
>> something like that.
> 
> Russell made a patch which simply ends up discarding .data section.

You still have the issue of the .bss section. Though I must admit this
would be rare, a decompressor using the .bss section would still cause
silent breakage. And I'm still not convinced that compiler behavior is
defined such that this cannot break in the future.

> You are still copying the actual decompressor code which is less optimal 
> than what we already have.  The current solution, as I explained 
> already, involves _zero_ copying.

The overhead of copying the decompressor is negligible. We're talking
somewhere along the lines of 0.1% of the time spent inside the
decompressor, worst case.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
