From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jan 2013 15:04:28 +0000
Subject: [PATCH] Proposed removal of IS_ERR_OR_NULL() (was: Re: [PATCH 1/4]
 gpiolib: introduce descriptor-based GPIO interface)
In-Reply-To: <alpine.LFD.2.02.1301090932400.6300@xanadu.home>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
 <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301090932400.6300@xanadu.home>
Message-ID: <20130109150427.GL3931@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, it seems there's some concensus building here, and it seems that
I've become the chosen victi^wvolunteer for this.  So, here's a patch.
It's missing a Guns-supplied-by: tag though.

From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Mark IS_ERR_OR_NULL() deprecated

IS_ERR_OR_NULL() attracts a lot of abuse: people use it without much
thought about it's effects.  Common errors include:
 1. checking the returned pointer for functions defined as only
    returning errno-pointer values, rather than using IS_ERR().
    This leads to: ptr = foo(); if (IS_ERR_OR_NULL(ptr)) return
     PTR_ERR(ptr);
 2. using it to check functions which only ever return NULL on error,
    thereby leading to another zero-error value return.
In the case of debugfs functions, these return errno-pointer values when
debugfs is configured out, which means code which blindly checks using 
IS_ERR_OR_NULL() ends up returning errors, which is rather perverse for
something that's not implemented.

Therefore, let's schedule it for removal in a few releases.

Nicolas Pitre comments:
> I do agree with Russell here.  Despite the original intentions behind
> IS_ERR_OR_NULL() which were certainly legitimate, the end result in
> practice is less reliable code with increased maintenance costs.
> Unlike other convenience macros in the kernel, this one is giving a
> false sense of correctness with too many people falling in the trap
> of using it just because it is available.
> 
> I strongly think this macro should simply be removed from the source
> tree entirely and the code reverted to explicit tests against NULL
> when appropriate.

Suggested-by: David Howells <dhowells@redhat.com>
Tape-measuring-service-offered-by: Will Deacon <will.deacon@arm.com>
Victim-for-firing-sqad: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Ok, so I'm in the firing line for suggesting this, but it appears
several people wish this to happen.

I'm not intending to push this patch forwards _just_ yet: we need to
sort out the existing users _first_ to prevent the kernel turning into
one hell of a mess of warnings.

 include/linux/err.h |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/include/linux/err.h b/include/linux/err.h
index f2edce2..d5a85df 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -34,7 +34,22 @@ static inline long __must_check IS_ERR(const void *ptr)
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
-static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
+/*
+ * IS_ERR_OR_NULL() attracts a lot of abuse: people use it without much
+ * thought about it's effects.  Common errors include:
+ *  1. checking the returned pointer for functions defined as only returning
+ *     errno-pointer values, rather than using IS_ERR().
+ *     This leads to: ptr = foo(); if (IS_ERR_OR_NULL(ptr)) return PTR_ERR(ptr);
+ *  2. using it to check functions which only ever return NULL on error,
+ *     thereby leading to another zero-error value return.
+ * In the case of debugfs functions, these return errno-pointer values when
+ * debugfs is configured out, which means code which blindly checks using
+ * IS_ERR_OR_NULL() ends up returning errors, which is rather perverse for
+ * something that's not implemented.
+ *
+ * Therefore, let's schedule it for removal in a few releases.
+ */
+static inline long __must_check __deprecated IS_ERR_OR_NULL(const void *ptr)
 {
 	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
 }
