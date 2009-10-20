From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 20 Oct 2009 21:51:35 +0200
Subject: [PATCH] Use CONFIG_VECTORS_BASE instead of hardcoded 0xffff0000.
In-Reply-To: <1256054856-20404-1-git-send-email-benoit.fouet@free.fr>
References: <1256054856-20404-1-git-send-email-benoit.fouet@free.fr>
Message-ID: <63386a3d0910201251n4e6fec18le5a2d2cd0941be78@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/20 Benoit Fouet <benoit.fouet@free.fr>:

> The configuration option exists but is not used everywhere,
> this patch tries to make it the default instead of the
> hardcoded value.

Previously IIRC these could only be placed at 0x00000000 or
0xffff0000, and I haven't heard of it being changed, and the
code surrounding this surely does not take into account that
it could be anything that 0 or 0xffff0000.

With a recursive
cd arch/arm/ && grep -r CONFIG_VECTORS_BASE .
you see that everybody and his dog is using 0xffff0000
(high vectors).

I think we'd rather get rid of CONFIG_VECTORS_BASE
with that hex value, this config value could for example
be CONFIG_VECTORS_LOW | CONFIG_VECTORS_HIGH, mutually
exclusive instead, and then _LOW will basically never be used
and things become simpler, I think having a hex value for
CONFIG_VECTORS_BASE is actually confusing since that
may give people the (false) idea that this can be set to anything.

> (...)
> ? ? ? ?/*
> ? ? ? ? * Create a mapping for the machine vectors at the high-vectors
> - ? ? ? ?* location (0xffff0000). ?If we aren't using high-vectors, also
> + ? ? ? ?* location (CONFIG_VECTORS_BASE). ?If we aren't using high-vectors, also
> ? ? ? ? * create a mapping at the low-vectors virtual address.
> ? ? ? ? */
> ? ? ? ?map.pfn = __phys_to_pfn(virt_to_phys(vectors));
> - ? ? ? map.virtual = 0xffff0000;
> + ? ? ? map.virtual = CONFIG_VECTORS_BASE;
> ? ? ? ?map.length = PAGE_SIZE;
> ? ? ? ?map.type = MT_HIGH_VECTORS;
> ? ? ? ?create_mapping(&map);

Speaking of this: for machines with TCM (like the U300) we'd probably
like to move our ITCM to 0xffff0000 (CONFIG_VECTORS_BASE) and alter
the code so that iff CONFIG_VECTORS_BASE == __sitcm_text the
vectors page will not be allocated and mapped, and vectors go into
ITCM instead. The idea is that since TCM fast as cache, it's a pretty
good idea to lock them in there. (Seen on other ARM OS:es...)

I'll try to make a patch for that someday.

Linus Walleij
