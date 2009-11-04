From: trd@45mercystreet.com (Toby Douglass)
Date: Wed, 04 Nov 2009 19:09:37 +0100
Subject: GCC built-in atomic operations and memory barriers
Message-ID: <4AF1C361.8090405@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi -

My first post.

I have written a (currently small) library of lock-free data structures
(www.liblfds.org).

I am porting to ARM.

The port is complete except for CAS.

I initially tried to use the GCC built-in CAS; in my test set, the third
test fails with a double free, because the head element of the freelist
being tested has come to point to itself.

So I figured I'd need to write my own CAS.  I learned enough ARM
assembly and did enough Googling to put something together.  I've done
the same already for x86 (I needed cmpxchg16b, so I couldn't use the GCC
built-ins) so I have a tiny bit of experience in it; and my attempt
fails in exactly the same way as the GCC built-in.

So I go to bed.  Next day I think, ah, memory barriers!  you don't need
to specify them on x86 for atomics, but I bet you do on ARM; and indeed,
you do.

I then discover in this mailing list an interesting thread, dated May
2009, which states that the GCC built-ins for ARM do not have memory
barriers.  The kernel I'm using is 2.6.28, which was released Christmas
Day 2008.

So I think the lack of memory barriers may well be why the code is failing.

This leads me to want to use smp_mb().  However, from what I can see,
this macro is only available via the linux kernel headers; it's not
available in user-mode.  Is this correct?
