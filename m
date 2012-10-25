From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Oct 2012 07:41:45 -0500
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121025093411.GA32662@sig21.net>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net>
Message-ID: <50893389.2090002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 04:34 AM, Johannes Stezenbach wrote:
> On Thu, Oct 11, 2012 at 07:43:22AM -0500, Rob Herring wrote:
>>
>> With recent compilers and move to generic unaligned.h in commit d25c881
>> (ARM: 7493/1: use generic unaligned.h), unaligned accesses will be used
>> by the LZO decompressor on v7 cores. So we need to make sure unaligned
>> accesses are allowed by clearing the SCTLR A bit.
> 
> I just read this in http://gcc.gnu.org/gcc-4.7/changes.html:
> 
>   On ARM, when compiling for ARMv6 (but not ARMv6-M), ARMv7-A, ARMv7-R, or
>   ARMv7-M, the new option -munaligned-access is active by default, which for
>   some source codes generates code that accesses memory on unaligned addresses.
>   This will require the kernel of those systems to enable such accesses
>   (controlled by CP15 register c1, refer to ARM documentation). Alternatively
>   or for compatibility with kernels where unaligned accesses are not supported,
>   all code has to be compiled with -mno-unaligned-access. Linux/ARM in official
>   releases has automatically and unconditionally supported unaligned accesses
>   as emitted by GCC due to this option being active, since Linux version 2.6.28.

I don't think there is such a thing as ARMv6-M.

> My understanding is that gcc, using the same generic unaligned.h
> source code, will generate code for ARMv6 and ARMv7 that uses
> unaligned access, while for ARMv5 and older it won't.  So it seems
> gcc requires Linux to clear SCTLR.A and set SCTLR.U for ARMv6+.
> 
> Or add -mno-unaligned-access.
> 
> Is my understanding correct?
> 
>> While v6 can support unaligned accesses, it is optional and current
>> compilers won't emit unaligned accesses. So we don't clear the A bit for
>> v6.
> 
> not true according to the gcc changes page

What are you going to believe: documentation or what the compiler
emitted? At least for ubuntu/linaro 4.6.3 which has the unaligned access
support backported and 4.7.2, unaligned accesses are emitted for v7
only. I guess default here means it is the default unless you change the
default in your build of gcc.

If we are going to do combined v6k and v7 kernels, then it would be nice
if we could get the compiler to emit unaligned accesses (assuming we
agree we can require that for v6).

Rob
