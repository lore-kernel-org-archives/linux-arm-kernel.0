From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 10 May 2010 16:34:57 +0300
Subject: [PATCH] Handle instruction cache maintenance fault properly
In-Reply-To: <20100510131519.GB7796@n2100.arm.linux.org.uk>
References: <AANLkTikIbI6hKoYSZlo6QDlyi2Qjxg287i-ilHpz1FF9@mail.gmail.com>
	<20100510131519.GB7796@n2100.arm.linux.org.uk>
Message-ID: <AANLkTint0f2Ow2FM3jVAqGfPjolHvF-oBTGCmY7Jx7_d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 4:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 10, 2010 at 04:07:57PM +0300, Kirill A. Shutemov wrote:
>> Between "clean D line..." and "invalidate I line" operations in
>> v7_coherent_user_range(), the memory page may get swapped out.
>> And the fault on "invalidate I line" could not be properly handled
>> causing the oops.
>
> You have to be very careful when doing this kind of change - you need to
> review the behaviour of previous ARMs to ensure that you don't throw the
> CPU into an infinite loop when an "external abort on linefetch" occurs.
>
> With older CPUs, an "external abort on linefetch" is most probably fatal
> to the process and can never be recovered.

It looks like cache maintenance fault was introduced in ARMv6.

So, what is the right way to fix it? Something like:

#if __LINUX_ARM_ARCH__ < 6
        { do_bad,               SIGBUS,  0,             "external
abort on linefetch"      },
#else
        { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "I-cache
maintenance fault"        },
#endif
