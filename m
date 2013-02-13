From: syin@broadcom.com (Sherman Yin)
Date: Wed, 13 Feb 2013 11:14:52 -0800
Subject: =?UTF-8?q?=5BPATCH=5D=20ARM=3A=20Fix=20up=20l2x0=5Finit=20log=20message?=
Message-ID: <1360782893-20969-1-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the end of the function l2x0_init(), printk displays the ?ways? and
?l2x0_size? variables, but these are calculated based on the aux_val
parameter, instead of the actual value in the aux register.

I think a better way is to leave the ?ways?, ?way_size? and ?l2x0_size?
derivation until after the following lines:

         /* Re-read it in case some bits are reserved. */
         aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);

Then we will be reporting based on what the hardware tells us, instead of the
function argument.  Below is a proposed patch, although I'm not entirely happy
with the repeated switch statement.

Or is there a reason why we want to print the values derived from aux_val
instead?

Sherman Yin (1):
  ARM: Fix up l2x0_init log message

 arch/arm/mm/cache-l2x0.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

-- 
1.7.9.5
