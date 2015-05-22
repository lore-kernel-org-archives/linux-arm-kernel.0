From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 May 2015 09:08:23 +0200
Subject: Question on why specific ELF relocations are supported for module
 loader
In-Reply-To: <2A1C86A3-CCBE-4D59-88DF-910A2562D0E0@stanford.edu>
References: <2A1C86A3-CCBE-4D59-88DF-910A2562D0E0@stanford.edu>
Message-ID: <CAKv+Gu9bUJ703-CzFA3+Pnx4C9u+LWEW22Jq_6Kz3RaBkTfUyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2015 at 08:46, Yifan Lu <yifanlu@stanford.edu> wrote:
> I'm referring to linux/arch/arm/kernel/module.c. It seems to be an arbitrary subset of ARM ELF relocations. (The manual lists about 130 types of relocations.) Is it because GCC only outputs these types? Or is there another reason? Also, isn't static relocations only used for static linking?
>

Under the configuration that is used to compile the kernel, only a
small subset of those relocations will ever be emitted by GCC. For
instance, since we are building without -fpic, many of the GOT and PLT
related ones will just never occur. And, since modules are not shared
libraries, but just partially linked object files, the runtime linking
that occurs actually resembles static linking more than it resembles
dynamic linking. (There is no support for things like lazy resolution
of jump targets or symbol preemption that the ELF standard defines.)
Also, while text relocations are typically avoided in userland since
they defeat sharing of code pages, this is not a problem in the
kernel.
