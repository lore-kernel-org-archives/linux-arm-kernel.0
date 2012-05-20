From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 20 May 2012 14:05:54 +0100 (BST)
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <20120520095110.GC12741@lunn.ch>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120520095110.GC12741@lunn.ch>
Message-ID: <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 May 2012, Andrew Lunn wrote:

> On Fri, May 18, 2012 at 11:50:42AM +0200, Arnaud Patard wrote:
>> Hi,
>>
>> I wanted to convert iconnect to use the new nand DT support on kirkwood
>> but my system was freezing hard during boot. So, I've debugged it a
>> little bit and have several questions.
>>
>> The first one is about were is defined the nand. It's defined as a leaf
>> of the "ocp" bus. I would have expected to see it at the same level but
>> I've seen nothing proving if it's wrong or right when comparing with
>> hardware. Can anyone give me some information about that ?
>>
>> Now, the real questions about my problem. It's hanging because the nand
>> platform device created throught DT is called f4000000.nand and not
>> orion_nand. This means that the clock gets disabled by
>> clk_disable_unused() so first access to the nand fails badly.
>> To workaround, I've added into mach-kirkwood/common.c:
>>
>> +       orion_clkdev_add(NULL, "f4000000.nand", runit);
>
> Although this works, its the wrong way to do it. Jamie Lentin figured
> out the right way to do this. Jamie, care to explain please...

board-dt.c should have an auxdata struct, to fix the name of 
"f4000000.nand" to orion_nand:-

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 3cef3c7..6d45a07 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -24,6 +24,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
  	{ }
  };

+struct of_dev_auxdata kirkwood_dt_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("mrvl,orion-nand", KIRKWOOD_NAND_MEM_PHYS_BASE, "orion_nand", NULL),
+	{ }
+};
+
  static void __init kirkwood_dt_init(void)
  {
  	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
@@ -61,7 +66,8 @@ static void __init kirkwood_dt_init(void)
  	if (of_machine_is_compatible("dlink,dns-kirkwood"))
  		dnskw_init();

-	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
+	of_platform_populate(NULL, kirkwood_dt_match_table,
+			kirkwood_dt_auxdata_lookup, NULL);
  }

  static const char *kirkwood_dt_board_compat[] = {

I should really submit this :) What should it be based on? A new revision 
of my previous patches, or should I assume that my work and Andrew's clk 
work have already been merged? (apologies if this is a dumb question)

>> The bonus question is that while debugging this issue, I've disabled
>> all nand declarations in kirkwood.dtsi and my localy modified
>> kirkwood-iconnect.dts but I was still getting a hard freeze. I think
>> that means that the "runit" clock is doing more than NAND and SPI but
>> I've found no details in the 6281 manual about what's using this
>> clock.
>
> Yes, i found the same. I tried extending the SPI driver so that it
> turned the clock off between transfers. Hard crash like you. I suspect
> i might have to mark this clock as not to be turned off when unused.

+1 --- I found this also when the last patchset temporarily removed all 
NAND support (and thus RUNIT was being disabled during startup).

>
>  Andrew
>

-- 
Jamie Lentin
