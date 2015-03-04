From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 04 Mar 2015 15:16:41 +1100
Subject: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
In-Reply-To: <1425341988-1599-5-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-5-git-send-email-keescook@chromium.org>
Message-ID: <1425442601.9084.9.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-02 at 16:19 -0800, Kees Cook wrote:
> This fixes the "offset2lib" weakness in ASLR for arm, arm64, mips,
> powerpc, and x86. The problem is that if there is a leak of ASLR from
> the executable (ET_DYN), it means a leak of shared library offset as
> well (mmap), and vice versa. Further details and a PoC of this attack
> are available here:
> http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html
> 
> With this patch, a PIE linked executable (ET_DYN) has its own ASLR region:
> 
> $ ./show_mmaps_pie
> 54859ccd6000-54859ccd7000 r-xp  ...  /tmp/show_mmaps_pie
> 54859ced6000-54859ced7000 r--p  ...  /tmp/show_mmaps_pie
> 54859ced7000-54859ced8000 rw-p  ...  /tmp/show_mmaps_pie

Just to be clear, it's the fact that the above vmas are in a different
address range to those below that shows the patch is working, right?

> 7f75be764000-7f75be91f000 r-xp  ...  /lib/x86_64-linux-gnu/libc.so.6
> 7f75be91f000-7f75beb1f000 ---p  ...  /lib/x86_64-linux-gnu/libc.so.6


On powerpc I'm seeing:

# /bin/dash
# cat /proc/$$/maps
524e0000-52510000 r-xp 00000000 08:03 129814                             /bin/dash
52510000-52520000 rw-p 00020000 08:03 129814                             /bin/dash
10034f20000-10034f50000 rw-p 00000000 00:00 0                            [heap]
3fffaeaf0000-3fffaeca0000 r-xp 00000000 08:03 13529                      /lib/powerpc64le-linux-gnu/libc-2.19.so
3fffaeca0000-3fffaecb0000 rw-p 001a0000 08:03 13529                      /lib/powerpc64le-linux-gnu/libc-2.19.so
3fffaecc0000-3fffaecd0000 rw-p 00000000 00:00 0 
3fffaecd0000-3fffaecf0000 r-xp 00000000 00:00 0                          [vdso]
3fffaecf0000-3fffaed20000 r-xp 00000000 08:03 13539                      /lib/powerpc64le-linux-gnu/ld-2.19.so
3fffaed20000-3fffaed30000 rw-p 00020000 08:03 13539                      /lib/powerpc64le-linux-gnu/ld-2.19.so
3fffc7070000-3fffc70a0000 rw-p 00000000 00:00 0                          [stack]


Whereas previously the /bin/dash vmas were up at 3fff..

So looks good to me for powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
