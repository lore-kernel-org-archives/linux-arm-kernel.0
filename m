From: rick.p.edgecombe@intel.com (Edgecombe, Rick P)
Date: Wed, 21 Nov 2018 19:48:07 +0000
Subject: [PATCH v2 0/2] bpf: permit JIT allocations to be served outside
 the module region
In-Reply-To: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
Message-ID: <9d7f77959e1be0a9a3ff511a8fc45518068c85a6.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-21 at 14:17 +0100, Ard Biesheuvel wrote:
> On arm64, modules are allocated from a 128 MB window which is close to
> the core kernel, so that relative direct branches are guaranteed to be
> in range (except in some KASLR configurations). Also, module_alloc()
> is in charge of allocating KASAN shadow memory when running with KASAN
> enabled.
> 
> This means that the way BPF reuses module_alloc()/module_memfree() is
> undesirable on arm64 (and potentially other architectures as well),
> and so this series refactors BPF's use of those functions to permit
> architectures to change this behavior.
> 
Hi Ard,

I am looking at adding optional BPF JIT in vmalloc functionality for x86 that
would use this refactor. In fact I have done the same thing with just different
names.

My implementation intends to use the module space until a usage limit is reached
and then overflow into vmalloc, so it would be an additional knob like
"bpf_jit_limit". Wondering if that should be a cross-arch concept that connects
to this. Does it fit in with what you are trying to do for arm64 here?

Thanks,

Rick
