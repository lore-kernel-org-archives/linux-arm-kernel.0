From: eric@anholt.net (Eric Anholt)
Date: Thu, 02 Jun 2016 11:12:38 -0700
Subject: [PATCH 21/32] mmc: bcm2835-sdhost: Add new driver for the
 internal SD controller.
In-Reply-To: <4715245.LFBOAeJdHc@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-22-git-send-email-kraxel@redhat.com>
 <4715245.LFBOAeJdHc@wuerfel>
Message-ID: <87vb1ra295.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday, June 1, 2016 11:43:30 PM CEST Gerd Hoffmann wrote:
>> +	/* Parse OF address directly to get the physical address for
>> +	 * DMA to our registers.
>> +	 */
>> +	host->phys_addr = be32_to_cpup(of_get_address(pdev->dev.of_node, 0,
>> +						      NULL, NULL));
>
> This looks broken on 64-bit systems when #address-cells=<2>, or if there
> is an intermediate bus with a non-empty ranges property.
>
> What's wrong with platform_get_resource(pdev, IORESOURCE_MEM, 0)?

I'll get to the rest of the review later, but this is a weird pattern
that we have in several bcm2835-related drivers.

We need the address as seen by the DMA controller, not the address from
the ARM's perspective (which is offset by the dma-ranges DT property).
This is the way that people have figured out to get that address.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160602/a60abe4d/attachment.sig>
