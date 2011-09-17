From: rabin@rab.in (Rabin Vincent)
Date: Sat, 17 Sep 2011 11:37:26 +0530
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <CAH+eYFBSiL44CMOpgED+TAOTUH_dQMaKKu=hC3ynG0Y2nQ8ekw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 01:45, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> There are some cases where the code generated for BUG() results
> into an infinite while loop without causing a null dereference,
> this ends on a kernel being stuck on a loop and the user without
> a clue of what happened.
>
> E.g.: lib/scatterlist.c : __sg_alloc_table
>
> ? ? ? ?BUG_ON(nents > max_ents);
> ?438: ? 9a000000 ? ? ? ?bls ? ? 440 <__sg_alloc_table+0x20>
> ?43c: ? eafffffe ? ? ? ?b ? ? ? 43c <__sg_alloc_table+0x1c>
>
> Adding volatile makes the compiler to avoid optimizations on this
> code, which makes the panic to occur:
>
> ? ? ? ?BUG_ON(nents > max_ents);
> ?438: ? 9a000002 ? ? ? ?bls ? ? 448 <__sg_alloc_table+0x28>
> ?43c: ? e3a03000 ? ? ? ?mov ? ? r3, #0
> ?440: ? e5833000 ? ? ? ?str ? ? r3, [r3]
> ?444: ? eafffffc ? ? ? ?b ? ? ? 43c <__sg_alloc_table+0x1c>
>
> Seen with gnu/linux cs arm-2010q1-202 and arm2010.09-50.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

If the "Use generic BUG() handler" patch is only scheduled for the next
merge window and not for 3.1, can this patch be merged instead for 3.1
and -stable?  This problem is easily seen with GCC 4.6.
