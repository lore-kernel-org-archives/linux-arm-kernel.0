From: achandran@mvista.com (Arun Chandran)
Date: Wed, 13 Aug 2014 21:47:24 +0530
Subject: [PATCH] Arm64: convert part of soft_restart() to assembly
In-Reply-To: <20140813144942.GF32644@leverpostej>
References: <1407930881-533-1-git-send-email-achandran@mvista.com>
 <20140813144942.GF32644@leverpostej>
Message-ID: <CAFdej02hEz6y8xvtDfn-V_J5JfaEKYZnF5+HxKUqUof9=Q7pWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
On 8/13/14, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Arun,
>
> On Wed, Aug 13, 2014 at 12:54:41PM +0100, Arun Chandran wrote:
>> The current soft_restart() and setup_restart implementations incorrectly
>> assume that compiler will not spill/fill values to/from stack. However
>> this assumption seems to be wrong, revealed by the disassembly of the
>> currently existing code (v3.16) built with Linaro GCC 4.9-2014.05.
>>
>> ffffffc000085224 <soft_restart>:
>> ffffffc000085224:  a9be7bfd  stp    x29, x30, [sp,#-32]!
>> ffffffc000085228:  910003fd  mov    x29, sp
>> ffffffc00008522c:  f9000fa0  str    x0, [x29,#24]
>> ffffffc000085230:  94003d21  bl     ffffffc0000946b4
>> <setup_mm_for_reboot>
>> ffffffc000085234:  94003b33  bl     ffffffc000093f00 <flush_cache_all>
>> ffffffc000085238:  94003dfa  bl     ffffffc000094a20 <cpu_cache_off>
>> ffffffc00008523c:  94003b31  bl     ffffffc000093f00 <flush_cache_all>
>> ffffffc000085240:  b0003321  adrp   x1, ffffffc0006ea000 <reset_devices>
>>
>> ffffffc000085244:  f9400fa0  ldr    x0, [x29,#24] ----> spilled addr
>> ffffffc000085248:  f942fc22  ldr    x2, [x1,#1528] ----> spilled
>> memstart_addr
>
> Nit: s/spilled memstart_addr/global memstart_addr/
>
>> ffffffc00008524c:  f0000061  adrp   x1, ffffffc000094000
>> <__inval_cache_range+0x40>
>> ffffffc000085250:  91290021  add    x1, x1, #0xa40
>> ffffffc000085254:  8b010041  add    x1, x2, x1
>> ffffffc000085258:  d2c00802  mov    x2, #0x4000000000           //
>> #274877906944
>> ffffffc00008525c:  8b020021  add    x1, x1, x2
>> ffffffc000085260:  d63f0020  blr    x1
>> ...
>>
>> The compiler is clearly spilling here around the cache being disabled,
>> resulting in stale values being restored. As we cannot control the
>> compiler's
>> spilling behaviour we must rewrite the functions in assembly to
>> avoid use of the stack.
>
> Given we also seeing accesses to globals, let's change this to:
>
> Here the compiler generates memory accesses after the cache is disabled,
> loading stale values for the spilled value global variable. As we cannot
> control when the compiler will access memory we must rewrite the
> functions in assembly to stash values we need in registers prior to
> disabling the cache, avoiding the use of memory.
>

Will do that.

>> Signed-off-by: Arun Chandran <achandran@mvista.com>
>
> Given that:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks for putting this together, and thanks for bearing with me for the
> last few revisions.
>
No problem. Thanks for bearing with a new comer (me). Will post a new
one tomorrow.

--Arun
