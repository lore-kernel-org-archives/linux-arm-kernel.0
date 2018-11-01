From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 1 Nov 2018 11:09:24 +0200
Subject: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
In-Reply-To: <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
 <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
Message-ID: <2a869e38-47c1-0f11-8f4e-176d0d895a45@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 10/31/18 8:21 PM, Marc Zyngier wrote:
> Well, I'm convinced that we do not want a networking driver to be tied
> to an interrupt architecture, and that the two should be completely
> independent. But that's my own opinion. I can only see two solutions
> moving forward:
> 
> 1) You make the IA a real interrupt controller that exposes real
> interrupts (one per event), and write your networking driver
> independently of the underlying interrupt architecture.
> 
> 2) you make the IA an integral part of your network driver, not exposing
> anything outside of it, and limiting the interactions with the IR
> *through the standard IRQ API*. You duplicate this knowledge throughout
> the other client drivers.
> 
> I believe that (2) would be a massive design mistake as it locks the
> driver to a single of the HW (and potentially a single revision of the
> firmware) while (1) gives you the required level of flexibility by
> hiding the whole event "concept" at a single location.
> 
> Yes, (1) makes you rewrite your existing, out of tree drivers. Oh well...

We need to have generic support for INTA within the NAVSS for Linux. The
UDMA (also part of the NAVSS) is used as system DMA and for the
DMAengine driver we need to have ability to handle the events from Rings
and from the UDMA itself.

Option 2 is not really an option as other components need to configure
INTA to get interrupts from the Events flying within NAVSS.

In the past with Keystone II we did have similar PacketDMA engine but it
was dedicated to service networking and crypto. For all other
peripherals we had EDMA as generic system DMA.

With AM654 this is no longer the case as we no longer have EDMA and the
NAVSS is tasked to service all peripherals, like networking and the ones
we used to use EDMA.

> 
> Thanks,
> 	
> 	M.
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
