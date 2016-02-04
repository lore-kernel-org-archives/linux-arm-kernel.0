From: bcrl@kvack.org (Benjamin LaHaise)
Date: Thu, 4 Feb 2016 11:47:18 -0500
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160204161741.GH10826@n2100.arm.linux.org.uk>
References: <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
 <20160204131959.6695c7bf@canb.auug.org.au> <20160204134142.GA16315@kvack.org>
 <20160204135056.GE10826@n2100.arm.linux.org.uk>
 <20160204140822.GB16315@kvack.org>
 <20160204141253.GF10826@n2100.arm.linux.org.uk>
 <20160204143204.GC16315@kvack.org>
 <20160204143907.GG10826@n2100.arm.linux.org.uk>
 <20160204160101.GD16315@kvack.org>
 <20160204161741.GH10826@n2100.arm.linux.org.uk>
Message-ID: <20160204164718.GF16315@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 04:17:42PM +0000, Russell King - ARM Linux wrote:
> That's the easy bit!
> 
> The problem you're going to run into is here:
> 
> #define __get_user_nocheck(x, ptr, size)                                \
> ({                                                                      \
>         int __gu_err;                                                   \
>         unsigned long __gu_val;                                         \
>         __uaccess_begin();                                              \
>         __get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);    \
>         __uaccess_end();                                                \
>         (x) = (__force __typeof__(*(ptr)))__gu_val;                     \
> 
> __gu_val will be 32-bit, even when you're wanting a 64-bit quantity.
> That's where the fun and games start...

You're right -- it's quite non-trivial.  How evil would it be to make a 
separate __get_user64() macro?

		-ben
-- 
"Thought is the essence of where you are now."
