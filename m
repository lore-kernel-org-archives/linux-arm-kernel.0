From: gangchen@rdamicro.com (=?utf-8?B?6ZmI5YiaKEdhbmdjaGVuKQ==?=)
Date: Thu, 31 Mar 2016 11:20:24 +0000
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: <20160331103020.GH3701@e103592.cambridge.arm.com>
References: <1459138743-10477-1-git-send-email-chengang.beijing@gmail.com>
 <3792990.eCI4tPEEyD@wuerfel>
 <20160329102605.GC3701@e103592.cambridge.arm.com>
 <20160329103418.GX19428@n2100.arm.linux.org.uk>
 <20160329105637.GD3701@e103592.cambridge.arm.com>
 <56FB4784.1060105@rdamicro.com>
 <20160330140718.GG3701@e103592.cambridge.arm.com>
 <56FCD815.7000503@rdamicro.com>
 <20160331103020.GH3701@e103592.cambridge.arm.com>
Message-ID: <56FD07F5.9060300@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/31/2016 06:30 PM, Dave Martin wrote:
> On Thu, Mar 31, 2016 at 07:56:05AM +0000, ??(Gangchen) wrote:
>> On 03/30/2016 10:07 PM, Dave Martin wrote:
>>> On Wed, Mar 30, 2016 at 03:27:01AM +0000, ??(Gangchen) wrote:
>>>> On 03/29/2016 06:56 PM, Dave Martin wrote:
> [...]
>
>>>>> I wonder whether the following would be cleaner than having these
>>>>> aliased arguments:
>>>>>
>>>>> 	asm(	/* ... */
>>>>> 		"bl	__do_div64"
>>>>> 		: "+r" (__n), "=r" (__res)
>>>>> 		: "r" (__base)
>>>>> 		: "ip", "lr", "cc");
>>>>> 	*n = __res;
>>>>> 	return __n >> 32;
>>>>>
>>>>> (providing that GCC doesn't make a mess of the "easy" shift).
>>>> I tried your proposal. It didn't make any difference: this is inline
>>>> function and gcc just ignores your trick.
>>> What doesn't work for you when using this method?
>>>
>>> Why does the fact that this is an inline function make a difference?
>> With the help of other colleagues, I understand your proposal now.
>> I create a patch and I can verify that it works!
> Ah, OK.  I was wondering whether I made a mistake somewhere.
>
>> Should I submit it, as it seems better than this one I sent?
> It's up to you -- I think my approach is a bit cleaner, but your
> approach worked too and is not vulnerable to compilers that generate
> silly code for (uint64_t) >> 32.
(uint64_t) >> 32 is pretty much the standard way to get upper half of an 
uint64 variable, compiler should not
generate silly code for this.
> Note that I only tested my code for little endian -- it should do the
> right thing for BE, but I recommend that you try it and examine the
> generated code, to make sure.
I don't have a BE system to test, but I did check assembly code 
generated for BE system and didn't find
anything wrong.

I will update the new patch soon.

The following is my test code and assembly dump for BE system of the 
function.

typedef unsigned long long ull;
ull mydiv64y(ull tt, unsigned base, unsigned *p)
{
     ull t = tt;
     *p = do_div(t, base);
     *p = do_div(tt, base+1);
     return tt;
}

/mnt/2nd_disk/rdaMicro/aosp_4.4/test_modules/div_test/.tmp_test_div.o: 
file format elf32-bigarm


Disassembly of section .text:

00000000 <mydiv64y>:
    0:    e92d 47f0     stmdb    sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
    4:    4607          mov    r7, r0
    6:    2600          movs    r6, #0
    8:    4698          mov    r8, r3
    a:    ea57 0306     orrs.w    r3, r7, r6
    e:    4681          mov    r9, r0
   10:    460d          mov    r5, r1
   12:    4692          mov    sl, r2
   14:    d111          bne.n    3a <mydiv64y+0x3a>
   16:    f102 0401     add.w    r4, r2, #1
   1a:    4608          mov    r0, r1
   1c:    4621          mov    r1, r4
   1e:    f7ff fffe     bl    0 <__aeabi_uidivmod>
   22:    4628          mov    r0, r5
   24:    460f          mov    r7, r1
   26:    4621          mov    r1, r4
   28:    f7ff fffe     bl    0 <__aeabi_uidiv>
   2c:    4632          mov    r2, r6
   2e:    4601          mov    r1, r0
   30:    f8c8 7000     str.w    r7, [r8]
   34:    4610          mov    r0, r2
   36:    e8bd 87f0     ldmia.w    sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
   3a:    4614          mov    r4, r2
   3c:    f7ff fffe     bl    0 <__do_div64>
   40:    f10a 0401     add.w    r4, sl, #1
   44:    f8c8 0000     str.w    r0, [r8]
   48:    4629          mov    r1, r5
   4a:    4648          mov    r0, r9
   4c:    f7ff fffe     bl    0 <__do_div64>
   50:    4619          mov    r1, r3
   52:    4607          mov    r7, r0
   54:    e7ec          b.n    30 <mydiv64y+0x30>
   56:    bf00          nop

>
> Cheers
> ---Date
