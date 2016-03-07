From: james.morse@arm.com (James Morse)
Date: Mon, 07 Mar 2016 16:43:19 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <1454684330-892-1-git-send-email-james.morse@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
Message-ID: <56DDAFA7.4090207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I've just spotted UAO causes the test_user_copy module (CONFIG_TEST_USER_COPY)
to fail. Who to blame is up for discussion. The test is passing a user pointer
as the 'to' field of copy_from_user(), which it expects to fail gracefully:

lib/test_user_copy.c:75
>	/* Invalid usage: none of these should succeed. */
[ ... ]
> 	ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
>				    PAGE_SIZE),
>		    "illegal reversed copy_from_user passed");
>

access_ok() catches the "(char __user *)kmem", causing copy_from_user() to pass
bad_usermem to memset():

arch/arm64/include/asm/uaccess.h:279
>	if (access_ok(VERIFY_READ, from, n))
>		n = __copy_from_user(to, from, n);
>	else /* security hole - plug it */
>		memset(to, 0, n);

This (correctly) trips UAO's "Accessing user space memory outside uaccess.h
routines" message, which is a little confusing to debug, and stops the rest of
the module's tests from being run.

As far as I can see, this would only affect arm64. I can't find an equivalent
memset() for x86_64.

The below ugly hack [0], handles this more gracefully. I can send this as a fix
sooner/later if you think its the right thing to do.



Thanks,

James

[0]
-----------------%<-----------------
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 0685d74572af..049a82e8dd9e 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -278,8 +278,8 @@ static inline unsigned long __must_check copy_from_user(void
*to, const void __u
 {
        if (access_ok(VERIFY_READ, from, n))
                n = __copy_from_user(to, from, n);
-       else /* security hole - plug it */
-               memset(to, 0, n);
+       else if ((unsigned long)to > USER_DS) /* swapped from/to args? */
+               memset(to, 0, n); /* security hole - plug it */
        return n;
 }

-----------------%<-----------------
