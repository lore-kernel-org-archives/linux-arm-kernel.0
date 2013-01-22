From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Jan 2013 15:36:37 -0500 (EST)
Subject: arm: Kernel failures when several memory banks are used with
 starting address above 128MB
In-Reply-To: <CAHTX3dJZxuoz_0Eaa7QcoK9bF4LdLuWcDcwK3OUKc6qY_0PeuQ@mail.gmail.com>
References: <CAHTX3dJZxuoz_0Eaa7QcoK9bF4LdLuWcDcwK3OUKc6qY_0PeuQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1301221528050.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013, Michal Simek wrote:

> Hi,
> 
> I have a question regarding to the case where DTS specify one memory bank
> for example <0x0 0x40000000> with CONFIG_ARM_PATCH_PHYS_VIRT=y
> where the kernel can be loaded at a 16MB boundary.
> I was testing it on the 3.8-rc4 on arm zynq.
> 
> 1. If the kernel is loaded within 0 - 127MB memory then the kernel can
> work with the whole
> 1GB memory. It shows that the memory in front of the kernel is also
> available for the kernel.
> 
> 2. If the kernel is loaded on the higher addresses then it fails by
> these error messages.
> "Ignoring RAM at 00000000-3fffffff (vmalloc region overlap).
> Memory policy: ECC disabled, Data cache writeback
> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0."
> 
> 3. If I use several memory banks solution
> for example
> reg = <0 0x10000000 0x10000000 0x30000000>;
> and the kernel is loaded to 0x10008000 then the first memory bank is
> ignored and kernel will boot.
> "Ignoring RAM at 00000000-0fffffff (vmalloc region overlap)." with
> 768MB of memory.
> 
> 4. The next interesting example is description with 3 memory banks.
> reg = <0 0x10000000 0x10000000 0x20000000 0x30000000 0x10000000>;
> which behaves as point 3. It means the first 128MB is ignored and only
> 768MB of ram is available.
> 
> 
> The real question is how the kernel should behave for these situations.
> I would expect that if the kernel is within one memory bank
> then it will use this whole bank
> Or
> I would expect that the memory which is in front of the kernel start address
> will be simple ignored and the kernel will find out which memory bank
> is used and will use it.
> Not just caused kernel panic.
> Or
> Is there any expectation that you have to run the relocatable kernel
> in the first 128MB of the memory
> or changing DTS depending on the kernel position where it is loaded?

There are two kernel config symbols influencing this:

config AUTO_ZRELADDR
        bool "Auto calculation of the decompressed kernel image address"
        depends on !ZBOOT_ROM && !ARCH_U300
        help
          ZRELADDR is the physical address where the decompressed kernel
          image will be placed. If AUTO_ZRELADDR is selected, the address
          will be determined at run-time by masking the current IP with
          0xf8000000. This assumes the zImage being placed in the first 128MB
          from start of memory.

config ARM_PATCH_PHYS_VIRT
        bool "Patch physical to virtual translations at runtime" if EMBEDDED
        default y
        depends on !XIP_KERNEL && MMU
        depends on !ARCH_REALVIEW || !SPARSEMEM
        help
          Patch phys-to-virt and virt-to-phys translation functions at
          boot and module load time according to the position of the
          kernel in system memory.

          This can only be used with non-XIP MMU kernels where the base
          of physical memory is at a 16MB boundary.

          Only disable this option if you know that you do not require
          this feature (eg, building a kernel for a single machine) and
          you need to shrink the kernel to the minimal size.

Of course, the kernel must be loaded at some address within the provided 
RAM information in DT as well.  If you cannot meet those restrictions 
then the corresponding features have to be disabled in your build.


Nicolas
