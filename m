From: slash.tmp@free.fr (Mason)
Date: Wed, 29 Mar 2017 17:50:52 +0200
Subject: [PATCH v3 1/2] PCI: Add tango MSI controller support
In-Reply-To: <0541e62a-c87a-2e69-a7d1-28f886ad04c2@free.fr>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <f37d7b55-e065-72aa-e690-13dd4718a9ce@sigmadesigns.com>
 <a12a79fd-94f9-5aa4-5aa0-5dccb6c5d615@arm.com>
 <0541e62a-c87a-2e69-a7d1-28f886ad04c2@free.fr>
Message-ID: <e8076081-545c-4c20-2d80-b66e9d3c8d9a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/2017 15:16, Mason wrote:

> But I don't understand how to get my pcie pointer back in irq_ack
> or irq_unmask, or the relevant msi. Can you throw me a clue?

Let's see... the irq_chip call-backs receive an irq_data pointer.

struct irq_data - per irq chip data passed down to chip functions
struct irq_chip - hardware interrupt chip descriptor

irq_data contains a void *chip_data member.
Can I use chip_data to stash a struct tango_pcie pointer?

/**
 *	irq_set_chip_data - set irq chip data for an irq
 *	@irq:	Interrupt number
 *	@data:	Pointer to chip specific data
 *
 *	Set the hardware irq chip data for an irq
 */
int irq_set_chip_data(unsigned int irq, void *data)

But where would I call it? And for which irq?


Otherwise, I found by trial-and-error that I can reach pcie through

data->domain->parent->host_data

data->domain == msi_dom
msi_dom->parent == irq_dom
irq_dom->host_data == pcie

But data->irq and data->hwirq don't hold the MSI index :-(

I suppose I have to ask for some mapping?

Regards.
