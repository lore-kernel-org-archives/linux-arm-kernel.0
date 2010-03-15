From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Mar 2010 11:11:00 +0000
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <4B9DB99A.5040104@st.com>
References: <4B9DB99A.5040104@st.com>
Message-ID: <20100315111100.GC700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 10:07:46AM +0530, Viresh KUMAR wrote:
> In our SOC (SPEArxxx), we have few peripherals which share common interrupt
> line. For example we can have GPIO (PL061), SPI (PL022) and SDIO (Arasan) sharing
> same physical IRQ line. Now there is a register in SOC which can give status of
> this interrupt line (i.e. source of interrupt). We have standard drivers for
> all of these, and these drivers don't request IRQ in shared mode.

Ultimately, we have all ARM peripherals sharing one interrupt line -
because the CPU only has one IRQ-level interrupt signal.  That doesn't
mean that we hang all interrupt handlers off the same IRQ number though.

> How should we handle these IRQs now. One way i have been thinking of is to write
> a wrapper layer for this type of IRQs for our SOC, which will register actual
> IRQ numbers. Standard drivers can be provided virtual IRQ numbers for
> registration. Now this wrapper, based on source of interrupt can call the
> irq_handler for standard drivers.

We do have a system for having a multi-level approach to interrupt decoding.
Since you have a register which allows you to identify the source of the
interrupt, I'd recommend for maximum system performance that you use it.

Shared interrupts have the disadvantage that you need to run each handler
every time a device on the shared interrupt signals, which can be very
wasteful both in terms of instruction cache lines and IO accesses.

Search arch/arm/ for set_irq_chained_handler to find examples of who to
deal with multi-level handling of IRQs.
