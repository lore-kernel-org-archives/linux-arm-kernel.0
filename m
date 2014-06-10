From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 10 Jun 2014 16:03:20 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
Message-ID: <1402412600.20641.25.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-06-10 at 15:42 +0100, Peter Maydell wrote:
> On 28 March 2014 18:45, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > ARM VM System Specification
> > ===========================
> >
> 
> > The virtual hardware platform must provide a number of mandatory
> > peripherals:
> >
> >   Serial console:  The platform should provide a console,
> >   based on an emulated pl011, a virtio-console, or a Xen PV console.
> >
> >   An ARM Generic Interrupt Controller v2 (GICv2) [3] or newer.  GICv2
> >   limits the the number of virtual CPUs to 8 cores, newer GIC versions
> >   removes this limitation.
> >
> >   The ARM virtual timer and counter should be available to the VM as
> >   per the ARM Generic Timers specification in the ARM ARM [1].
> 
> I just noticed that this doesn't mandate that the platform
> provides an RTC. As I understand it, the UEFI spec mandates
> that there's an RTC (could somebody more familiar with UEFI
> than me confirm/deny that?) so we should probably put one here.

Isn't that already done transitively via the requirement to provide a
UEFI environment?

I thought the RTC was exposed via UEFI Runtime Service, in which case
it's mostly a hypervisor internal issue how time is provided to the
(hypervisor provided) UEFI implementation, the guest OS just uses the
runtime services interfaces.

Given that do we also need to standardise on a guest OS visible clock
device too? I'm not sure if we do or not, but if yes then I have a
couple of comments on the suggested wording (you can probably guess what
they are going to be...):

> Suggested wording:
> 
>  RTC: The platform should provide a real time clock, based
>  on an emulated pl031 or mc146818.

We would need to include the Xen PV wallclock here too.

> and in the guest-support section later:
> 
>  The guest OS must include support for pl031 and mc146818 RTC.

and here.

Ian.
