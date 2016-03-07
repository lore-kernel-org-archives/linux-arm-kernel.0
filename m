From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Mar 2016 17:38:35 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <56DDAFA7.4090207@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <56DDAFA7.4090207@arm.com>
Message-ID: <20160307173835.GB6192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cc'ing Kees)

On Mon, Mar 07, 2016 at 04:43:19PM +0000, James Morse wrote:
> I've just spotted UAO causes the test_user_copy module (CONFIG_TEST_USER_COPY)
> to fail. Who to blame is up for discussion. The test is passing a user pointer
> as the 'to' field of copy_from_user(), which it expects to fail gracefully:
> 
> lib/test_user_copy.c:75
> >	/* Invalid usage: none of these should succeed. */
> [ ... ]
> > 	ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
> >				    PAGE_SIZE),
> >		    "illegal reversed copy_from_user passed");
> >
> 
> access_ok() catches the "(char __user *)kmem", causing copy_from_user() to pass
> bad_usermem to memset():
> 
> arch/arm64/include/asm/uaccess.h:279
> >	if (access_ok(VERIFY_READ, from, n))
> >		n = __copy_from_user(to, from, n);
> >	else /* security hole - plug it */
> >		memset(to, 0, n);
> 
> This (correctly) trips UAO's "Accessing user space memory outside uaccess.h
> routines" message, which is a little confusing to debug, and stops the rest of
> the module's tests from being run.

I suggest we don't do anything on arch/arm64 (or arch/arm), I just
consider the test to be broken. The semantics of copy_from_user() don't
say anything about the safety checks on the destination pointer, this is
supposed to be a valid kernel address. The test assumes that if the
source pointer is invalid, the copy_from_user() routine should not touch
the destination.

A better test would be to use a destination buffer filled with a poison
value and checked after the operation.

-- 
Catalin
