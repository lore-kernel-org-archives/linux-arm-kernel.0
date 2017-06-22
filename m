From: dvhart@infradead.org (Darren Hart)
Date: Wed, 21 Jun 2017 20:53:37 -0700
Subject: [PATCH 1/1] futex: remove duplicated code and fix UB
In-Reply-To: <20170621115318.2781-1-jslaby@suse.cz>
References: <20170621115318.2781-1-jslaby@suse.cz>
Message-ID: <20170622035337.GF25900@fury>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 01:53:18PM +0200, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
> 
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
> 
> This effectively distributes the Will Deacon's arm64 fix for undefined
> behaviour reported by UBSAN to all architectures. The fix was done in
> commit 5f16a046f8e1 (arm64: futex: Fix undefined behaviour with
> FUTEX_OP_OPARG_SHIFT usage).  Look there for an example dump.
> 
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).
> 

This required a minor manual merge for ARM on the tip of Linus' tree today. The
reduced duplication is a welcome improvement.

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>

-- 
Darren Hart
VMware Open Source Technology Center
