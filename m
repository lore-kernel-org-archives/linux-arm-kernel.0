From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 1 Oct 2014 11:07:18 -0500
Subject: [PATCH 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <20141001150418.GA14609@amd>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-2-git-send-email-atull@opensource.altera.com>
 <20141001133527.GA12750@amd> <alpine.DEB.2.10.1410010915440.2332@shineypoop>
 <20141001150418.GA14609@amd>
Message-ID: <542C26B6.7010302@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/1/14, 10:04 AM, Pavel Machek wrote:
> Hi!
> 
>>>> +		__raw_writel(RSTMGR_MPUMODRST_CPU1,
>>>> +			     rst_manager_base_addr + 0x10);
>>>
>>> Would it be possible to copy reset manager description struct from
>>> u-boot and use it here, instead of raw offset?
>>
>> I will replace this 0x10 with a macro that reflects how the register is 
>> named in the register map.
> 
> That would be better than 0x10, but even better would be just copying
> 
> struct socfpga_reset_manager {
>         u32     status;
>         u32     ctrl;
>         u32     counts;
>         u32     padding1;
>         u32     mpu_mod_reset;
>         u32     per_mod_reset;
>         u32     per2_mod_reset;
>         u32     brg_mod_reset;
> };
> 
> from u-boot. Unlike macros, structs have advantages that typos lead to
> easier-to-see failure modes... (And they are easier to read/parse,
> too).
> 

Copying from uboot sounds good, but I already know that the CPU reset
offset is different for our next SOC, Arria 10. The Arria 10 SOC should
still be able to use the same MSL as Cyclone5 and Arria5, but with a few
differences. One of them being, the CPU1 reset offset is at 0x20 instead
of 0x10. So I think having a macro for this one register is a bit
cleaner than having to define a whole new struct for Arria10.

if (of_machine_is_compatible("altr,socfpga-arria10"))
	__raw_writel(0, rst_manager_base_addr + 0x20);
else
	__raw_writel(0, rst_manager_base_addr + 0x10);

Dinh
