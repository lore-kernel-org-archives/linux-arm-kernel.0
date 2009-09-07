From: dirk.behme@googlemail.com (Dirk Behme)
Date: Mon, 07 Sep 2009 17:56:04 +0200
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1252337372.23780.73.camel@pc1117.cambridge.arm.com>
References: <4A7AEEB6.5060903@googlemail.com>	
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>	
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>	
	<20090817140422.GA10764@n2100.arm.linux.org.uk>	
	<1251548848.5030.11.camel@pc1117.cambridge.arm.com>	
	<1251707405.7930.7.camel@pc1117.cambridge.arm.com>
	<1252337372.23780.73.camel@pc1117.cambridge.arm.com>
Message-ID: <4AA52D14.4020406@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Catalin Marinas wrote:
> Hi Russell,
> 
> On Mon, 2009-08-31 at 09:30 +0100, Catalin Marinas wrote: 
>> On Sat, 2009-08-29 at 13:27 +0100, Catalin Marinas wrote:
>>> It looks like this is causing the problem. Setting the protection to RW
>>> and writing data (not instructions) causes the text page to be COW'ed
>>> (page mapped with MAP_PRIVATE). Some cache flushing is missing on VIPT
>>> caches during page copying for COW. With ARM11MPCore, the D-cache is
>>> write-allocate so it never makes it to the main memory for the I-cache
>>> to pick.
>>>
>>> I'll look again next week on where to best add the flushing (or just
>>> modify the dynamic linker to avoid COW on text pages). Any suggestions?
>> After talking to the toolchain people, it seems that the dynamic linker
>> is just doing whatever the ELF file says regarding the relocations. The
>> problem in this case is that when compiling with -pie, one of the crt*.o
>> files (and _start) used in PIE applications is not position-independent.
>>
>> I think this was fixed (but not released yet) by CodeSourcery but you
>> can get this behaviour if some files of an executable were not compiled
>> with -fpic. So the mprotect cache flushing patch that I posted looks
>> like a valid workaround.
> 
> There is a glibc patch to allow fully position-independent code and
> avoid CoW for text pages:
> 
> http://sourceware.org/ml/libc-ports/2008-10/msg00009.html
> 
> We tested it and it seems to solve the problem without requiring a
> kernel patch.

Regarding "fix the tool chain/libc and not the kernel":

The initial issue we are discussing here was found with a user space 
application downloaded as binary. Namely Ubuntu-ARM. While we could 
try to fix some tool chains, we never will be able to fix all tool 
chains out there. There will be ever some binaries compiled with a 
non-patched tool chain, resulting in ARM11 MPCore failures.

Additionally, this Ubuntu ARM port runs fine on single core ARM11 
(e.g. N800) or Cortex A8 (e.g OMAP3 based BeagleBoard). It's my 
understanding that the issue we are discussing here is ARM11 MPCore 
kernel (cache handling?) specific, then. So it should be fixed in 
kernel, too, to be able to run the same binaries the same way on ARM11 
MPCore like on ARM11 single core or Cortex A8.

> Any opinion on whether the ARM kernel should support dynamic shared
> objects where not all objects are position-independent? IOW, whether
> text relocations are allowed to be resolved at run-time rather than
> compile (static link) time for the dynamic shared objects? AFAICT, there
> isn't anything in the ARM EABI which would prevent this, so a kernel
> patch may be needed.

 From what mentioned above, I think a kernel patch is needed.

> There is a similar situation for RWX pages and CoW. In this case, the
> copy_user_highpage() function should probably be modified to clean the
> D-cache and invalidate the I-cache.

Many thanks for your help and best regards

Dirk
