From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 05 May 2011 08:56:06 +1200
Subject: AT91: Interrupt handling independent of processor base-address
In-Reply-To: <4DC1B9A3.7050107@bluewatersys.com>
References: <1304291042.22966.12.camel@redbox>
	<4DC1B9A3.7050107@bluewatersys.com>
Message-ID: <4DC1BD66.5060905@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2011 08:40 AM, Ryan Mallon wrote:
> On 05/02/2011 11:04 AM, Andrew Victor wrote:
>> For supporting multiple AT91 processors in a single kernel image, the
>> base address of the AIC controller needs to be calculated in the
>> processor initialization code and then provided to the AIC driver.
>>  * Low-level IRQ hander in entry-macro.S also updated.
>>  * AT91_AIC definitions renamed to AT91xxx_AIC.
>>
>> All these patches are here:
>>  git://github.com/at91linux/linux-2.6-at91.git/av-devel
>>
>> Signed-off-by: Andrew Victor <linux@maxim.org.za>

<snip>

>> diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
>> index aff808b..8b04b3c 100644
>> --- a/arch/arm/mach-at91/irq.c
>> +++ b/arch/arm/mach-at91/irq.c
>> @@ -33,23 +33,26 @@
>>  #include <asm/mach/irq.h>
>>  #include <asm/mach/map.h>
>>  
>> +/* Base IO address of AIC */
>> +void __iomem *at91_aic_base_addr __read_mostly;
>> +
> 
> Since we eventually will have a number of these base addresses as
> variables is it worth consolidating them into a single struct, i.e:
> 
> struct at91_sys {
> 	void __iomem *aic;
> 	void __iomem *dbgu;
> 	void __iomem *pioa;
> 	...
> };
> 
> struct at91_sys at91_sys __read_mostly;

Ignore this. Looking at the other patches you have posted its not a
viable idea.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
