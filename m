From: lasse.collin@tukaani.org (Lasse Collin)
Date: Fri, 25 May 2012 11:34:32 +0300
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <1337875436-27640-1-git-send-email-tmac@hp.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
Message-ID: <20120525113432.3beea6ed@tukaani.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-05-24 T Makphaibulchoke wrote:
> The patch cleans up the file lib/decompress_unxz.c by removing all
> memory helper functions, e.g., memmove.  By doing so, any
> architecture's preboot environment supporting the XZ decompression
> needs to define its own copy of any of the missing memory helper
> functions.

Is it best to copy these functions to each arch, or would it be better
to have a shared file from which these functions could be pulled for
multiple archs? I wasn't sure when I wrote decompress_unxz.c, which is
why I put the extra functions there as a temporary solution.

> Adding both the missing memmove and memcmp functions, required by the
> XZ decompressor, to the sh preboot environment.
> 
> Adding the missing memmove function, required by XZ decompressor, to
> the x86 preboot environment.

These already have memcpy. It can save a few bytes if one reused
memmove as memcpy when using XZ compression. I got a difference of 48
bytes on x86_64.

Adding memmove to string.c on x86 means that memmove is included in the
kernel image even when memmove isn't needed. With gzip compression I
got 128 bytes bigger image on x86_64 after adding the unneeded memmove
to string.c.

I don't know if those size increases matter in practice.

> + * To support XZ-decompressed file in preboot environment, the

s/XZ-decompressed/XZ-compressed/ :-)

-- 
Lasse Collin  |  IRC: Larhzu @ IRCnet & Freenode
