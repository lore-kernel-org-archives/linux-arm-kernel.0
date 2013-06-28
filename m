From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Jun 2013 10:06:35 +0100
Subject: [PATCH 7/9] documentation: iommu: add description of ARM System
 MMU binding
In-Reply-To: <CALRxmdD5fyp06xW+z=rWagJc_bcJmpr1H9Zbdf=xbg9cCzvVfw@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-8-git-send-email-will.deacon@arm.com>
 <CALRxmdBxFWoRKv+bUu8VEwNNcAJUej9jM2V8N0rrqrr_Vpe8fQ@mail.gmail.com>
 <20130626133941.GD7417@mudshark.cambridge.arm.com>
 <CALRxmdCycFK2wW=C4aU79mudSaT+2vU8nzXxepdstubg+YSdQg@mail.gmail.com>
 <20130626174231.GH10333@mudshark.cambridge.arm.com>
 <CALRxmdD5fyp06xW+z=rWagJc_bcJmpr1H9Zbdf=xbg9cCzvVfw@mail.gmail.com>
Message-ID: <20130628090635.GB29002@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 07:22:30PM +0100, Stuart Yoder wrote:
> On Wed, Jun 26, 2013 at 12:42 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jun 26, 2013 at 05:19:48PM +0100, Stuart Yoder wrote:
> >> On Wed, Jun 26, 2013 at 8:39 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> > I'd suggest looking at the driver I posted to get a gist of how the parsing
> >> > code works, but suffice to say that we describe both the number of
> >> > interrupts and the actual interrupt numbers here.
> >>
> >> I understand that the number of interrupts and actual interrupt numbers
> >> are described here, but was referring to the _meaning_ of the interrupt
> >> numbers.   A binding for a device with 2 interrupts, a TX and RX would
> >> normally identify which interrupt specifier is for TX and which is for RX.
> >>
> >> Based on your code, the 2 global interrupts seem to be the secure
> >> and non-secure fault interrupts...which your driver does not differentiate.
> >> However, the device tree is describing hardware and  you can't assume
> >> that all drivers don't care which is which.
> >
> > Currently, the driver only works when Linux is running as non-secure, which is
> > becoming more and more common since it is required to be able to make use of
> > hyp mode.
> >
> > There are actually two global interrupts for SMMUv1 and SMMUv2, which
> > correspond to configuration faults and `other' global faults.
> 
> So, why don't we define which interrupt is which in this binding?
> ...e.g. "The first
> interrupt specifier is for the configuration access fault interrupt, the second
> interrupt specifier is for other global faults."

Well, first of all, they're both global interrupts and the handler will have
to go and access exactly the same registers to deal with the fault, so you
don't really gain anything.

However, the main reason is that you need to be able to handle:

  (1) Only one of the interrupts is routed to the interrupt controller
  (2) The interrupts are ORd into a single line

> How else is software supposed to know which interrupt corresponds to what
> event.

It really doesn't care. It can't, otherwise we break in the above
situations.

Will
