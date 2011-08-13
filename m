From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Aug 2011 15:39:03 +0100
Subject: [PATCH] Fix non-LPAE boot regression.
In-Reply-To: <CAHkRjk4p1kqwKGiW_XRFU0aap98QkvRGRs0hwsBR4CcfM5RKqA@mail.gmail.com>
References: <201108131556.27301.anarsoul@gmail.com>
	<1313240299-24712-1-git-send-email-anarsoul@gmail.com>
	<CAHkRjk4p1kqwKGiW_XRFU0aap98QkvRGRs0hwsBR4CcfM5RKqA@mail.gmail.com>
Message-ID: <20110813143903.GQ4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2011 at 03:14:30PM +0100, Catalin Marinas wrote:
> Thanks for this. The original code was indeed broken but I think the
> fix should be to use SECTION_SIZE instead of SHIFT. I'll have a look
> on Monday.

No, the original code is not broken.  Look at what it's doing:

        mov     r5, r5, lsr #20
        mov     r6, r6, lsr #20

1:      orr     r3, r7, r5, lsl #20             @ flags + kernel base
        str     r3, [r4, r5, lsl #2]            @ identity mapping
        teq     r5, r6
        addne   r5, r5, #1                      @ next section
        bne     1b

The addition of one is to step us to the next page table entry.  It's
not SECTION_SHIFT >> 20 or anything like that.

Let's rewrite it in C:

	pmd_idx = r5 >> 20;
	pmd_end = r6 >> 20;

	do {
		pmd[pmd_idx] = flags | (pmd_idx << 20);
		if (pmd_idx == pmd_end)
			break;
		pmd_idx++;
	} while (1);

which is quite correct for non-LPAE.  Those shifts of 20 could well have
been SECTION_SHIFT instead to make it more clear what's going on there.

Now, with LPAE, where pmds are now 64-bit, the fact that SECTION_SHIFT
becomes 21 is merely coincidental.  That doesn't mean that the add
instruction should be SECTION_SIZE >> 20, as you're using apples to
describe oranges there.

With SECTION_SIZE >> 20, your modified code looks like this for LPAE:

+       mov     r5, r5, lsr #21
+       mov     r6, r6, lsr #21

+1:     orr     r3, r7, r5, lsl #21             @ flags + kernel base
+       str     r3, [r4, r5, lsl #3]            @ identity mapping
+       cmp     r5, r6
+       addlo   r5, r5, #2                      @ next section
+       blo     1b

So: for LPAE:
	r5 increments by 2, so r3 increments by 2 << 21.
	[r4, r5, lsl #3] increments by 2<<3 = 16.
for non-LPAE (from above):
	r5 increments by 1, so r3 increments by 1 << 20.
	[r4, r5, lsl #2] increments by 1<<2 = 4.

so that's not correct either.  Rather than incrementing by one section
on LPAE, we increment by two.  Not only that, but the pointer also
increments by twice as much.

So, this should become something like this instead:

        mov     r5, r5, lsr #SECTION_SHIFT
        mov     r6, r6, lsr #SECTION_SHIFT

1:      orr     r3, r7, r5, lsl #SECTION_SHIFT  @ flags + kernel base
        str     r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
        teq     r5, r6
        addne   r5, r5, #1                      @ next section
        bne     1b

which is what Vasily's patch does.

I think this patch is trying to do too much in one go.  It needs splitting
up into two, just like is done with the C PGDIR_SHIFT vs PMD_SHIFT stuff
(and arguably the first part should be combined with the patch fixing the
PGDIR_SHIFT stuff.)
