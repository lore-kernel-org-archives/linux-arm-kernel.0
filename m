From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 6 Oct 2014 10:56:55 -0500
Subject: [PATCHv2] arm: socfpga: fix fetching cpu1start_addr for system
 with  > 2GB of ram
In-Reply-To: <20141003215844.GX5182@n2100.arm.linux.org.uk>
References: <1412370540-20670-1-git-send-email-dinguyen@opensource.altera.com>
 <20141003215844.GX5182@n2100.arm.linux.org.uk>
Message-ID: <5432BBC7.9040702@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 10/03/2014 04:58 PM, Russell King - ARM Linux wrote:
> On Fri, Oct 03, 2014 at 04:09:00PM -0500, dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> When CPU1 is brought out of reset, it's MMU is not turned yet, so it will only
>> be able to use physical addresses. For systems with 1GB or less, clearing
>> 0x40000000 will work just fine, as it was just converting the virtual address
>> of &cpu1start_addr into a physical address. But for systems with > 2BG, bit
>> clearing 0x40000000 is not enough to get the physical address of &cpu1start_addr
>> correctly.
>>
>> This patch fixes the secondary_trampoline code to correctly fetch the physical
>> address of cpu1start_addr directly.
>>
>> While at it, change the name of cpu1start_addr to socfpga_cpu1start_addr
>> to avoid any future naming collisions for multiplatform image.
> 
> I'm still not happy with this.  I see why my suggestion didn't work, but
> this is still pretty dire - and will break when we add read-only text
> support to the kernel (you are writing into the text segment.)
> 
> The reason my suggestion broke is because you aren't executing the code
> in the kernel, you're copying it into SRAM and executing it there.  I
> think you need to come up with some way to locate the physical address
> in the SRAM, either before or after the function you're copying there.
> 

This seems to also work. What do you think?

ENTRY(secondary_trampoline)
        adr     r0, 1f
        ldmia   r0, {r1, r2}
        sub     r2, r2, #PAGE_OFFSET
        ldr     r3, [r2]
        ldr     r4, [r3]
        bx      r4

        .align
1:      .long   .
        .long   cpu1start_addr
ENTRY(secondary_trampoline_end)
