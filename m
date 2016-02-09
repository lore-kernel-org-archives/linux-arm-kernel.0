From: nm@ti.com (Nishanth Menon)
Date: Tue, 9 Feb 2016 12:10:31 -0600
Subject: [PATCH 1/2] Documentation: dt: mailbox: Add TI Message Manager
In-Reply-To: <CAGo_u6qGaQj9Qvjwrm7cD=cr2UjLN+62tcquXYPsQrRjYD=UCw@mail.gmail.com>
References: <1454690044-2560-1-git-send-email-nm@ti.com>
 <1454690044-2560-2-git-send-email-nm@ti.com>
 <CABb+yY3kGq_R49Xx4fK3UMqtuFiuv-pXJWvjkEFLPL9xRu5T4A@mail.gmail.com>
 <56B9DC30.5040806@ti.com>
 <CABb+yY24XzsWaSGLMCE4_nvgWx0OhhQmcaP41g06FxdjQYFchg@mail.gmail.com>
 <CAGo_u6qGaQj9Qvjwrm7cD=cr2UjLN+62tcquXYPsQrRjYD=UCw@mail.gmail.com>
Message-ID: <20160209181031.GA23603@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:43-20160209, Nishanth Menon wrote:
> On Tue, Feb 9, 2016 at 8:54 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
[..]
> Let me prototype this as part of of_xlate and see if I can pull the
> qinst data back out.. obviously one negative will be that I will
> register *all* valid channels as part of probe.. at least based on
> initial code i wrote today morning..

OK - I believe I have it working now. How does the following look? If
this looks fine to you, then I will post a v2 including the driver
update.
Changes here:
	- dropped the generic message-manager compatible
	- dropped child nodes
	- moved the valid queue information to driver (no longer in dts)
	- rx interrupts per SoC are explicitly named list in binding(and
	  dts)

Texas Instruments' Message Manager Driver
========================================

The Texas Instruments' Message Manager is a mailbox controller that has
configurable queues selectable at SoC(System on Chip) integration. The Message
manager is broken up into queues in different address regions that are called
"proxies" - each instance is unidirectional and is instantiated at SoC
integration level to indicate receive or transmit path.

Message Manager Device Node:
===========================
Required properties:
--------------------
- compatible:		Shall be: "ti,k2g-message-manager"
- reg-names 		queue_proxy_region - Map the queue proxy region.
			queue_state_debug_region - Map the queue state debug
			region.
- reg:			Contains the register map per reg-names.
- #mbox-cells		Shall be 2. Contains the queue ID and proxy ID in that
		        order referring to the transfer path.
- interrupt-names:	Contains interrupt names matching the rx transfer path
			for a given SoC. Receive interrupts shall be of the
			format: "rx_<QID>_<PID>".
			For ti,k2g-message-manager, this shall contain:
				"rx_005_002", "rx_057_002"
- interrupts:		Contains the interrupt information corresponding to
			interrupt-names property.

Example(K2G):
------------

	msgmgr: msgmgr at 02a00000 {
		compatible = "ti,k2g-message-manager";
		#mbox-cells = <2>;
		reg-names = "queue_proxy_region", "queue_state_debug_region";
		reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
		interrupt-names = "rx_005_002",
				  "rx_057_002";
		interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
	};

	pmmc: pmmc {
		[...]
		mbox-names = "rx", "tx";
		# RX queue ID is 5, proxy ID is 2
		# TX queue ID is 0, proxy ID is 0
		mboxes= <&msgmgr 5 2>,
			<&msgmgr 0 0>;
		[...]
	};
-- 
Regards,
Nishanth Menon
