From: richardmaw@codethink.co.uk (Richard Maw)
Date: Thu, 31 May 2012 11:48:51 +0100
Subject: ARM Versatile defconfig PCI io out of range?
In-Reply-To: <201205310932.51140.arnd@arndb.de>
References: <20120530180242.GA15772@codethink.co.uk>
 <4FC672BA.8070009@gmail.com> <201205310932.51140.arnd@arndb.de>
Message-ID: <20120531104850.GA31825@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 09:32:50AM +0000, Arnd Bergmann wrote:
> It looks like it's a simple bug in pci.c, which puts the wrong thing into the
> pcibios_min_io variable.
> 
> Does the below patch fix it?
> 
> 	Arnd
> 
> diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
> index 4ae4fc8..aeb7b60 100644
> --- a/arch/arm/mach-versatile/pci.c
> +++ b/arch/arm/mach-versatile/pci.c
> @@ -305,7 +305,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
>  
>  void __init pci_versatile_preinit(void)
>  {
> -	pcibios_min_io = 0x44000000;
> +	pcibios_min_io = 0x100;
>  	pcibios_min_mem = 0x50000000;
>  
>  	__raw_writel(VERSATILE_PCI_MEM_BASE0 >> 28, PCI_IMAP0);
> 
Sadly it is still not working. sym53c8xx is still requesting the range
0x44000000-0x440000ff, which is beyond the 0x0000-0xffff specified by
the ioport_resource.
