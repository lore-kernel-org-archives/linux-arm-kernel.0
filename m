From: yang.shi@linaro.org (Shi, Yang)
Date: Mon, 12 Oct 2015 11:41:54 -0700
Subject: Run armv7 32 bit userspace on aarch64
In-Reply-To: <20151012175026.GL16124@arm.com>
References: <5615A0E1.1050402@linaro.org> <56184079.1040905@linaro.org>
 <56185B98.2060400@linaro.org> <6978725.cJktLf4M1X@wuerfel>
 <561BED2C.8080008@linaro.org> <561BF011.80205@linaro.org>
 <20151012175026.GL16124@arm.com>
Message-ID: <561BFEF2.2030503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 10:50 AM, Will Deacon wrote:
> On Mon, Oct 12, 2015 at 10:38:25AM -0700, Shi, Yang wrote:
>> BTW, it may be related to unaligned address.
>>
>> init[1]: unhandled level 3 translation fault (11) at 0x43acfad3, esr
>> 0x92000047
>> pgd = ffff80007b8be000
>> [43acfad3] *pgd=00000000fb8c5003, *pud=00000000fb8c1003,
>> *pmd=00000000fb8c2003, *pte=0000000000000000
>>
>> The userspace is trying to write to 0x43acfad3, the permission is
>> readonly.
>
> What's the instruction making the access? If it's a store-multiple, then

My aarch64 gdb just shows hex code instead of human readable assembly code.

It is 0xe5c02000.

I just checked the ARMv7 manual, it looks like STRB instruction, so we 
can rule this out.

I just figured out it is caused by gcc 5.2 pre-link. It works if I 
disable pre-link. The pre-link issue breaks all armv7 userspace even 
though it is run on armv7 machines.

Yang

> we don't support that in the arm64 kernel. It would be nice if the 32-bit
> kernel had the same behaviour, but the patch seems to have stalled and
> probably doesn't apply anymore:
>
>    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7944/1
>
> Will
>
