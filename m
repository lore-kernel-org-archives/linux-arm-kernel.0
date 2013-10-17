From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 17 Oct 2013 13:17:23 +0100
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <525DC3D1.5030300@linaro.org>
References: <525DC3D1.5030300@linaro.org>
Message-ID: <1382012243.19506.19.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-16 at 01:38 +0300, Taras Kondratiuk wrote:
> Hi
> 
> I was debugging kprobes-test for BE8 and noticed that some data fields
> are stored in LE instead of BE. It happens because these data fields
> get interpreted as instructions.
> 
> Is it a known issue?
> 
> For example:
> test_align_fail_data:
> 	bx	lr
> 	.byte 0xaa
> 	.align
> 	.word 0x12345678
> 
> I would expect to see something like this:
> 00000000 <test_align_fail_data>:
>    0:	e12fff1e 	bx	lr
>    4:	aa          	.byte	0xaa
>    5:	00          	.byte	0x00
>    6:	0000      	.short	0x0000
>    8:	12345678 	.word	0x12345678
> 
> But instead I have:
> 00000000 <test_align_fail_data>:
>    0:	e12fff1e 	bx	lr
>    4:	aa          	.byte	0xaa
>    5:	00          	.byte	0x00
>    6:	0000      	.short	0x0000
>    8:	12345678 	eorsne	r5, r4, #120, 12	; 0x7800000
> 
> As a result the word 0x12345678 will be stored in LE.
> 
> I've run several tests and here are my observations:
> - Double ".align" fixes the issue :)
> - Behavior is the same for LE/BE, ARM/Thumb, GCC 4.4.1/4.6.x/4.8.2
> - Size of alignment doesn't matter.
> - Issue happens only if previous data is not instruction-aligned and
>     0's are added before NOPs.
> - Explicit filling with 0's (.align , 0) fixes the issue, but as a side
>     effect data @0x4 is interpreted as a single ".word 0xaa000000"
>     instead of ".byte .byte .short". I'm not sure if there can be any
>     functional difference because of this.

After thinking about things overnight, I believe that this is the fix we
should go with. We want to stick alignment padding between data laid
down with .byte and .word so it makes sense to explicitly ask the
toolchain to pad with zeros rather than leaving it the opportunity to
get confused. (.align in the text section probably means it wants to
align with nops, but then sees the initial alignment and/or surrounding
statements look like binary data, not code, and then...)

I'll send a patch proposing that fix after I've worked out how to test
it on a big-endian kernel. Or if someone else sends a patch for that
with a good commit message that explains what's going on I'll happily
ack that.

-- 
Tixy
