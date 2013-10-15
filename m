From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed, 16 Oct 2013 01:38:09 +0300
Subject: .align may cause data to be interpreted as instructions
Message-ID: <525DC3D1.5030300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I was debugging kprobes-test for BE8 and noticed that some data fields
are stored in LE instead of BE. It happens because these data fields
get interpreted as instructions.

Is it a known issue?

For example:
test_align_fail_data:
	bx	lr
	.byte 0xaa
	.align
	.word 0x12345678

I would expect to see something like this:
00000000 <test_align_fail_data>:
   0:	e12fff1e 	bx	lr
   4:	aa          	.byte	0xaa
   5:	00          	.byte	0x00
   6:	0000      	.short	0x0000
   8:	12345678 	.word	0x12345678

But instead I have:
00000000 <test_align_fail_data>:
   0:	e12fff1e 	bx	lr
   4:	aa          	.byte	0xaa
   5:	00          	.byte	0x00
   6:	0000      	.short	0x0000
   8:	12345678 	eorsne	r5, r4, #120, 12	; 0x7800000

As a result the word 0x12345678 will be stored in LE.

I've run several tests and here are my observations:
- Double ".align" fixes the issue :)
- Behavior is the same for LE/BE, ARM/Thumb, GCC 4.4.1/4.6.x/4.8.2
- Size of alignment doesn't matter.
- Issue happens only if previous data is not instruction-aligned and
    0's are added before NOPs.
- Explicit filling with 0's (.align , 0) fixes the issue, but as a side
    effect data @0x4 is interpreted as a single ".word 0xaa000000"
    instead of ".byte .byte .short". I'm not sure if there can be any
    functional difference because of this.
- Issue doesn't happen if there is no instructions before data
  (no "bx lr" in the example).
- Issue doesn't happen if data after .align is defined as
    ".type <symbol>,%object".

-- 
Taras Kondratiuk
