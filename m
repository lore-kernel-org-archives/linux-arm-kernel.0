From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 20 May 2013 11:59:04 +0200
Subject: [RFC PATCH 0/5] ARM: mv78x00: First step to convert mv78x00 to
 Device Tree
In-Reply-To: <20130520094318.GD26249@lunn.ch>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
 <20130520094318.GD26249@lunn.ch>
Message-ID: <5199F3E8.8060008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 11:43 AM, Andrew Lunn wrote:
> On Sun, May 19, 2013 at 11:39:33PM +0200, Gregory CLEMENT wrote:
>> Hello,
>>
>> This patch set is a first step in order to convert mach-mv78x00 to
>> device tree before it joins mach-mvebu.
>>
>> I managed to test it on the RD-78X00-mASA board. All the peripherals I
>> have tested work as they work before the migration to the device tree:
>> - UART
>> - Ethernet
>> - USB
>> - SATA
>>
>> My main concern is that the mv78x00 are MP but not SMP
>> capable. Currently the same kernel run on the 2 cores and it is in the
>> board file that the peripherals are assigned for each CPU. (Actually I
>> didn't test this behavior, but the code is written in this way.)
>>
>> I don't know how to assign a peripheral to a given CPU with the device
>> tree. The only way I have in mind is to have a dts per CPU, but I am
>> not sure it is very convenient.
>>
>> So for now the code assigns all the peripherals to the CPU.
> 
> Hi Gregory

Hi Andrew,

> 
> Could you explain what you have in a bit more detail. Are you just
> bringing up one CPU and assigning all peripherals to that? Or do all
> peripherals get assigned to the first CPU but both are running?

Currently I didn't find (but I didn't looked for so much) how to
boot the kernel on both CPU even with the legacy code. So I am just
bringing up one CPU and assigning all peripherals to that.

> 
> As you say, it looks like you need a DTS subtree per CPU for placing
> peripherals. No idea if it will work, but i guess i would try:
> 
>        ocp at f1000000@cpu0 {
> /include/ "mv78x00-peripherals.dtsi"
>        }
>        ocp at f1000000@cpu1 {
> /include/ "mv78x00-peripherals.dtsi"
>        }
>  
> so you get all the peripherals twice, disabled by default. In the
> board-dt.c you can then do something like:
> 
> 
> 	if (mv78xx0_core_index() == 0) {
> 	   np = of_find_node_by_name(NULL, "ocp at f1000000@cpu0");
> 	else
> 	   np = of_find_node_by_name(NULL, "ocp at f1000000@cpu1");
> 	
>         of_platform_populate(np, kirkwood_dt_match_table, NULL, NULL);
> 

very interesting idea, I will try it to see how it goes!

> There are a few more details, like the GPIO controller has a different
> mask register for CPU1, but that is not supported in the current mvebu
> gpio code. However none of the current 3 boards make use of GPIO, let
> alone GPIO interrupts.
> 
>> I am also concerned by the 2 other boards: the Marvell DB-78x00-BP
>> Development Board and the Buffalo WLX (Terastation Duo) NAS. I don't
>> have them and so I can't test them if I want to convert them to device
>> tree too.
> 
> The Buffalo WLX is interesting. The wxl_init() does not differentiate
> between CPU0 and CPU1, where as the Marvell reference boards do. So i
> suspect only one CPU is running, or its broken.

It looked like a copy and paste of the rd78x00_masa_init function: it kept
the comment about the 2 CPUs "Partition on-chip peripherals between the
two CPU cores."

> 
> It might be interesting to ask on the buffalo forums if anybody is
> actually using mainline on TS-WLX.

Do you know where is this forum?

Thanks for your review and your ideas!

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
