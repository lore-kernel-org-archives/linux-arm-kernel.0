From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Feb 2013 13:30:35 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130201193935.GA19335@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <510B0D9C.1000101@wwwdotorg.org>
 <20130201014138.GA16234@obsidianresearch.com>
 <510B268E.2040104@wwwdotorg.org> <20130201094613.38fa2ad0@skate>
 <510C0200.5040505@wwwdotorg.org>
 <20130201193935.GA19335@obsidianresearch.com>
Message-ID: <510C25EB.9020804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2013 12:39 PM, Jason Gunthorpe wrote:
> On Fri, Feb 01, 2013 at 10:57:20AM -0700, Stephen Warren wrote:
...
>> I think the only difference on the Marvell HW is:
>>
>> * The overall total size of the physical address space is dynamic rather
>> than fixed, because it's programmed through windows rather than
>> hard-coded into HW.
> 
> Is it hard coded on tegra? I thought there was a register set that was
> used to set the overall PCI-E MMIO window location and size. I know
> even on x86 the PCI window is set via register, though that typically
> isn't disclosed except to bios writers.. 

There is a fixed (in HW) 1 GiB physical address window dedicated to
PCIe. That window is divided between host controller registers, PCIe
root port registers (since our root ports don't respond to configuration
transactions), and regular PCIe accesses; config/MMIO/IO. There are
registers in the host controller that configure the division of this
space into config/MMIO/IO, so that can be dynamic. The DT bindings for
the driver Thierry proposed hard-code those divisions in DT.
