From: james.morse@arm.com (James Morse)
Date: Thu, 25 Aug 2016 16:27:47 +0100
Subject: [PATCH] arm64: mark reserved memblock regions explicitly in iomem
In-Reply-To: <20160822065524.8085-1-takahiro.akashi@linaro.org>
References: <20160822065524.8085-1-takahiro.akashi@linaro.org>
Message-ID: <57BF0E73.7060801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 22/08/16 07:55, AKASHI Takahiro wrote:
> Kdump(kexec-tools) parses /proc/iomem to identify all the memory regions
> on the system. Since the current kernel names "nomap" regions, like UEFI
> runtime services code/data, as "System RAM," kexec-tools sets up elf core
> header to include them in a crash dump file (/proc/vmcore).
> 
> Then crash dump kernel parses UEFI memory map again, re-marks those regions
> as "nomap" and does not create a memory mapping for them unlike the other
> areas of System RAM. In this case, copying /proc/vmcore through
> copy_oldmem_page() on crash dump kernel will end up with a kernel abort,
> as reported in [1].
> 
> This patch names all the "nomap" regions explicitly as "reserved" so that
> we can exclude them from a crash dump file. acpi_os_ioremap() must also
> be modified because those regions have WB attributes [2].
> 
> Apart from kdump, this change also matches x86's use of acpi (and
> /proc/iomem).
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448186.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450089.html


Tested on Seattle on v4.8-rc3, /proc/iomem Before:
8000000000-8001e7ffff : System RAM
8001e80000-83ff186fff : System RAM
  8002080000-8002baffff : Kernel code
  8002ca0000-8002db1fff : Kernel data
83ff187000-83ff1c4fff : System RAM
83ff1c5000-83ff224fff : System RAM
83ff225000-83ffe42fff : System RAM
83ffe43000-83ffffffff : System RAM

/proc/iomem After:
8000000000-8001e7ffff : reserved
8001e80000-83ff186fff : System RAM
  8002080000-8002baffff : Kernel code
  8002ca0000-8002db1fff : Kernel data
83ff187000-83ff1c4fff : reserved
83ff1c5000-83ff224fff : System RAM
83ff225000-83ffe42fff : reserved
83ffe43000-83ffffffff : System RAM

Which matches the output from 'efi=debug'.

I can also kdump with v24 of your series, and copy the vmcore file with
read()/mmap() and dig through it with crash.

Tested-by: James Morse <james.morse@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>


The only side-effect of this I could find is we now allow access to the UEFI
areas when built with CONFIG_STRICT_DEVMEM, which is what the help text says
should happen, so it was broken before.



Thanks,

James
