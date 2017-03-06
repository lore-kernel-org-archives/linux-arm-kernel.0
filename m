From: dalias@libc.org (Rich Felker)
Date: Sun, 5 Mar 2017 20:52:07 -0500
Subject: [PATCH 1/3] futex: remove duplicated code
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
References: <20170303122712.13353-1-jslaby@suse.cz>
Message-ID: <20170306015207.GN1520@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
> 
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
> 
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).

Overall I'm in favor of this patch, and it's close to what I had in
mind in the commit message for
00b73d8d1b7131da03aec73011a7286f566fe87f. But I'd actually like to see
it go further. These ops are mainly (only?) used for the (almost never
used) FUTEX_WAKE_OP operation, and there's very little sense in trying
to optimize them with dedicated arch-specific forms like "lock xadd".
Instead the entire logic should be in an arch-generic file, and all
the arch should need to provide is a cmpxchg-on-user-memory primitive
for it to use. On most archs, the same cmpxchg used in kernelspace
should also work for user addresses, meaning a huge amount of
unmaintained, largely untested, junk code can be removed.

Rich
