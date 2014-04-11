From: dave.long@linaro.org (David Long)
Date: Thu, 10 Apr 2014 23:42:01 -0400
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper cache
 flushing
In-Reply-To: <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
 <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
Message-ID: <53476489.10507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, here is an alternative solution for the kernel-dcache / user-icache
flush issue in uprobes which I think follows Dave Miller's suggested
approach.  As a reminder:  the goal is to make sure the user-space
icache does not have stale data after the kernel rewrite of an
instruction in the user's uprobe "execute out of line" (xol) page. It
seems only ARM currently finds the flush_dcache_page() call
insufficient, but then apparently only two architectures (other than
ARM) support uprobes.

I've modified events/uprobes.c to simply call the copy_to_user_page()
function instead of doing a memcpy() followed by a flush_dcache_page()
call.  This results in a net reduction of one line of code in that file.
Then I modified copy_to_user_page() and/or flushing function(s) it
calls to treat a NULL vma pointer to mean:  "assume the user icache
address range is now invalid".  In the majority of cases this is pretty
basic and should be safe as nothing could have been doing this
previously.  In some cases this now results in flushing more icache
than is necessary.  For the mips, sh, sparc, and alpha architectures
something more complicated is necessary and I have not currently done
that.  I am not certain this approach can be made to work cleanly for
those architectures, although there is probably always the last resort
of flushing all icache.  On the other hand, it appears only x86,
powerpc, and (god-willing) ARM currently support uprobes.

I have only tested this on ARM (arndale) at this point.

The preliminary patch follows in my next email.

(BTW, is depending on the C compiler short-circuiting conditonals
acceptable style?)

-dl
