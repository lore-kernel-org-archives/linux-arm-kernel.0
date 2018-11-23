From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Nov 2018 22:12:21 +0100
Subject: [PATCH v3 1/2] bpf: add __weak hook for allocating executable
 memory
In-Reply-To: <a3e95c22-fcae-3550-2d3c-4d07eaad95ae@iogearbox.net>
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
 <20181123094152.21368-2-ard.biesheuvel@linaro.org>
 <a3e95c22-fcae-3550-2d3c-4d07eaad95ae@iogearbox.net>
Message-ID: <CAKv+Gu9SwbXaoBxUGaFSrBocWkjSGY3qMUqFaqK=p_DoGz4tjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Nov 2018 at 22:07, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/23/2018 10:41 AM, Ard Biesheuvel wrote:
> > By default, BPF uses module_alloc() to allocate executable memory,
> > but this is not necessary on all arches and potentially undesirable
> > on some of them.
> >
> > So break out the module_alloc() and module_memfree() calls into __weak
> > functions to allow them to be overridden in arch code.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  kernel/bpf/core.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 1a796e0799ec..572dd74c26e3 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -609,6 +609,16 @@ static void bpf_jit_uncharge_modmem(u32 pages)
> >       atomic_long_sub(pages, &bpf_jit_current);
> >  }
> >
> > +void *__weak bpf_jit_alloc_exec(unsigned long size)
> > +{
> > +     return module_alloc(size);
> > +}
> > +
> > +void __weak bpf_jit_free_exec(const void *addr)
> > +{
> > +     module_memfree(addr);
> > +}
> > +
> >  struct bpf_binary_header *
> >  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >                    unsigned int alignment,
> > @@ -626,7 +636,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >
> >       if (bpf_jit_charge_modmem(pages))
> >               return NULL;
> > -     hdr = module_alloc(size);
> > +     hdr = bpf_jit_alloc_exec(size);
> >       if (!hdr) {
> >               bpf_jit_uncharge_modmem(pages);
> >               return NULL;
> > @@ -650,7 +660,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> >       u32 pages = hdr->pages;
> >
> > -     module_memfree(hdr);
> > +     bpf_jit_free_exec(hdr);
> >       bpf_jit_uncharge_modmem(pages);
>
> The const needs to be removed, this generates the following warning:
>
> # make -j8 kernel/bpf/
>   DESCEND  objtool
>   CALL    scripts/checksyscalls.sh
>   CC      kernel/bpf/core.o
>   CC      kernel/bpf/syscall.o
>   CC      kernel/bpf/verifier.o
>   CC      kernel/bpf/hashtab.o
>   CC      kernel/bpf/helpers.o
>   CC      kernel/bpf/inode.o
>   CC      kernel/bpf/arraymap.o
>   CC      kernel/bpf/lpm_trie.o
> kernel/bpf/core.c: In function ?bpf_jit_free_exec?:
> kernel/bpf/core.c:619:17: warning: passing argument 1 of ?module_memfree? discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
>   module_memfree(addr);
>                  ^~~~
> In file included from kernel/bpf/core.c:28:0:
> ./include/linux/moduleloader.h:30:6: note: expected ?void *? but argument is of type ?const void *?
>  void module_memfree(void *module_region);
>       ^~~~~~~~~~~~~~
>   CC      kernel/bpf/local_storage.o
> [...]
>
> Please respin with that fixed.
>

OK.

I'll respin the second patch as well, and move the BPF window to the
start of the vmalloc region. However, the arm64 maintainers need to
ack that as well since it modifies the layout of the kernel virtual
address space.
