From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Mar 2016 17:23:34 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <56DDAFA7.4090207@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <56DDAFA7.4090207@arm.com>
Message-ID: <20160307172334.GJ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 04:43:19PM +0000, James Morse wrote:
> Hi Catalin,
> 
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
> 
> As far as I can see, this would only affect arm64. I can't find an equivalent
> memset() for x86_64.

I don't think you've looked hard enough. :)

arch/x86/lib/usercopy_32.c:

unsigned long _copy_from_user(void *to, const void __user *from, unsigned n)
{
        if (access_ok(VERIFY_READ, from, n))
                n = __copy_from_user(to, from, n);
        else
                memset(to, 0, n);
        return n;
}
EXPORT_SYMBOL(_copy_from_user);

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
