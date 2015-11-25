From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 25 Nov 2015 12:05:49 -0800
Subject: [RFC PATCH] PCI/pci-host-generic: Add support for Cavium Thunder
 fixed BARs.
In-Reply-To: <2789794.TBZL2yW2b6@wuerfel>
References: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com>
 <20151125170652.GC1380@localhost> <2789794.TBZL2yW2b6@wuerfel>
Message-ID: <5656149D.50704@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 11:52 AM, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 11:06:52 Bjorn Helgaas wrote:
>>
>> On Mon, Sep 28, 2015 at 05:56:24PM -0700, David Daney wrote:
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> Early versions of the Cavium Thunder CN88XX processor are missing
>>> Enhanced Allocation (EA) capabilities for the fixed BAR addresses used
>>> by the on-SoC hardware blocks.
>>>
>>> Add config access functions that synthesize the missing EA
>>> capabilities for versions that are missing that information.  Since
>>> this is a little hacky, gate the inclusion of the code with a new
>>> Kconfig variable.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>
>> What about this one?  Do we still need it?  This version looks like it
>> still has some debug code and it feels like a lot of hard-coding of
>> config offsets; it'd be nice if it could be more table-driven.  But
>> maybe this isn't needed anymore anyway.
>
> I still think it doesn't belong into the generic driver. We have the
> abstraction for drivers based on the compatible string to handle
> nonstandard PCI host bridges, and the generic driver should really
> just handle the generic code.

Somebody should make a decision about this point.

Here is what happens:

  1) A driver for non-generic PCI host bridge is submitted.

  2) Comments are received stating that it is just another PCI host 
bridge and please use pci-host-generic instead.

  3) Patches to pci-host-generic are submitted.

  4) Comments are received stating that pci-host-generic is for generic 
things only, and please create a device specific driver.

  5) goto 1


>
> It's easy enough to split out the common parts if we want to reuse
> some of this, or to move them into drivers/pci/*.c for others to
> reuse too.
>

If we do that, do you want "pci-host-cam-generic" and 
"pci-host-ecam-generic" split out too?

They are two completely different things crammed into the single 
pci-host-generic driver source file.  Or is there some set of config 
access methods that are sufficiently generic that they can stay?

David Daney


> 	Arnd
>
