From: scottwood@freescale.com (Scott Wood)
Date: Wed, 28 Sep 2011 16:32:47 -0500
Subject: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
In-Reply-To: <4E838A41.8010408@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-3-git-send-email-b-cousson@ti.com>
	<4E8161C7.7020404@ti.com> <4E82D7B3.6080909@ti.com>
	<4E836612.2010709@freescale.com> <4E838A41.8010408@ti.com>
Message-ID: <4E83927F.1060309@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2011 03:57 PM, Cousson, Benoit wrote:
> On 9/28/2011 8:23 PM, Scott Wood wrote:
>> What does "the id" mean, in relation to the actual hardware?
> 
> It's true that the description is not super meaningful...
> This is the HW instance number. We have 6 gpios, named gpio1 to gpio6,
> but the pin numbering is global, meaning from 1 to 192, sine only the
> global number is referenced in the pinmuxing control, we have to
> maintain the order to ensure the right number.

I'd either have one node that handles all the banks (with multiple "reg"
resources in the order that they should be mapped to the numberspace),
or avoid using that global numberspace and reference things by
bank/offset (with the bank identified by alias or phandle).

> I still do not know how to use that with the way gpio binding is
> working. Because in theory each gpio controller should be referenced
> with the local number, not the global one. And converting that global
> number from HW spec to a gpio instance + local number seems to me very
> error prone.

You could say the same thing about a chip whose manual is written
assuming a global IRQ numberspace with a certain encoding scheme.

Or in the other direction, Freescale's manuals split up MPIC interrupts
into external/internal/MSI, while they really just map to different
regions of the openpic (hardware standard that Freescale's MPIC is an
instance of) interrupt space.  The device trees use the raw openpic
interrupt numbers.

There's certainly potential for confusion, but at least the device tree
representation is internally consistent and doesn't make assumptions
about the overall system.

-Scott
