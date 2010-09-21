From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 21 Sep 2010 16:35:23 +0200
Subject: [PATCH v2 2/3] [ARM] tegra: add PCI Express support
In-Reply-To: <201009211430.00325.arnd@arndb.de>
References: <cover.1285070872.git.mike@compulab.co.il>
	<bb6c83c24e809d944beb2950c60cd89257baa1ea.1285070872.git.mike@compulab.co.il>
	<201009211430.00325.arnd@arndb.de>
Message-ID: <4C98C2AB.5060409@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: Colin Cross <ccross@google.com>
>> CC: Gary King <GKing@nvidia.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> On Tuesday 21 September 2010, Mike Rapoport wrote:
>>  /* On TEGRA, many peripherals are very closely packed in
>>   * two 256MB io windows (that actually only use about 64KB
>> @@ -67,10 +67,20 @@ void tegra_iounmap(volatile void __iomem *addr);
>>  
>>  #define IO_ADDRESS(n) ((void __iomem *) IO_TO_VIRT(n))
>>  
>> +#ifdef CONFIG_TEGRA_PCI
>> +extern void __iomem *tegra_pcie_io_base;
>> +
>> +static inline void __iomem *__io(unsigned long addr)
>> +{
>> +       return tegra_pcie_io_base + (addr & IO_SPACE_LIMIT);
>> +}
>> +#else
>>  static inline void __iomem *__io(unsigned long addr)
>>  {
>>         return (void __iomem *)addr;
>>  }
>> +#endif
>> +
>>  #define __io(a)         __io(a)
>>  #define __mem_pci(a)    (a)
> 
> I wonder what the #else path is for. If you don't have PCI, who would
> call __io?

No one should call __io without PCI. However, there are drivers that do not 
build without __io, e.g.:

   CC      drivers/serial/8250.o
drivers/serial/8250.c: In function 'hub6_serial_in':
drivers/serial/8250.c:397: error: implicit declaration of function 'outb'
drivers/serial/8250.c:398: error: implicit declaration of function 'inb'

These references to inb and outb will not be called in runtime anyway, but they 
are required for the 8250 driver to build.
I believe there are other drivers except 8250 that require to have __io, 
although  it will be never actually called on, e.g. Tegra-based platform.

 > And wouldn't that result in a NULL pointer dereference?
> 
> 	Arnd


-- 
Sincerely yours,
Mike.
