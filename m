From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sat, 4 Nov 2017 00:17:57 +0000
Subject: Page fault while link_path_walk for path_len > 4060 bytes
In-Reply-To: <20170912202615.GA9432@arm.com>
References: <08e7e3332dc86c535dd2961ac1cde0b5@codeaurora.org>
 <54083a824d6705a93d972ca5ef3a7b35@codeaurora.org>
 <3958983ccec4aca494bf72c397f34bfa@codeaurora.org>
 <953068e79da559bfd4f13e46e31c5a4e@codeaurora.org>
 <20170822125747.GB28024@arm.com>
 <b13b3a27e92c5413d168ad775163ea91@codeaurora.org>
 <20170912202615.GA9432@arm.com>
Message-ID: <20171104001757.GM21978@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[looking through the old mail]

On Tue, Sep 12, 2017 at 09:26:16PM +0100, Will Deacon wrote:
> > -    { do_page_fault,    SIGSEGV, SEGV_MAPERR,    "level 3 translation
> > fault"    },
> > +    { do_translation_fault,    SIGSEGV, SEGV_MAPERR,    "level 3
> > translation fault"    },
> > we will try with above changes and get back to you.
> 
> Did you test with this change?

FWIW, while that went in as commit 760bfb47c36a ("arm64: fault: Route pte
translation faults via do_translation_fault"), I wonder if the same issue
exists on arm.  It looks like the pagefault handler there is fairly
similar to arm64 one and the same shortcut is present there.

The more I'm looking at that, the more it looks like we *really* need
a comment in all instances of load_unaligned_zeropad() warning about
that pitfall.  Something like
/*
 * Load an unaligned word from kernel space.
 *
 * In the (very unlikely) case of the word being a page-crosser
 * and the next page not being mapped, take the exception and
 * return zeroes in the non-existing part.
 *
 * NOTE: this relies upon the pagefault handler *NOT* blocking
 * in such situation (fault in kernel mode on kernel address with
 * exception fixup present).  Verify that for your architecture
 * before using an equivalent of this approach.  Note that
 * you can't count upon faulthandler_disabled() saving you;
 * this function can be called e.g. under a spinlock on non-preempt
 * kernels without pagefault_disable() done by caller.
 */
perhaps.  That property holds on x86, ppc and (now) arm64, but as
arm64 case shows, it might not be true for other architectures.
As the matter of fact, e.g. sparc64 (which will not use that
thing for obvious reasons anyway) it is *not* true, etc.
