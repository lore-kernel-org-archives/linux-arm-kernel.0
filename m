From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 17 Feb 2015 16:16:42 +0000
Subject: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
In-Reply-To: <54E36477.3050406@codeaurora.org>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <1421428986-11300-11-git-send-email-andre.przywara@arm.com>
 <54E36477.3050406@codeaurora.org>
Message-ID: <20150217161613.GC3783@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 10:55:35AM -0500, Philip Elcan wrote:
> On 01/16/2015 12:23 PM, Andre Przywara wrote:
> > The ARM Server Base System Architecture[1] document describes a
> > generic UART which is a subset of the PL011 UART.
> > It lacks DMA support, baud rate control and modem status line
> > control, among other things.
> > The idea is to move the UART initialization and setup into the
> > firmware (which does this job today already) and let the kernel just
> > use the UART for sending and receiving characters.
> > We use the recent refactoring the build a new struct uart_ops
> > variable which points to some new functions avoiding access to the
> > missing registers. We reuse as much existing PL011 code as possible.
> >
> > In contrast to the PL011 the SBSA UART does not define any AMBA or
> > PrimeCell relations, so we go a pretty generic probe function
> > which only uses platform device functions.
> > A DT binding is provided, but other systems can easily attach to it,
> > too (hint, hint!).
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
>
> <snip>
>
> Andre,
>
> I'm a little late to address this patchset, but the SBSA defines all
> the Generic UART registers 32-bit wide. However, the amba-pl011 driver
> uses 16-bit accessors. How will you be handling that? Can the ARM PL011
> hardware handle 32-bit access?

Interesting question.  The PL011 TRM [1] specifies only a 16-bit-wide
APB bus interface, but does not say that 32-bit accesses won't work.

I suspect that 32-bit accesses will work on all or most PL011s -- if
that looks too risky or we can't find enough test platforms to be sure
of this, then we could maybe abstract the register access size as a
quirk.

Andre may already have an answer on this.

Cheers
---Dave

[1] ARM DDI 0183G, http://infocenter.arm.com/ -> CoreLink controllers
and peripherals

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
