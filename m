From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 14 Jan 2015 09:22:35 +0100
Subject: [PATCH v2 1/5] irqchip: add dumb demultiplexer implementation
In-Reply-To: <CAL_JsqJ5DSo6jmAuHPDdV6pMca8BVbg5V-GZ5=2qu96_QYXMtQ@mail.gmail.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAL_JsqJ5DSo6jmAuHPDdV6pMca8BVbg5V-GZ5=2qu96_QYXMtQ@mail.gmail.com>
Message-ID: <20150114092235.032dc986@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, 13 Jan 2015 21:26:42 -0600
Rob Herring <robherring2@gmail.com> wrote:

> On Tue, Jan 13, 2015 at 12:46 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > Some interrupt controllers are multiplexing several peripheral IRQs on
> > a single interrupt line.
> > While this is not a problem for most IRQs (as long as all peripherals
> > request the interrupt with IRQF_SHARED flag set), multiplexing timers and
> > other type of peripherals will generate a WARNING (mixing IRQF_NO_SUSPEND
> > and !IRQF_NO_SUSPEND is prohibited).
> >
> > Create a dumb irq demultiplexer which simply forwards interrupts to all
> > peripherals (exactly what's happening with IRQ_SHARED) but keep a unique
> > irq number for each peripheral, thus preventing the IRQF_NO_SUSPEND
> > and !IRQF_NO_SUSPEND mix on a given interrupt.
> 
> This really seems like a work-around for how IRQF_SHARED works. It
> seems like what is really desired is just per handler disabling.

Like what I proposed here [1] ?

> It is
> fragile in that devices can deadlock the system if the drivers don't
> disable the interrupt source before calling disable_irq.

Not exactly deadlock since spurious interrupt detection is implemented,
but yes, things won't work as expected.

> But unlike
> IRQF_SHARED, there is nothing explicit in the driver indicating it is
> designed to work properly with a shared interrupt line.
> 
> I see no reason to accept this into DT either. We already can support
> shared lines and modeling an OR gate as an interrupt controller is
> pointless.

Okay, I guess I'll let DT and irq maintainers decide what is preferable
here (I already spent much time than I first expected to remove this
warning in a proper way).

Best Regards,

Boris

[1]https://lkml.org/lkml/2014/12/15/552

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
