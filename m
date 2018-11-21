From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 21 Nov 2018 21:36:22 +0100
Subject: [PATCH v2 0/2] bpf: permit JIT allocations to be served outside
 the module region
In-Reply-To: <9d7f77959e1be0a9a3ff511a8fc45518068c85a6.camel@intel.com>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
 <9d7f77959e1be0a9a3ff511a8fc45518068c85a6.camel@intel.com>
Message-ID: <CAKv+Gu9jrYH_79b11nZgb5NOJrZrRNEz7Sy3OrgVHE+rRsYigg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Nov 2018 at 20:48, Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2018-11-21 at 14:17 +0100, Ard Biesheuvel wrote:
> > On arm64, modules are allocated from a 128 MB window which is close to
> > the core kernel, so that relative direct branches are guaranteed to be
> > in range (except in some KASLR configurations). Also, module_alloc()
> > is in charge of allocating KASAN shadow memory when running with KASAN
> > enabled.
> >
> > This means that the way BPF reuses module_alloc()/module_memfree() is
> > undesirable on arm64 (and potentially other architectures as well),
> > and so this series refactors BPF's use of those functions to permit
> > architectures to change this behavior.
> >
> Hi Ard,
>
> I am looking at adding optional BPF JIT in vmalloc functionality for x86 that
> would use this refactor. In fact I have done the same thing with just different
> names.
>
> My implementation intends to use the module space until a usage limit is reached
> and then overflow into vmalloc, so it would be an additional knob like
> "bpf_jit_limit". Wondering if that should be a cross-arch concept that connects
> to this. Does it fit in with what you are trying to do for arm64 here?
>

Hi Rick,

As I understand it, x86 requires the BPF allocations to be located
within 2 GB of the core kernel, so that RIP-relative 32-bit jumps are
in range (I read that in a comment somewhere, or a git commit log
perhaps)

That requirement does not exist on arm64: ordinary function calls and
tail calls emitted by the BPF JIT code have unlimited range, and so
there is simply no reason to prefer the module region for these
allocations. I guess we could achieve the same when reusing your
approach by setting the threshold to zero.
