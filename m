From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Nov 2011 10:10:58 +0000
Subject: [PATCH 1/4] ARM: ftrace: use canonical Thumb-2 wide instruction
 format
In-Reply-To: <4ECDF0BA.1050707@windriver.com>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <20111122120242.GD2066@localhost.localdomain>
 <CAH+eYFBfcpKYrq-kyV4RZ-s1En5Q2wy6dhuEsk6KNgk-zb7wDw@mail.gmail.com>
 <20111123144238.GB2050@localhost.localdomain>
 <4ECDF0BA.1050707@windriver.com>
Message-ID: <20111125101058.GA2098@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 03:22:34PM +0800, Bi Junxiao wrote:
> on 11/23/2011 10:42 PM Dave Martin wrote:
> >On Tue, Nov 22, 2011 at 11:30:11PM +0530, Rabin Vincent wrote:
> >>On Tue, Nov 22, 2011 at 17:32, Dave Martin<dave.martin@linaro.org>  wrote:
> >>>On Mon, Nov 21, 2011 at 08:43:46PM +0530, Rabin Vincent wrote:
> >>>>+#ifndef __ARMEB__
> >>>>+     if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> >>>>+             old = (old>>  16) | (old<<  16);
> >>>>+             new = (new>>  16) | (new<<  16);
> >>>I think swahw32() in<linux/swab.h>  can be used for this operation.
> >>Yes.
> >>
> >>>Really though, we need a common set of "load and store instruction"
> >>>macros, rather than duplicating this knowledge everywhere.
> >>Yes, though this ftrace code may not be able to use them directly since
> >>it uses probe_kernel_read()/write().
> >In that case what we would want are macros to convert instructions between
> >integer and in-memory representation, rather than conflating all that
> >together in some memory accessor macros.
> >
> >How about:
> >
> >#include<linux/swab.h>
> >
> >#ifdef __ARMEB__
> >#define insn_to_mem_arm(insn) swab32(insn)
> >#define insn_to_mem_thumb16(insn) swab16(insn)
> >#define insn_to_mem_thumb32(insn) swab16(insn)
> >#else
> >#define insn_to_mem_arm(insn) (insn)
> >#define insn_to_mem_thumb16(insn) (insn)
> >#define insn_to_mem_thumb32(insn) shahw32(insn)
> >#endif
> >
> >#define mem_to_insn_arm(insn) insn_to_mem_asm(insn)
> >#define mem_to_insn_thumb16(insn) insn_to_mem_thumb16(insn)
> >#define mem_to_insn_thumb32(insn) insn_to_mem_thumb32(insn)
> >
> >Because these are all straightforward swap operations, we don't really
> >need separate forwards and backwards operations, but having the separate
> >names may make calling code easier to read.
> >
> >I'm still not sure exactly which header this belongs in, but it's a core
> >ARM thing; not local to kprobes or ftrace, etc.
> >
> Yes, these macros are useful for be8 support. Do they deserve a
> separated header file as there is no appropriate one for them now?
> >If this looks sensible, it would also make sense for Junxiao Bi to build
> >his big-endian fixes on it.

I don't really see a header where this stuff fits.

I'll post an RFC.

Cheers
---Dave
