From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 16 Oct 2013 12:13:28 +0100
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <525DC3D1.5030300@linaro.org>
References: <525DC3D1.5030300@linaro.org>
Message-ID: <525E74D8.3070008@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/13 23:38, Taras Kondratiuk wrote:
> Hi
>
> I was debugging kprobes-test for BE8 and noticed that some data fields
> are stored in LE instead of BE. It happens because these data fields
> get interpreted as instructions.
>
> Is it a known issue?

I reported the crashes to Tixy along with a different
method of sovling the problem (changed to using pointers to
the strings) a while ago. However it seems that nothing has
happened to fix this.

Since kprobes seems to work with the fixed tests I forgot
to follow up and prod Jon about looking into this problem.

Jon, if you are not interested in fixing this, then please
let me know and we can get a patch sorted to fix it.

PS, I am going to leave this out of the current be8 patchset
as I want to get that merged, and at the moment kprobes-test
is not essential to getting the system started.

> For example:
> test_align_fail_data:
> 	bx	lr
> 	.byte 0xaa
> 	.align
> 	.word 0x12345678
>
> I would expect to see something like this:
> 00000000<test_align_fail_data>:
>     0:	e12fff1e 	bx	lr
>     4:	aa          	.byte	0xaa
>     5:	00          	.byte	0x00
>     6:	0000      	.short	0x0000
>     8:	12345678 	.word	0x12345678
>
> But instead I have:
> 00000000<test_align_fail_data>:
>     0:	e12fff1e 	bx	lr
>     4:	aa          	.byte	0xaa
>     5:	00          	.byte	0x00
>     6:	0000      	.short	0x0000
>     8:	12345678 	eorsne	r5, r4, #120, 12	; 0x7800000
>
> As a result the word 0x12345678 will be stored in LE.
>
> I've run several tests and here are my observations:
> - Double ".align" fixes the issue :)
> - Behavior is the same for LE/BE, ARM/Thumb, GCC 4.4.1/4.6.x/4.8.2
> - Size of alignment doesn't matter.
> - Issue happens only if previous data is not instruction-aligned and
>      0's are added before NOPs.
> - Explicit filling with 0's (.align , 0) fixes the issue, but as a side
>      effect data @0x4 is interpreted as a single ".word 0xaa000000"
>      instead of ".byte .byte .short". I'm not sure if there can be any
>      functional difference because of this.
> - Issue doesn't happen if there is no instructions before data
>    (no "bx lr" in the example).
> - Issue doesn't happen if data after .align is defined as
>      ".type<symbol>,%object".

Thanks for getting down to a simple test case.

My view is to fix this by not doing complicated things by trying
to save a bit of space by embedding strings into the code. It is
not as if we cannot get the compiler to put the strings into the
relevant data area and give us a pointer we can use.

The code in this case is /not easy/ to follow and it would be nice
if it could be cleaned up to just take the string as a argument to
the test code instead of trying to find it via assembly magic.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
