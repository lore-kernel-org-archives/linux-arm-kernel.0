From: Michael.H.Kelley@microsoft.com (Michael Kelley (EOSG))
Date: Fri, 31 Aug 2018 15:42:00 +0000
Subject: [PATCH v2 1/4] arm64: hyperv: Add core Hyper-V include files
In-Reply-To: <MW2PR2101MB1113C65A74A961624C865B8CA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
 <1535556148-10452-2-git-send-email-mikelley@microsoft.com>
 <MW2PR2101MB1113C65A74A961624C865B8CA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
Message-ID: <CY4PR21MB077332AF1772688B50917301DC0F0@CY4PR21MB0773.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KY Srinivasan Sent: Thursday, August 30, 2018 11:23 AM

> > +/*
> > + * This file contains definitions from the Hyper-V Hypervisor Top-Level
> > + * Functional Specification (TLFS):
> > + * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> > +
> A lot of TLFS definitions are ISA independent and we are duplicating these
> definitions both for X86_64 and ARM_64.  Perhaps we should look at splitting
> this file into a common and ISA specific header file.

I agree that we want to end up with x86_64 and ARM64 ISA dependent files
that include an ISA independent file.  My thinking was to not make that
separation now, for a couple of reasons:

1) We don't have a Hyper-V TLFS that is explicit about what should be
considered ISA independent and ISA dependent.  I can make some
reasonable guesses, but it will be subject to change as the Hyper-V team
firms up the interface and decides what they want to commit to.

2) Some of the things defined in the TLFS have names that are
x86-specific (TSC, MSR, etc.).  For the ISA independent parts, those names
should be more generic, which is another dependency on the Hyper-V
team defining the ISA independent parts of the TLFS.

My judgment was that we'll end up with less perturbation overall to go
with this cloned version of hyperv-tlfs.h for now, and then come back
and do the separation once we have a definitive TLFS to base it on.  But
it's a judgment call, and if the sense is that we should do the separation
now, I can give it a try.

> > +#define HvRegisterHypervisorVersion0x00000100 /*CPUID
> > 0x40000002 */
> > +#defineHvRegisterPrivilegesAndFeaturesInfo0x00000200 /*CPUID
> > 0x40000003 */
> > +#defineHvRegisterFeaturesInfo0x00000201
> > /*CPUID 0x40000004 */
> > +#defineHvRegisterImplementationLimitsInfo0x00000202 /*CPUID
> > 0x40000005 */
> > +#define HvARM64RegisterInterfaceVersion0x00090006 /*CPUID
> > 0x40000001 */
> 
> Can we avoid the mixed case names.

Agreed. I'll fix this throughout to use all uppercase, with underscore
as the word separator.

> > + * Linux-specific definitions for managing interactions with Microsoft's
> > + * Hyper-V hypervisor. Definitions that are specified in the Hyper-V
> > + * Top Level Functional Spec (TLFS) should not go in this file, but
> > + * should instead go in hyperv-tlfs.h.
> 
> Would it make sense to breakup this header file into ISA independent and dependent files?

Yes, as above I agree the separation make sense.  And since this file is tied
To Linux and not to the Hyper-V TLFS, the separation isn't affected by the
TLFS issues mentioned above.  I'll give it a try and see if any issues arise.

> > +/*
> > + * Define the IRQ numbers/vectors used by Hyper-V VMbus interrupts
> > + * and by STIMER0 Direct Mode interrupts. Hyper-V should be supplying
> > + * these values through ACPI, but there are no other interrupting
> > + * devices in a Hyper-V VM on ARM64, so it's OK to hard code for now.
> > + * The "CALLBACK_VECTOR" terminology is a left-over from the x86/x64
> > + * world that is used in architecture independent Hyper-V code.
> > + */
> When we have direct device assignment for ARM-64 guests, can we still hardcode.

Yes, we can still hardcode.  These values are in the Per-Processor Interrupt
(PPI) range of 16 to 31.  Any IRQ numbers assigned to a Discrete Device
Assignment (DDA) device will be in the Shared Peripheral Interrupt (SPI)
range of 32-1019 or the Locality-specific Peripheral Interrupt (LPI) range
of greater than 8192.   The handling of DDA interrupts is still under
discussion with the Hyper-V team, but there won't be any conflicts with
the PPI values that are hardcoded here.

> > +/*
> > + * The guest OS needs to register the guest ID with the hypervisor.
> > + * The guest ID is a 64 bit entity and the structure of this ID is
> > + * specified in the Hyper-V specification:
> > + *
> > + * msdn.microsoft.com/en-
> > us/library/windows/hardware/ff542653%28v=vs.85%29.aspx
> > + *
> > + * While the current guideline does not specify how Linux guest ID(s)
> > + * need to be generated, our plan is to publish the guidelines for
> > + * Linux and other guest operating systems that currently are hosted
> > + * on Hyper-V. The implementation here conforms to this yet
> > + * unpublished guidelines.
> > + *
> > + *
> > + * Bit(s)
> > + * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
> > + * 62:56 - Os Type; Linux is 0x100
> > + * 55:48 - Distro specific identification
> > + * 47:16 - Linux kernel version number
> > + * 15:0  - Distro specific identification
> > + *
> > + * Generate the guest ID based on the guideline described above.
> > + */
> 
> No need to repeat the above block comment (already included in the TLFS header).

Agreed.  Will make the change in v3 of the patch.

> > +/* Free the message slot and signal end-of-message if required */
> > +static inline void vmbus_signal_eom(struct hv_message *msg, u32
> > old_msg_type)
> > +{
> > +/*
> > + * On crash we're reading some other CPU's message page and we
> > need
> > + * to be careful: this other CPU may already had cleared the header
> > + * and the host may already had delivered some other message
> > there.
> > + * In case we blindly write msg->header.message_type we're going
> > + * to lose it. We can still lose a message of the same type but
> > + * we count on the fact that there can only be one
> > + * CHANNELMSG_UNLOAD_RESPONSE and we don't care about
> > other messages
> > + * on crash.
> > + */
> > +if (cmpxchg(&msg->header.message_type, old_msg_type,
> > +    HVMSG_NONE) != old_msg_type)
> > +return;
> > +
> > +/*
> > + * Make sure the write to MessageType (ie set to
> > + * HVMSG_NONE) happens before we read the
> > + * MessagePending and EOMing. Otherwise, the EOMing
> > + * will not deliver any more messages since there is
> > + * no empty slot
> > + */
> > +mb();
> > +
> > +if (msg->header.message_flags.msg_pending) {
> > +/*
> > + * This will cause message queue rescan to
> > + * possibly deliver another msg from the
> > + * hypervisor
> > + */
> > +hv_set_vpreg(HvRegisterEom, 0);
> > +}
> > +}
> 
> The code above is identical to what we have on the x86 side except how we
> signal EOM state. If we abstract this, this entire function can be in a common file.

Agreed.  I should be able to do that as part of breaking out
an ISA independent version of this include file.

Michael
