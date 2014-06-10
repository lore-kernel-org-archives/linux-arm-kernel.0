From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 10 Jun 2014 15:42:04 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <20140328184517.GA27219@cbox>
References: <20140328184517.GA27219@cbox>
Message-ID: <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2014 18:45, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> ARM VM System Specification
> ===========================
>

> The virtual hardware platform must provide a number of mandatory
> peripherals:
>
>   Serial console:  The platform should provide a console,
>   based on an emulated pl011, a virtio-console, or a Xen PV console.
>
>   An ARM Generic Interrupt Controller v2 (GICv2) [3] or newer.  GICv2
>   limits the the number of virtual CPUs to 8 cores, newer GIC versions
>   removes this limitation.
>
>   The ARM virtual timer and counter should be available to the VM as
>   per the ARM Generic Timers specification in the ARM ARM [1].

I just noticed that this doesn't mandate that the platform
provides an RTC. As I understand it, the UEFI spec mandates
that there's an RTC (could somebody more familiar with UEFI
than me confirm/deny that?) so we should probably put one here.

Suggested wording:

 RTC: The platform should provide a real time clock, based
 on an emulated pl031 or mc146818.

and in the guest-support section later:

 The guest OS must include support for pl031 and mc146818 RTC.

(QEMU is going to provide a PL031, because that's the standard
ARM primecell device for this and it's what's in the vexpress.
kvmtool looks like it's going to provide mc146818, because
that's the standard x86 RTC and kvmtool happens to already
emulate that.)

thanks
-- PMM
