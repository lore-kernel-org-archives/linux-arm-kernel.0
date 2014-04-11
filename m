From: davem@davemloft.net (David Miller)
Date: Fri, 11 Apr 2014 00:36:36 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <5347655B.3080307@linaro.org>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
Message-ID: <20140411.003636.272212797007496394.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Long <dave.long@linaro.org>
Date: Thu, 10 Apr 2014 23:45:31 -0400

> Replace memcpy and dcache flush in generic uprobes with a call to
> copy_to_user_page(), which will do a proper flushing of kernel and
> user cache.  Also modify the inmplementation of copy_to_user_page
> to assume a NULL vma pointer means the user icache corresponding
> to this right is stale and needs to be flushed.  Note that this patch
> does not fix copy_to_user page for the sh, alpha, sparc, or mips
> architectures (which do not currently support uprobes).
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>

You really need to pass the proper VMA down to the call site
rather than pass NULL, that's extremely ugly and totally
unnecesary.
