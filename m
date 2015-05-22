From: yifanlu@stanford.edu (Yifan Lu)
Date: Fri, 22 May 2015 00:22:38 -0700
Subject: Question on why specific ELF relocations are supported for module
 loader
In-Reply-To: <CAKv+Gu9bUJ703-CzFA3+Pnx4C9u+LWEW22Jq_6Kz3RaBkTfUyA@mail.gmail.com>
References: <2A1C86A3-CCBE-4D59-88DF-910A2562D0E0@stanford.edu>
 <CAKv+Gu9bUJ703-CzFA3+Pnx4C9u+LWEW22Jq_6Kz3RaBkTfUyA@mail.gmail.com>
Message-ID: <5F7922C2-6807-42D5-912B-418239E48331@stanford.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is it even standards adherent that static relocation is used in an executable (rather than an object file)? Is there anything is GCC that will ensure that only these kinds of relocations are generated? I'm designing a simple ARM system that loads ELFs and I would rather not support all 130 relocations so this Linux module loader is a good model.
> On May 22, 2015, at 12:08 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> On 22 May 2015 at 08:46, Yifan Lu <yifanlu@stanford.edu> wrote:
>> I'm referring to linux/arch/arm/kernel/module.c. It seems to be an arbitrary subset of ARM ELF relocations. (The manual lists about 130 types of relocations.) Is it because GCC only outputs these types? Or is there another reason? Also, isn't static relocations only used for static linking?
>> 
> 
> Under the configuration that is used to compile the kernel, only a
> small subset of those relocations will ever be emitted by GCC. For
> instance, since we are building without -fpic, many of the GOT and PLT
> related ones will just never occur. And, since modules are not shared
> libraries, but just partially linked object files, the runtime linking
> that occurs actually resembles static linking more than it resembles
> dynamic linking. (There is no support for things like lazy resolution
> of jump targets or symbol preemption that the ELF standard defines.)
> Also, while text relocations are typically avoided in userland since
> they defeat sharing of code pages, this is not a problem in the
> kernel.
