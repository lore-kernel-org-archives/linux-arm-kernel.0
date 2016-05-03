From: alex.williamson@redhat.com (Alex Williamson)
Date: Tue, 3 May 2016 14:02:49 -0600
Subject: VFIO MSIX Query
In-Reply-To: <CAB995Mu0==PJ0iU4h_3oAMGo-VYDFrjOg_BO757M=PDWgMWtCw@mail.gmail.com>
References: <CAB995Mu0==PJ0iU4h_3oAMGo-VYDFrjOg_BO757M=PDWgMWtCw@mail.gmail.com>
Message-ID: <20160503140249.4edaf3cc@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 3 May 2016 23:56:38 +0530
Nitin Saxena <nitin.lnx@gmail.com> wrote:

> Hi,
> 
> I am a newbie to VFIO framework and trying to use it for MSIX interrupt
> handling in my userspace application. My userspace application is like
> intel's dpdk.
> 
> My query is why vfio kernel code does not support msix masking/ unmasking
> i.e VFIO_SET_ACTION_TRIGGER is not implemented in kernel vfio code for MSIX
> but its present for legacy INTX?

I think you mean VFIO_IRQ_SET_ACTION_MASK and
VFIO_IRQ_SET_ACTION_UNMASK are not implemented for MSI/X,
VFIO_IRQ_SET_ACTION_TRIGGER is the only one that is implemented.  It
mostly comes down to it hasn't been needed.  We would just need to
verify that disable_irq() and enable_irq() do the right thing and
enable the features through the existing VFIO API.  The reason we have
these for INTx is that INTx is level triggered and we must mask the
interrupt on the host while it's serviced by the user because the
interrupt will continue to assert and we have no service guarantees
from the user.  MSI/X is of course edge triggered, so doesn't have this
problem.  The device would need to continue to re-assert the
interrupt.  In cases like a QEMU user, we might want to continue to
receive guest masked interrupts to QEMU for emulating the pending bits
array, so even if we had VFIO masking support for these interrupts, QEMU
probably would not use it.  If MSI/X masking is useful for you vs simply
ignoring the eventfd, patches welcome.

> Another question since MSIX interrupt masking is absent in kernel who is
> supposed to mask/unmask msix interrupt? does userspace needs to mask/unmask
> interrupt after getting notified by eventfd. Is there any usecase where
> MSIX handling is done via VFIO framework?

MSI/X is edge triggered and VFIO does not set the AUTOMASKED flag on
them, so there is simply no masking of them at all aside from fully
disabling them.  QEMU has full support for MSI/X through VFIO that you
can use for reference.  Thanks,

Alex
