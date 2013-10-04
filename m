From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 4 Oct 2013 19:35:40 +0200
Subject: [PATCH v3 net-next] fix unsafe set_memory_rw from softirq
In-Reply-To: <CANn89iKkbR0_HaofvC_OVvqRv_Hqj3rATx-Z_4xXeusOasa56g@mail.gmail.com>
References: <1380853446-30537-1-git-send-email-ast@plumgrid.com>
 <20131004075133.GA12313@gmail.com>
 <CANn89iKkbR0_HaofvC_OVvqRv_Hqj3rATx-Z_4xXeusOasa56g@mail.gmail.com>
Message-ID: <20131004173540.GB15689@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Eric Dumazet <edumazet@google.com> wrote:

> 1)
> >
> > I took a brief look at arch/x86/net/bpf_jit_comp.c while reviewing this
> > patch.
> >
> > You need to split up bpf_jit_compile(), it's an obscenely large, ~600
> > lines long function. We don't do that in modern, maintainable kernel code.
> >
> > 2)
> >
> > This 128 bytes extra padding:
> >
> >         /* Most of BPF filters are really small,
> >          * but if some of them fill a page, allow at least
> >          * 128 extra bytes to insert a random section of int3
> >          */
> >         sz = round_up(proglen + sizeof(*header) + 128, PAGE_SIZE);
> >
> > why is it done? It's not clear to me from the comment.
> >
> 
> commit 314beb9bcabfd6b4542ccbced2402af2c6f6142a
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri May 17 16:37:03 2013 +0000
> 
>     x86: bpf_jit_comp: secure bpf jit against spraying attacks
> 
>     hpa bringed into my attention some security related issues
>     with BPF JIT on x86.
> 
>     This patch makes sure the bpf generated code is marked read only,
>     as other kernel text sections.
> 
>     It also splits the unused space (we vmalloc() and only use a fraction of
>     the page) in two parts, so that the generated bpf code not starts at a
>     known offset in the page, but a pseudo random one.

Thanks for the explanation - that makes sense.

	Ingo
