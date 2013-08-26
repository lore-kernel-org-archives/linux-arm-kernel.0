From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 26 Aug 2013 17:36:15 +0300
Subject: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
 from DT
In-Reply-To: <20130803183143.GE23053@n2100.arm.linux.org.uk>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-2-git-send-email-t-kristo@ti.com>
 <20130803183143.GE23053@n2100.arm.linux.org.uk>
Message-ID: <521B67DF.4000005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2013 09:31 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 02, 2013 at 07:25:20PM +0300, Tero Kristo wrote:
>> +
>> +	if (cl)
>> +		return cl;
>> +
>> +	/* If clock was not found, attempt to look-up from DT */
>> +	node = of_find_node_by_name(NULL, con_id);
>
> This is utterly broken if you're looking up purely by a connection ID.
> Please, go back and read clk_get()'s documentation in linux/clk.h.
> It's spelt out very plainly there.
>
> NAK.
>

Hi Russell,

After looking at this a bit more, it seems difficult to get rid of the 
clk_get -> of_clk_get conversion, however based on this comment I am 
somewhat stuck. Do you think it would be acceptable if I change the 
implementation of this patch to work like this:

1) both dev_id + con_id defined:
    a) search for device node named dev_id
    b) check clock-names for matching con_id
    c) return matching clock

    Example in kernel:
       clocksource-nomadik-mtu.c :
           clk_get_sys("mtu0", "apb_pclk");

       ste-nomadik-snt8815.dts:
         mtu0: mtu at 101e2000 {
                 /* Nomadik system timer */
                 compatible = "st,nomadik-mtu";
                 reg = <0x101e2000 0x1000>;
                 interrupt-parent = <&vica>;
                 interrupts = <4>;
                 clocks = <&timclk>, <&pclk>;
                 clock-names = "timclk", "apb_pclk";
         };

2) dev_id = NULL, con_id defined (current patch implementation, most of 
the OMAP clocks use this approach):
    a) search for a device node named con_id
    b) return corresponding clock from the node

Alternatively I must implement a regression and break some of the OMAP 
drivers with this set, and also implement omap internal clk_get 
functionality (basically adding a similar wrapper that I have 
implemented in this patch) under mach-omap2 to get some basic OMAP infra 
to work properly (namely, hwmod.) I can probably avoid part of this by 
adding more beef to the *.dts files for the critical parts to get boot 
working at least.

-Tero
