From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 22 Nov 2018 23:49:39 +0100
Subject: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
In-Reply-To: <CAKv+Gu-UE0hR-iEkhUieGn+UO_PFs+cD535W1Rq9iyRkgEj=qA@mail.gmail.com>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
 <20181121131733.14910-3-ard.biesheuvel@linaro.org>
 <945415e1-0ff8-65ce-15fa-33cea0a7d1c9@iogearbox.net>
 <CAKv+Gu-UE0hR-iEkhUieGn+UO_PFs+cD535W1Rq9iyRkgEj=qA@mail.gmail.com>
Message-ID: <37f48c6a-e760-87eb-6559-afdd2f116ed6@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2018 09:02 AM, Ard Biesheuvel wrote:
> On Thu, 22 Nov 2018 at 00:20, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 11/21/2018 02:17 PM, Ard Biesheuvel wrote:
>>> The arm64 module region is a 128 MB region that is kept close to
>>> the core kernel, in order to ensure that relative branches are
>>> always in range. So using the same region for programs that do
>>> not have this restriction is wasteful, and preferably avoided.
>>>
>>> Now that the core BPF JIT code permits the alloc/free routines to
>>> be overridden, implement them by simple vmalloc_exec()/vfree()
>>> calls, which can be served from anywere. This also solves an
>>> issue under KASAN, where shadow memory is needlessly allocated for
>>> all BPF programs (which don't require KASAN shadow pages since
>>> they are not KASAN instrumented)
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>> index a6fdaea07c63..f91b7c157841 100644
>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>> @@ -940,3 +940,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>                                          tmp : orig_prog);
>>>       return prog;
>>>  }
>>> +
>>> +void *bpf_jit_alloc_exec(unsigned long size)
>>> +{
>>> +     return vmalloc_exec(size);
>>> +}
>>> +
>>> +void bpf_jit_free_exec(const void *addr)
>>> +{
>>> +     return vfree(size);
>>> +}
>>
>> Hmm, could you elaborate in the commit log on the potential performance
>> regression for JITed progs on arm64 after this change?
> 
> This does not affect the generated code, so I don't anticipate a
> performance hit. Did you have anything in particular in mind?

We do optimize immediate emission in the JIT, I was mostly wondering that
once the code is much further away from core kernel how much more insns we
might need to emit in some worst case for each BPF helper call, but then
unlike some other archs we always use absolute addresses so nothing would
change here, so never mind. (And BPF to BPF calls emits unoptimized 64
immediates since this is needed as we pass through the JIT several times
so we need this as place holder for later once the address is actually
known.)

>> I think this change would also break JITing of BPF to BPF calls. You might
>> have the same issue as ppc64 folks where the offset might not fit into imm
>> anymore and would have to transfer it via fp->aux->func[off]->bpf_func
>> instead.
> 
> If we are relying on BPF programs to remain within 128 MB of each
> other, then we already have a potential problem, given that the
> module_alloc() spills over into a 4 GB window if the 128 MB window is
> exhausted. Perhaps we should do something like

Hmm, good point, presumably you mean this one here fd045f6cd98e ("arm64:
add support for module PLTs"). Agree that this needs fixing.

> void *bpf_jit_alloc_exec(unsigned long size) {
>   return __vmalloc_node_range(size, MODULE_ALIGN,
>     BPF_REGION_START, BPF_REGION_END,
>     GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
>     __builtin_return_address(0));
> }
> 
> and make [BPF_REGION_START, BPF_REGION_END) a separate 128 MB window
> at the top of the vmalloc space. That way, it is guaranteed that BPF
> programs are within branching range of each other, and we still solve
> the original problem. I also like that it becomes impossible to infer
> anything about the state of the vmalloc space, placement of the kernel
> and modules etc from the placement of the BPF programs (in case it
> leaks this information in one way or the other)
> 
> That would only give you space for 128M/4K == 32768 programs (or
> 128M/64K == 2048 on 64k pages kernels). So I guess we'd still need a

Note that it's 4k BPF insns which do not map 1:1, if possible I'd actually
prefer if we could enlarge this space a bit.

> spillover window as well, in which case we'd need a fix for the
> BPF-to-BPF branching issue (but we need that at the moment anyway)

Yeah, or spillover window instead. I think as a fix starting out with
its own region without the spillover window would be less complex and
better suited for stable?

Thanks,
Daniel
