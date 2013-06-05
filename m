From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 5 Jun 2013 10:36:21 +0100
Subject: arm64: opportunity for (micro) optimisation in set_bit et al?
Message-ID: <1370424981.24512.163.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was "borrowing" the arm64 Linux bitops for use in Xen and Tim Deegan
wondered about the use of eor in:
       and     x3, x0, #63             // Get bit offset
       eor     x0, x0, x3              // Clear low bits
       mov     x2, #1
       add     x1, x1, x0, lsr #3      // Get word offset

That eor has a dependency on the previous and instruction which could be
avoided using a bic or a lsr #5 followed by lsl #2 instead of the lsr #3
on the add (this is what arm32 does).

The same goes for the test_and_blah variants.

Perhaps these sorts of hazards aren't such a big deal on arm64 or
perhaps eor has some advantage which we aren't aware of but I thought
I'd mention it...

Cheers,
Ian.
