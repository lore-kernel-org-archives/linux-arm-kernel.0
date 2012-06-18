From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 21:23:54 +0200
Subject: [RFC PATCH 7/8] ARM: vmlinux.lds: Setup physical load address
 not virtual
In-Reply-To: <alpine.LFD.2.02.1206181433130.23555@xanadu.home>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-8-git-send-email-monstr@monstr.eu>
 <alpine.LFD.2.02.1206181000540.23555@xanadu.home>
 <CAHTX3dJS9zNejv-oLGpbZdXdkJndwR1pcBd9yn3OAobGy3ZLjA@mail.gmail.com>
 <alpine.LFD.2.02.1206181433130.23555@xanadu.home>
Message-ID: <4FDF804A.5080404@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 09:02 PM, Nicolas Pitre wrote:
> On Mon, 18 Jun 2012, Michal Simek wrote:
>
>> 2012/6/18 Nicolas Pitre<nicolas.pitre@linaro.org>
>>
>>> On Mon, 18 Jun 2012, Michal Simek wrote:
>>>
>>>> Setup correct virtual and physical address in ELF LOAD section.
>>>
>>> We are moving to a single kernel binary for multiple targets, including
>>> targets with different physical load addresses.  The kernel code figures
>>> out at run time what the actual physical address is when
>>> CONFIG_ARM_PATCH_PHYS_VIRT is set which is the default these days.  In
>>> other words, we don't know the physical offset at build time in that
>>> case and CONFIG_PHYS_OFFSET is simply not defined.
>>>
>>
>> ok. good to know and nice features. In that case I expect that you are
>> using any binary format and you copy it to memory and run it. Code
>> find out where it runs and based on that setup things.
>
> Exact.

ok. One more question about this feature. What is the alignment for it?
I mean I have done the similar feature for Xilinx ppc440 and alignment depends on
MMU TLB size.

>
>> (BTW: This is very interesting for me to implement it on Microblaze. Can
>> you point me to that kernel code part? or any doc?)
>
> You could have a look at https://wiki.ubuntu.com/Specs/ARMSingleKernel,
> especially the section "Optimized virt_to_phys() with a runtime
> determined PHYS_OFFSET".
>
> Then the following commits should be of interest:
>
> 72a20e22f4 "ARM: P2V: eliminate head.S use of PHYS_OFFSET for !XIP_KERNEL"
>
> dc21af99fa "ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching"

ok. Thanks will look at it.

>
>> But can you do it with elf?
>
> No.

ok

>
>> Please correct me if I am wrong IRC ARM Qemu uses zImage but it is no
>> problem to use elf file. For this case
>> Qemu elf loader also uses physical addresses from ELF and also entry point.
>
> If you want to use the ELF image, then you need to hardcode the physical
> memory location in its header, and that's something we want to get away
> from because it prevents a single kernel binary image from being used on
> different targets with different memory layouts.  Same issue with
> u-Boot's legacy uImage format.

And are you able to get these information away from ELF? Or you just need to set it up
to any default value. I would expect to 0x0.


>
>> I haven't played with CONFIG_ARM_PATCH_PHYS_VIRT option but what is elf
>> entry point for this case?
>
> For the kernel image itself it is the kernel virtual address.

Is it used somewhere? Or is it just setup to virtual address and no code use it?
I mean that kernel virtual entry point.

I expect that if CONFIG_ARM_PATCH_PHYS_VIRT=y then CONFIG_PHYS_OFFSET is not setup
Then LOAD_OFFSET should be equal to CONFIG_PAGE_OFFSET.

>
> For the relocatable zImage decompressor wrapper it is 0.

ok.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
