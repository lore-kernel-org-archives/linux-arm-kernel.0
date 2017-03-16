From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 16 Mar 2017 18:47:33 +0100 (CET)
Subject: Legacy PCI interrupt support in PCIe host driver
In-Reply-To: <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr>
References: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr>
 <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr>
Message-ID: <alpine.DEB.2.20.1703161843420.3586@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Mar 2017, Mason wrote:
> About shared ISRs. Are they supposed to return IRQ_HANDLED
> if and only if they handled something?

Every interrupt handler is supposed to return IRQ_NONE if it did not handle
it. That does not depend on shared or not. The handler does not know if
it's on a shared interrupt line or not. IRQF_SHARED only tells, that the
handler is capable of sharing the interrupt line with another device.

> Will that stop the next ISR from being called?

No.

> I guess if two interrupts fire at the same time, we'll just take two
> separate exceptions?

Wrong guess. That might work with level interupts, but with other types
nothing will raise another exception. Sharing interrupts on edge types is a
stupid idea, but hardware folks insist on implementing stupid ideas.

Thanks,

	tglx
