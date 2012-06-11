From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 11 Jun 2012 12:19:34 +0200
Subject: [PATCH] ARM: EXYNOS: Add smc call to support trustzone feature
In-Reply-To: <20120611094423.GC11168@n2100.arm.linux.org.uk>
References: <20120611090440.GA27207@july>
 <20120611094423.GC11168@n2100.arm.linux.org.uk>
Message-ID: <03bb01cd47bb$b531f920$1f95eb60$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a forwarded message originally posted by Kyungmin Park [kyungmin.park at samsung.com]:

On 6/11/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Jun 11, 2012 at 06:04:40PM +0900, Kyungmin Park wrote:
>> +/*
>> + * Read registers
>> + * Function signature: u32 exynos_smc_readsfr(u32 addr, u32 *val)
> 
> What address space is 'addr' in?

It's Memory Controller address with physical address space. I don't know why this
address is required. It's vendor specific address. If exynos_smc_readsfr is ambiguous,
then it will drop at this time.

>> + */
>> +ENTRY(exynos_smc_readsfr)
>> +    stmfd    sp!, {r4-r11, lr}
>> +    mov      r2, #0
>> +    lsr        r0, r0, #2
>> +    mov      ip, r1
>> +    mov      r3, r2
>> +    orr       r1, r0, #0xC0000000
> 
> I assume this is not PAGE_OFFSET.

Right, it's also vendor specific command.

To read SFR, it send r0 = -101, r1 =  (0x3 << 30) | ((addr) >> 2), r2 = r3 = 0;

> 
>> +    mvn      r0, #100
> 
> Hmm.  The compiler will automatically use mvn instead of a normal mov with
> negative numbers.  It may be clearer to write:
> 
>         mov      r0, #-101

exactly. I refered the compiled generated codes. I'll change it.

> 
>> +    dsb
>> +    smc      #0
>> +    cmn      r0, #101
> 
> Same here:
>         cmp      r0, #-101
> 
> Notice that writing it this way means it's obvious that you're checking
> for -101, the original value passed in.
> 
>> +    beq      1f
>> +    cmp      r0, #0
>> +    streq    r2, [ip]
>> +    ldmfd    sp!, {r4-r11, pc}
>> +1:  subs     r0, r1, #0
> 
> Isn't this just a normal:
>         movs    r0, r1
> 
> ?
> 
>> +    streq    r2, [ip]
>> +    ldmfd    sp!, {r4-r11, pc}
>> +ENDPROC(exynos_smc_readsfr)
> 
> In any case, can't this end part be written:
> 
>         cmp      r0, #-101
>         moveq   r0, r1
>         teq       r0, #0              @ I prefer teq over cmp to test equality
>         streq    r2, [ip]
>         ldmfd    sp!, {r4 - r11, pc}

I'll change it.

Thank you,
Kyungmin Park
