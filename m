From: lasse.collin@tukaani.org (Lasse Collin)
Date: Fri, 25 May 2012 22:35:37 +0300
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FBFB3F3.1000606@hp.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120525113432.3beea6ed@tukaani.org> <4FBFB3F3.1000606@hp.com>
Message-ID: <20120525223537.3f537e26@tukaani.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-05-25 Thavatchai Makphaibulcboke wrote:
> Yes, I agree that having a shared file would be the best solution.
> Unfortunately with the current preboot architecture and infra
> structure, it would not be a trivial task.

I agree.

> I believe defining these functions for each arch would give a better
> code modularity compared to including them in the decompressor file.

I guess so. decompress_unxz.c certainly isn't the right place for those
functions. The arch-specific files also allow arch-specific
optimizations if someone finds them useful.

> > These already have memcpy. It can save a few bytes if one reused
> > memmove as memcpy when using XZ compression. I got a difference of
> > 48 bytes on x86_64.
> 
> We could do that.  But according to the comment in the original
> implementation, there seems to be a concern regarding its performance
> speed. If you believe all archs' memcpy would give comparable
> performance to the memmove. then I could do that.

In a generic case, you can replace memcpy with memmove but not vice
versa. memmove is generally slower than memcpy because memmove has to
support overlapping buffers.

I guess the current comment in decompress_unxz.c could be clearer. In
short, memmove and memcpy speeds don't matter much *for kernel
decompression* which is done in the single-call mode of the XZ
decompressor on archs that currently support XZ. memcpy speed could
matter if the kernel image contained a large amount of incompressible
data, but even if it did, it shouldn't matter much.

> > Adding memmove to string.c on x86 means that memmove is included in
> > the kernel image even when memmove isn't needed. With gzip
> > compression I got 128 bytes bigger image on x86_64 after adding the
> > unneeded memmove to string.c.
> > 
> > I don't know if those size increases matter in practice.
> 
> For x86, I think I could move memmove to the misc.c file and put an
> ifdef XZ_PREBOOT around it.  This way it should not impact other
> decompressor.  I could also do this for s390 and sh.  But if we decide
> to replace memmove with memcpy this would be necessart.

Or you can use #ifdef CONFIG_KERNEL_XZ in string.c. XZ_PREBOOT is kind
of internal define to the XZ code so it's not good to rely on it.

If you add a static memmove function to misc.c, compiler can omit it
when memmove isn't used. Since misc.h pulls <linux/string.h> via
<linux/elf.h> and so there's a prototype of extern memmove already, one
needs to call the static function e.g. my_memmove and #define memmove
my_memmove. This way you don't need to #ifdef it to any particular
decompressors.

If memmove is used to implement memcpy, you probably cannot avoid
decompressor-specific #ifdefs unless you use memmove for all
decompressors. The question is how clean code you want vs. how much you
care about saving 30-150 bytes in bzImage size.

-- 
Lasse Collin  |  IRC: Larhzu @ IRCnet & Freenode
