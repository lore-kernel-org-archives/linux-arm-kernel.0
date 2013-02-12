From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Feb 2013 14:00:08 +0000
Subject: [PATCH] [RFC] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <20130211194225.GK29329@parrot.com>
References: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
 <20130211184114.GP9801@mudshark.cambridge.arm.com>
 <20130211194225.GK29329@parrot.com>
Message-ID: <20130212140008.GB4123@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 07:42:25PM +0000, Ivan Djelic wrote:
> On Mon, Feb 11, 2013 at 06:41:14PM +0000, Will Deacon wrote:
> > On Sat, Feb 02, 2013 at 08:33:08AM +0000, Ivan Djelic wrote:
> > > Recent GCC versions (e.g. GCC-4.7.2) perform optimizations based on
> > > assumptions about the implementation of memset and similar functions.
> > > The current ARM optimized memset code does not return the value of
> > > its first argument, as is usually expected from standard implementations.
> > 
> > How does GCC do this? By strcmping the function name and assuming that
> > memset is a libc implementation?
> > 
> > If so, maybe passing something like -ffreestanding would make sense to turn
> > this behaviour off in the compiler (otherwise we should also vet the rest of
> > the standard string functions).
> 
> In theory, yes; but there is actually a short list of libc functions that GCC
> always requires from the environment, even when -ffreestanding is used: memcpy,
> memmove, memset and memcmp (see [1] below).

Interesting... the GCC documentation also states that ffreestanding implies
fno-builtin, so memset and co shouldn't be targetted for this sort of
optimisation by GCC. Have you observed this problem even when passing this
option?

Will
