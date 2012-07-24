From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Jul 2012 07:33:49 -0500
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <201207191412.00540.arnd@arndb.de>
References: <50049285.1060100@gmail.com> <201207191412.00540.arnd@arndb.de>
Message-ID: <500E962D.2080104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2012 09:12 AM, Arnd Bergmann wrote:
> On Monday 16 July 2012, Rob Herring wrote:
>> Arnd,
>>
>> Please pull io.h PCI clean-up series. As you suggested, lets get it in
>> next for test and decide later if to apply it for 3.6 or wait.
>>
>> BTW, I'll have sporadic email access over the next 2 weeks.
> 
> I think we need this one:
> 
> iop13xx ended up with two conflicting definitions for
> IOP13XX_PCIE_LOWER_IO_BA, where one of them is used to set up
> the hardware window and should be zero, while the other one is
> used to set the location of the second mapping into the virtual
> address space.
> 
> This kills the second definition and hardcodes the 64KB offset
> that is already hardcoded in the bios32.c file now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> index 9278b8c..cc9e058 100644
> --- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> +++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> @@ -95,7 +95,6 @@ extern unsigned long get_iop_tick_rate(void);
>  /* PCI-E ranges */
>  #define IOP13XX_PCIE_LOWER_IO_PA      	 0xfffd0000UL
>  #define IOP13XX_PCIE_LOWER_IO_BA      	 0x0UL  /* OIOTVR */
> -#define IOP13XX_PCIE_LOWER_IO_BA      	 0x10000UL

This means we have PCIE and PCIX buses both using i/o bus addresses
starting at 0x0. We can't have that, right?

The requested resource won't match either as the resource start address
is bus_nr * 64K.

Rob

>  
>  #define IOP13XX_PCIE_MEM_PHYS_OFFSET  	 0x200000000ULL
>  #define IOP13XX_PCIE_MEM_WINDOW_SIZE  	 0x3a000000UL
> diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
> index 56a4b41..9cad41b 100644
> --- a/arch/arm/mach-iop13xx/pci.c
> +++ b/arch/arm/mach-iop13xx/pci.c
> @@ -1058,7 +1058,7 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
>  
>  		__raw_writel(pcsr, IOP13XX_ATUE_PCSR);
>  
> -		pci_ioremap_io(IOP13XX_PCIE_LOWER_IO_BA, IOP13XX_PCIE_LOWER_IO_PA);
> +		pci_ioremap_io(SZ_64K, IOP13XX_PCIE_LOWER_IO_PA);
>  
>  		res->start = IOP13XX_PCIE_LOWER_MEM_RA;
>  		res->end   = IOP13XX_PCIE_UPPER_MEM_RA;
> 
> 
