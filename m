From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 19 Sep 2010 16:07:02 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <201009161912.12330.arnd@arndb.de>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009161912.12330.arnd@arndb.de>
Message-ID: <4C961906.4040303@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> On Thursday 16 September 2010 18:53:33 Mike Rapoport wrote:
>> These patches enable PCI Express support on Tegra2.
>> The implementation is based on original NVidia code from (1), but it
>> is heavily reworked to avoid custom PCI enumeration and make the code
>> more Linux friendly.
>>
>> This implementation assumes that the PCIe subsystem is fully powered
>> and ungated by the bootloader.
> 
> The patches look good to me, but it seems that I/O space accesses are
> still broken and need to be redirected to the PCI I/O range, like
> the (totally untested) patch below.

Thanks for catching this.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
> index 35edfc3..d54e384 100644
> --- a/arch/arm/mach-tegra/include/mach/io.h
> +++ b/arch/arm/mach-tegra/include/mach/io.h
> @@ -21,7 +21,8 @@
>  #ifndef __MACH_TEGRA_IO_H
>  #define __MACH_TEGRA_IO_H
>  
> -#define IO_SPACE_LIMIT 0xffffffff
> +/* Two 1MB windows */
> +#define IO_SPACE_LIMIT (SZ_1M + SZ_1M - 1)

This would limit ioport_resource to 2M, and request_resource(&ioport_resource, 
&res) will fail because ioport_resource does not take into account that IO can 
start somewhere else than at 0.
>  
>  /* On TEGRA, many peripherals are very closely packed in
>   * two 256MB io windows (that actually only use about 64KB
> @@ -69,7 +70,7 @@ void tegra_iounmap(volatile void __iomem *addr);
>  
>  static inline void __iomem *__io(unsigned long addr)
>  {
> -	return (void __iomem *)addr;
> +	return addr + tegra_pcie.regs + SZ_4M;

I wish things were that simple :)
As far as I understand, the IO space should be mapped prior to use and __io 
should return the virtual address.
I'll add it for the next re-spin.

>  }
>  #define __io(a)         __io(a)
>  #define __mem_pci(a)    (a)


-- 
Sincerely yours,
Mike.
