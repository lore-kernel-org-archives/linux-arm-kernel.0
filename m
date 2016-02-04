From: bcrl@kvack.org (Benjamin LaHaise)
Date: Thu, 4 Feb 2016 11:27:52 -0500
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
Message-ID: <20160204162752.GE16315@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 04:17:42PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 04, 2016 at 11:01:01AM -0500, Benjamin LaHaise wrote:
> > On Thu, Feb 04, 2016 at 02:39:07PM +0000, Russell King - ARM Linux wrote:
> > > However, this one should warn:
> > > 
> > > int test_wrong(char **v, const char **p)
> > > { return __get_user(*v, p); }
> > > 
> > > Good luck (I think you'll need lots of it to get a working solution)! :)
> > 
> > This works with your test cases on x86-32.  Note that it's only compile + 
> > link tested at present.
> 
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

Ugh.  You're making me install a 32 bit distro.....!

		-ben

> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
"Thought is the essence of where you are now."
