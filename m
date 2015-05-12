From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 12 May 2015 17:05:07 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2
In-Reply-To: <4196844.lz3ZASOAJx@wuerfel>
References: <1431371529-22593-1-git-send-email-dinguyen@opensource.altera.com>
 <1431371529-22593-2-git-send-email-dinguyen@opensource.altera.com>
 <4187963.lx6hRMGsoN@wuerfel> <4196844.lz3ZASOAJx@wuerfel>
Message-ID: <55527913.6010807@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 03:25 PM, Arnd Bergmann wrote:
> On Tuesday 12 May 2015 22:20:53 Arnd Bergmann wrote:
>> On Monday 11 May 2015 14:12:09 dinguyen at opensource.altera.com wrote:
>>> SoCFPGA updates for v4.2
>>> - Add big endian support
>>> - Add earlyprintk support on UART1 that is used on Arria10
>>> - Remove the need to map uart_io_desc
>>>
>>
>> The patches look almost ok, but please clarify a minor issue:
>>
>>  static void __init socfpga_map_io(void)
>>  {
>>         socfpga_scu_map_io();
>> -       iotable_init(&uart_io_desc, 1);
>> -       early_printk("Early printk initialized\n");
>>  }
>>
>>
>> You have a map_io() function here, which means that the debug_ll_io_init()
>> function is not called. How does the debug_ll mapping get created then?
>>
>> If it's not, I think the best solution is to remove the socfpga_map_io()
>> function entirely, and turn socfpga_scu_base_addr into a local variable
>> in arch/arm/mach-socfpga/platsmp.c that gets set using of_iomap().
>>
> 
> 
> One more thing: the socfpga board in Olof's boot farm fails to boot
> with multi_v7_defconfig, see
> http://arm-soc.lixom.net/bootlogs/arm-soc/v4.1-rc3-165-g3d58f43/socfpga-arm-multi_v7_defconfig.html
> 
> Could you have a look and see if you can reproduce that probem and send
> a fix if possible? It seems to work fine with socfpga_defconfig, so maybe
> it's just some Kconfig option we need to enable?
> 

Yes, I've started debugging this, but got sidetracked. The issue is that
the multi_v7_defconfig is enabling both CONFIG_PL330_DMA and CONFIG_PM.
There was a patch recently that mapped the UARTs on the platform to it's
proper DMA channel:

commit 78c03c7af897 ARM: socfpga: fix uart DMA binding error

So after the kernel has booted, and user space takes over, it tries to
open up the debug uart using DMA. But it appears the DMA has been
suspended and did not resume, thus the clock to the PL330 DMA is turned
off, and the UART hangs.

In case, you're curious here's a link to an incorrect patch that I sent
to turn on the PL330's clock:

http://www.spinics.net/lists/dmaengine/msg04409.html

I'll try to get back on this asap.

Thanks,
Dinh
