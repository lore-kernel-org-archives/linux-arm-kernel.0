From: robherring2@gmail.com (Rob Herring)
Date: Fri, 08 Mar 2013 17:12:04 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
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
Message-ID: <513A7044.1020700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 01:14 AM, Thierry Reding wrote:
> On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
>> On 03/07/2013 02:47 PM, Thierry Reding wrote:
> [...]
>>> In a nutshell (since some of the context isn't quoted anymore) the
>>> problem that we're trying to solve is that some of the embedded SoCs
>>> require per-root-port registers for configuration. The PCI DT
>>> specification doesn't make any provisions for this. A few alternatives
>>> have been discussed so far:
>>
>> I'm not sure I follow. This is different than the host controller
>> registers? Why would this not just be multiple entries in the reg property?
> 
> Well the register regions are per root-port. On Tegra20 there's 2 of
> them, Tegra30 has 3 and if I understand correctly Marvell can have up to
> 10 (!). Adding all of them to the reg property of the host controller
> could work but it needs some way to match the reg entry to the root port
> similar to option 1 below.

The compatible property of the PCI host controller can imply what each
index of the reg property entries is for.

> 
> Adding a property in the root port nodes seems like a cleaner and more
> accurate representation of the hardware to me, but if that's not
> acceptable perhaps we need to bite the bullet and add the code to look
> the registers up from the parent's reg property.

What I don't like is a new property defined to describe mmio addresses.
We already have a property for that and it is "reg". But I think I'm
still missing something:

>>> 			pci at 0,1 {
>>> 				...
>>> 				reg = <0x00000800 0 0 0 0>;

Is this a PCI bus address?

>>> 				regs = <0x80000000 0x00001000>;
>>> 			};

Rob
