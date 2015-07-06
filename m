From: pawelo@king.net.pl (Paul Osmialowski)
Date: Mon, 6 Jul 2015 22:57:02 +0200 (CEST)
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <alpine.LNX.2.00.1507042327490.1296@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
 <alpine.DEB.2.11.1507030006280.3916@nanos> <2009463.YLtdMegFel@wuerfel>
 <alpine.LNX.2.00.1507042327490.1296@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1507062248290.9686@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Let me share with you one more approach. I moved clocks back to 
sub-devices, so sharing the same resources (registers) is more obvious 
again. I like it better than previous approach. Can you look at this, 
please?

On Sat, 4 Jul 2015, Paul Osmialowski wrote:

> Hi Arnd,
>
> I'm attaching excerpt from Kinetis reference manual that may make situation 
> clearer.
>
> These MCG and SIM registers are used only to determine configuration (clock 
> fixed rates and clock signal origins) at run time.
>
> Namely, the real MCGOUTCLK source (in the middle) which is the parent for 
> core clock (CCLK) and peripheral clock (PCLK) is determined at run time by 
> reading MCG registers, let me quote commit message from Emcraft git repo:
>
>     * Determine in run-time what oscillator module (OSC0 or OSC1) is used
>     as clock source for the main PLL.
>     * When OSC1 is selected, assume its frequency to be 12 MHz on all
>     boards (there is a 12 MHz oscillator on XTAL1/EXTAL1 on K70-SOM and
>     TWR-K70F120M boards).
>
> In my .dts I'm trying to possibly follow real clock hierarchy, but to go 
> anywhere behind MCGOUTCLK would require ability to rewrite .dtb e.g. by 
> U-boot. But that's too demanding for any potential users of this BSP. So 
> let's asume that MCGOUTCLK is the root clock and a parent for CCLK and PCLK.
>
> In my most recent version I added OSC0ERCLK explicitly as one more root 
> clock, since it is also used directly (through CG reg. 1 bit 0) by Freescale 
> fec network device whose in-tree driver I'm trying to make usable for 
> Kinetis.
>
> On Sat, 4 Jul 2015, Arnd Bergmann wrote:
>
>>  On Friday 03 July 2015 00:08:27 Thomas Gleixner wrote:
>> >  On Thu, 2 Jul 2015, Paul Osmialowski wrote:
>> > >  On Thu, 2 Jul 2015, Arnd Bergmann wrote:
>> > > 
>> > > >  I wonder if you could move out the fixed rate clocks into their own
>> > > >  nodes. Are they actually controlled by the same block? If they are
>> > > >  just fixed, you can use the normal binding for fixed rate clocks
>> > > >  and only describe the clocks that are related to the driver.
>> > > 
>> > >  In my view having these clocks grouped together looks more convincing. 
>> > >  After
>> > >  all, they all share the same I/O regs in order to read configuration.
>> > 
>> >  The fact that they share a register is not making them a group. That's
>> >  just a HW design decision and you need to deal with that by protecting
>> >  the register access, but not by trying to group them artificially at
>> >  the functional level.
>>
>>  I'd disagree with that: The clock controller is the device that owns the
>>  registers and that should be one node in DT, as Paul's first version does.
>>
>>  The part I'm still struggling with is understanding how the fixed-rate
>>  clocks are controlled through those registers. If they are indeed
>>  configured
>>  through the registers, the name is probably wrong and should be changed
>>  to whatever kind of non-fixed clock this is.
>>
>>   Arnd
>> 
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-arm-twr-k70f120m-clock-driver-for-Kinetis-SoC.patch
Type: text/x-diff
Size: 20061 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/1653224d/attachment-0001.bin>
