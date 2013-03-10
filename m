From: wmb@firmworks.com (Mitch Bradley)
Date: Sun, 10 Mar 2013 08:33:08 -1000
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130310160615.14ba099c@skate>
References: <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <513A7044.1020700@gmail.com> <513C1473.60600@firmworks.com>
 <20130310160615.14ba099c@skate>
Message-ID: <513CD1E4.6050408@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2013 5:06 AM, Thomas Petazzoni wrote:
> Dear Mitch Bradley,
> 
> On Sat, 09 Mar 2013 19:04:51 -1000, Mitch Bradley wrote:
>  
>> As stated in my recent reply to Jason, I thing the correct property is
>> "ranges".  "Ranges" translates mappable child address space addresses
>> into parent addresses, and that is exactly what is going on.  A specific
>> subset of config addresses is mappable into parent MMIO space.
> 
> The PCI configuration space is *not* mapped in the MMIO space on
> Marvell hardware. In the MMIO space of each PCIe interface, there are
> many registers, only *two* of which are dedicated to accessing the PCI
> configuration space:
> 
>  * One register to set the offset in the PCI configuration space.
> 
>  * One register to read or write a value in the PCI configuration, at
>    the offset specified in the first register.
> 
> See the implementation of mvebu_pcie_hw_rd_conf() and
> mvebu_pcie_hw_wr_conf() in the driver.
> 
> So really, the values specified in the reg = <...> property are *not*
> the PCI configuration spaces mapped in the MMIO space. They represent a
> bunch of per PCIe interface registers used to configure them, get the
> status of the link... and access, through an indirect mechanism, the
> PCI configuration space.
> 
> Does this helps?

I agree that PCI config space accesses to *downstream* devices is via an
indirect-access register pair.

The question is, does that indirect-access mechanism apply also to the
internal config headers for the root port bridges?

According to section 20.15 of the MV78230 functional spec that I am
looking at, the configuration header registers are mapped to the
internal memory space.  That section is unclear about whether those
registers are CPU-accessible via indirect-access config transactions.
When the PCIe hardware is configured for endpoint mode, the internal
headers can be accessed via PCIe config transactions from an external
port, but in root complex mode, the possibility of indirect access from
the CPU is not mentioned.

The manual is a little vague in some respects, but it does say quite
clearly that MMIO access to the root port bridge config header is
possible, and it lists the MMIO addresses thereof (section A.10).

So we all agree that access to external (downstream) config registers is
via the indirect register pair.  The unclear thing is whether the
internal config registers for the root port bridges can be indirectly
accessed.

Do we have empirical evidence that indirect-access works to the internal
root port bridge config headers?

> 
> Thanks,
> 
> Thomas
> 
