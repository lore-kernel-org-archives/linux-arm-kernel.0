From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Mar 2013 17:28:54 +0000
Subject: [PATCH v2] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <513CBD83.7040909@ahsoftware.de>
References: <1360587435-28386-1-git-send-email-ivan.djelic@parrot.com>
 <513795C5.4050608@gmail.com> <20130307151755.GB4977@n2100.arm.linux.org.uk>
 <513CBD83.7040909@ahsoftware.de>
Message-ID: <20130310172854.GH4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 06:06:11PM +0100, Alexander Holler wrote:
> Am 07.03.2013 16:17, schrieb Russell King - ARM Linux:
>> On Wed, Mar 06, 2013 at 08:15:17PM +0100, Dirk Behme wrote:
>>> Am 11.02.2013 13:57, schrieb Ivan Djelic:
>>>> Recent GCC versions (e.g. GCC-4.7.2) perform optimizations based on
>>>> assumptions about the implementation of memset and similar functions.
>>>> The current ARM optimized memset code does not return the value of
>>>> its first argument, as is usually expected from standard implementations.
>
> I've just tried this patch with kernel 4.8.2 on an armv5-system where I  
> use gcc 4.7.2 since several months and where most parts of the system  
> are compiled with gcc 4.7.2 too.
>
> And I had at least one problem which manifested itself with

Yes, the patch _is_ wrong.  Reverted.  I was trusting Nicolas' review
of it, but the patch is definitely wrong.  Look carefully at this
fragment of code:

1:      subs    r2, r2, #4              @ 1 do we have enough
        blt     5f                      @ 1 bytes to align with?
        cmp     r3, #2                  @ 1
        strltb  r1, [ip], #1            @ 1
        strleb  r1, [ip], #1            @ 1
        strb    r1, [ip], #1            @ 1
        add     r2, r2, r3              @ 1 (r2 = r2 - (4 - r3))
/*
 * The pointer is now aligned and the length is adjusted.  Try doing the
 * memset again.
 */

ENTRY(memset)
/*
 * Preserve the contents of r0 for the return value.
 */
        mov     ip, r0
        ands    r3, ip, #3              @ 1 unaligned?
        bne     1b                      @ 1

and consider what happens when 'r0' is not aligned to a word... We end
up aligning the pointer in "1:" and then fall through into memset again
which reloads the old misaligned pointer.
