From: wmb@firmworks.com (Mitch Bradley)
Date: Fri, 08 Mar 2013 09:43:11 -1000
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
References: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
Message-ID: <513A3F4F.2090501@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/8/2013 9:12 AM, Thierry Reding wrote:
> On Fri, Mar 08, 2013 at 09:52:28AM -0700, Jason Gunthorpe wrote:
>> On Fri, Mar 08, 2013 at 08:14:44AM +0100, Thierry Reding wrote:
>>> On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
>>>> On 03/07/2013 02:47 PM, Thierry Reding wrote:
>>> [...]
>>>>> In a nutshell (since some of the context isn't quoted anymore) the
>>>>> problem that we're trying to solve is that some of the embedded SoCs
>>>>> require per-root-port registers for configuration. The PCI DT
>>>>> specification doesn't make any provisions for this. A few alternatives
>>>>> have been discussed so far:
>>>>
>>>> I'm not sure I follow. This is different than the host controller
>>>> registers? Why would this not just be multiple entries in the reg property?
>>>
>>> Well the register regions are per root-port. On Tegra20 there's 2 of
>>> them, Tegra30 has 3 and if I understand correctly Marvell can have up to
>>> 10 (!). Adding all of them to the reg property of the host controller
>>> could work but it needs some way to match the reg entry to the root port
>>> similar to option 1 below.
>>
>> Thomas just posted an implementation like this, please see:
>>
>> http://www.spinics.net/lists/arm-kernel/msg228749.html

The example in that posting looks messed up to me.

1) It has "reg = <0x0800 0 0 0 0>", but 0x0800 0 0  is not a valid
address in the address space defined by its parent - because the form of
the parent's ranges property indicates that it's a PCI-style address
form.  0x0800 0 0 lacks the top bits that indicate non-relocatable and
the type (I/O, memory, etc).

2) The "@0,0" and "@1,0" suffixes do not correspond to the reg values
<0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.

What is address space represented by the pcie-controller node?  reg
properties in child nodes must contain proper addresses in some
well-defined address space.  It looks like this example is trying to put
half of the PCI bus abstraction in the pcie-controller node and the rest
in the pcie sub-nodes, with some handwaving address-space splicing
between the two.  That's not kosher.  Each level of the tree needs a
coherent address space definition, otherwise the address space
"calculus" breaks.

> 
> Oh well. I don't like it, but if that's the way it has to be, then so be
> it. Any reason why the reg-names can't match the root port's node name
> so that it can be used directly instead of going through hoops to
> construct a string from extra parameters? Like below:
> 
> 	pcie-controller {
> 		regs = <...>;
> 		reg-names = ..., "pcie at 1,0", "pcie at 2,0";
> 
> 		pcie at 1,0 {
> 			...
> 		};
> 
> 		pcie at 2,0 {
> 			...
> 		};
> 	};
> 
> Thierry
> 
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
