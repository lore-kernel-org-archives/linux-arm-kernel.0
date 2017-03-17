From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 17 Mar 2017 11:11:59 +0000
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170316210454.GA53792@C02RW35GFVH8.dhcp.broadcom.net>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com> <20170310192656.GA13928@C02RW35GFVH8>
 <20170310204112.GA21382@leverpostej>
 <20170315183130.GB32819@C02RW35GFVH8.dhcp.broadcom.net>
 <20170315191741.GB29452@leverpostej>
 <20170315205404.GA43995@C02RW35GFVH8.dhcp.broadcom.net>
 <20170316104204.GA31101@leverpostej>
 <20170316210454.GA53792@C02RW35GFVH8.dhcp.broadcom.net>
Message-ID: <e842a237-9206-99ed-624b-4f3cf15cc557@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/17 21:04, Andy Gospodarek wrote:
> On Thu, Mar 16, 2017 at 10:42:04AM +0000, Mark Rutland wrote:
>> On Wed, Mar 15, 2017 at 04:54:04PM -0400, Andy Gospodarek wrote:
>>> On Wed, Mar 15, 2017 at 07:17:41PM +0000, Mark Rutland wrote:
>>>>
>>>> On Wed, Mar 15, 2017 at 02:31:30PM -0400, Andy Gospodarek wrote:
>>>>> On Fri, Mar 10, 2017 at 08:41:13PM +0000, Mark Rutland wrote:
>>>>>> On Fri, Mar 10, 2017 at 02:26:56PM -0500, Andy Gospodarek wrote:
>>>>>>> On Fri, Mar 10, 2017 at 05:52:30PM +0000, Will Deacon wrote:
>>  
>>>>>>> It isn't the ASM itself that causes the compilation to fail, it's the
>>>>>>> ASM macros included inside the new ifdef that are problematic.  Here is
>>>>>>> what is seen per object file:
>>>>>>
>>>>>>> ./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
>>>>>>> '__smp_store_release'
>>>>>>>                 asm volatile ("stlr %1, %0"
>>>>>>> \
>>>>>>>                                     ^
>>>>>>> 1 warning generated.
>>>>>>> LLVM ERROR: Inline asm not supported by this streamer because we don't  <----  THIS LINE
>>>>>>> have an asm parser for this target
>>>>>>
>>>>>> ... so as far as I can see it's the presence of any inline assembly that
>>>>>> the tool cannot handle, as LLVM tells us.
>>
>>>> In the error message, LLVM explicitly states that it does not have a
>>>> parser for this target's assembly -- which would be a problem for *any*
>>>> inline assembly.
>>>>
>>>> How does that specific error relate to the use of assembly macros within
>>>> sysreg.h?
>>>
>>> This is the only error that is relevant:
>>>
>>> LLVM ERROR: Inline asm not supported by this streamer because we don't have an asm parser for this target
>>>
>>> Upon inspection it does not appear that this is explicitly related to
>>> assembly macros, just simple inline assembly. 
>>
>> Indeed; as Will and I stated previously.
>>
>>> Is this the only inline assembly outside a function that is not inside
>>> #ifdef __ASSEMBLY__ in the arm64 tree?
>>
>> An __ASSEMBLY__ guard is irrelevant. We need the compiler to handle the
>> asm() statement, not the assembler (which cannot even parse it).
>>
>> The kernel uses asm statements outside of functions elsewhere. For
>> example, take a look in <linux/export.h>. See that EXPORT_SYMBOL() uses
>> __CRC_SYMBOL(), which uses asm statements. The EXPORT_SYMBOL() is used
>> outside of functions, on all architectures, arm64 and x86 included.
>>
>> I don't see why being inside a function matters. Given the error
>> message, the toolchain presumably can't parse inline assembly in any
>> context. We have static inline functions with assembly in headers, which
>> are presumably affected.
> 
> You are correct that it appears llvm cannot process any inline asm for
> arm64.  Sadly (or luckily) the inability to process this is not a
> hard-requirement for llvm to properly compile code that includes these
> h-files -- as long as none of #defines/c-macros/inline functions are
> actually *called* in the code I'm trying to compile.
> 
> That is the tricky part about this entire problem and why excluding the
> inline assembly allows me to compile properly while leaving all the
> other assembly inside macros or inline functions is just fine.
> 
> Sorry I continue to harp on this, but I've been testing XDP on ARM64
> using some Broadcom SoCs and I'm seeing some really nice performance
> benefits to being able to process so many frames per second using a
> smaller footprint device.  I'd like to see the ARM64 XDP user community
> grow, but without the ability to easily compile the samples in the
> upstream kernel tree today I just don't see this user- or developer-base
> growing.  
> 
>> It sounds like the toolchain you are using is lacking in functionality
>> that is presumably present when targeting x86, or the error messages are
>> simply misleading. In either case, there's a toolchain issue to be
>> addressed, and not a kernel issue.
> 
> While I generally agree isn't the entire reason this inline asm exists
> -- to fix a binutils issue?  :-)

Binutils is required to build the arm64 kernel; if certain versions of
binutils packaged by arm64 distros can't cope with certain instructions
we need to use, we have to do what we can to make it build. However, if
LLVM cannot cope with inline assembly on arm64, then it's pretty clear
that the kernel cannot be built with LLVM anyway, thus there is nothing
to work around in that regard. Sorry, you've got a straw man there ;)

Robin.

> commit 72c5839515260dce966cd24f54436e6583288e6c
> Author: Catalin Marinas <catalin.marinas@arm.com>
> Date:   Thu Jul 24 14:14:42 2014 +0100
> 
>     arm64: gicv3: Allow GICv3 compilation with older binutils
>    
>     GICv3 introduces new system registers accessible with the full msr/mrs
>     syntax (e.g. mrs x0, Sop0_op1_CRm_CRn_op2). However, only recent
>     binutils understand the new syntax. This patch introduces msr_s/mrs_s
>     assembly macros which generate the equivalent instructions above and
>     converts the existing GICv3 code (both drivers/irqchip/ and
>     arch/arm64/kernel/).
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
