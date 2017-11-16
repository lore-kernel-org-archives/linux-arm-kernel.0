From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Thu, 16 Nov 2017 07:56:50 -0600
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171116130742.wijnukjetoupi4hc@yury-thinkpad>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
 <20171116115433.GG9361@arm.com>
 <20171116130742.wijnukjetoupi4hc@yury-thinkpad>
Message-ID: <20171116135650.GQ10515@gate.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 04:07:42PM +0300, Yury Norov wrote:
> > > Use UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
> > > in-place and workaround gcc and clang limitations on redefining macros
> > > across different assembler blocks.
> > 
> > What limitations? Can you elaborate please? Is this a fix?

> Regarding GCC.
> 
> When it joins preprocessed source files into single asm file,
> mrs_s/msr_s becomes either not declared or declared multiple times.
> 
> ./ccuFb68h.s:33120: Error: Macro `mrs_s' was already defined
> ./ccuFb68h.s:33124: Error: Macro `msr_s' was already defined
> 
> I'm not sure that GCC works correctly in this case, and I sent the
> email to Linaro toolchain group to clarify it. See below.

The compiler is free to inline code, reorder code, duplicate code, etc.
Inline assembler is not exempt from this.

The compiler is fine, the assembler is fine (and the linker has nothing
to do with it).  Your code is not fine.


Segher
