From: Scott.Lurndal@caviumnetworks.com (Lurndal, Scott)
Date: Mon, 26 Aug 2013 17:29:10 +0000
Subject: [Linaro-acpi] [PATCH 0/3] Interrupt priority patch set
In-Reply-To: <20130826171501.GD6617@n2100.arm.linux.org.uk>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>,
 <20130826171501.GD6617@n2100.arm.linux.org.uk>
Message-ID: <1db399be587d446b955bdc608d2a4260@BY2PR07MB092.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 06:15:01PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 26, 2013 at 05:36:22PM +0200, Tomasz Nowicki wrote:
> > ACPI spec is x86 oriented thus it use NMI for error reporting as low latency
> > error signalling way. Fast response to error occurrence is what ARM trying to
> > satisfy using interrupt prioritization since there is no NMI direct equivalent
On Mon, Aug 26, 2013 at 06:15:01PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 26, 2013 at 05:36:22PM +0200, Tomasz Nowicki wrote:
> > ACPI spec is x86 oriented thus it use NMI for error reporting as low latency
> > error signalling way. Fast response to error occurrence is what ARM trying to
> > satisfy using interrupt prioritization since there is no NMI direct equivalent

  [ elided reasons why interrupt prioritization is a no-go for linux]

>
> So... the general principle here is that IRQ priority levels are pretty
> useless in Linux.
>
> In other words, the error reporting won't work while any interrupt
> handler is running irrespective of how you program the GIC or indeed
> any interrupt disabled region.
>
> The closest we have to NMI is the FIQ, but having the FIQ call kernel
> C code and take locks is very problematic: you end up needing the

  I think FIQ is a non-starter (at least on arm64 systems) as it will
almost certainly be restricted to group0 interrupts used by the EL3
firmware on many implementations.

  The System Error Int/Exception (known on armv7 as ABORT) is a bit closer
to the semantics that NMI provides on x86 (with the exception that the
SEI can be masked by the PSTATE.A flag).  I don't believe that linux currently
uses SEI's for any generic purpose.

  Many of us have been requesting ARM to add a real non-maskable interrupt,
but it is claimed that prioritization is sufficient for most needs (a claim
with which I disagree).

scott
