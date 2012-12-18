From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 17 Dec 2012 19:10:59 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
References: <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
Message-ID: <50CFD0B3.6030208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 12:41 PM, Thierry Reding wrote:
> On Mon, Dec 17, 2012 at 11:29:11AM -0700, Jason Gunthorpe wrote:
>> 
>>>> Ie route access for 00:1N.0 to the configuration space on
>>>> bridge port N
>>> 
>>> Is there any particular reason why you choose 0x10 as the base
>>> slot for bridge ports? With the latest DT support patches,
>>> mapping this should be even simpler as we associate a port
>>> index with each port and the port array is gone.
>> 
>> No specific reason, it similar to what intel did and clearly
>> shows the port number in a octet of the device id. It just can't
>> be 0.
> 
> So I tried and implemented something along the lines of what you 
> suggested, and guess what? It does work indeed. For some reason
> even the "imprecise external abort" goes away. Basically what I did
> is fake the configuration space accesses to 0000:0.0 so that they
> return semi-valid data. Nothing special yet, just basically
> returning vendor and product ID, header type, class and other
> static data.
> 
> Initially the implementation was read-only and that still caused
> the external abort, but adding nop'ed write functions apparently
> solved that.
> 
> What I'll do next is add some caching of written values, so that
> reading them back actually yields something correct. After that
> I'll post what I have so that others can look at it or even reuse
> it.

Some internal discussion implies this shouldn't be required; here's
what they said:

-----Original Message----- (from Chung-Hung Lai)

All PCIE root port registers are in configuration space. To access
them, as well as configuration registers of PCIE devices below the
bridge, you will need to program the AXI to FPCI BAR mappings defined
in AFI. After programmed those, the configuration register space of
PCIE fabric are mapped to Tegra's MMIO register space. I take it back
that T30 and [elided] have differences - that was for other units, not
PCIE.

As Mark said, all AFI's own registers are in MMIO space and can be
accessed directly.

Thanks,
Luke

-----Original Message----- (from Mark Van Nostrand)

There are pci bridge registers but also registers to configure the
PCIE wrapper.  AFAIK all Tegra devices (T20/T30/[elided]) have
compliant bridge registers but also need AFI (PCIE wrapper)
configuration updates as well.
