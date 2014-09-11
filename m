From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Thu, 11 Sep 2014 19:08:07 +0200
Subject: [RFC v2 4/9] VFIO: platform: handler tests whether the IRQ is
 forwarded
In-Reply-To: <541160D2.80400@linaro.org>
References: <1409575968-5329-1-git-send-email-eric.auger@linaro.org>
 <1409575968-5329-5-git-send-email-eric.auger@linaro.org>
 <20140911031000.GE2784@lvm> <541160D2.80400@linaro.org>
Message-ID: <CAG8rG2zjT4yHz_71rYHhX+75jrBSdQGD2PTZrFrGQHpWFx-wNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:44 AM, Eric Auger <eric.auger@linaro.org> wrote:
>
> On 09/11/2014 05:10 AM, Christoffer Dall wrote:
> > On Mon, Sep 01, 2014 at 02:52:43PM +0200, Eric Auger wrote:
> >> In case the IRQ is forwarded, the VFIO platform IRQ handler does not
> >> need to disable the IRQ anymore. In that mode, when the handler completes
> >
> > add a comma after completes
> Hi Christoffer,
> ok
> >
> >> the IRQ is not deactivated but only its priority is lowered.
> >>
> >> Some other actor (typically a guest) is supposed to deactivate the IRQ,
> >> allowing at that time a new physical IRQ to hit.
> >>
> >> In virtualization use case, the physical IRQ is automatically completed
> >> by the interrupt controller when the guest completes the corresponding
> >> virtual IRQ.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> >> ---
> >>  drivers/vfio/platform/vfio_platform_irq.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> >> index 6768508..1f851b2 100644
> >> --- a/drivers/vfio/platform/vfio_platform_irq.c
> >> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> >> @@ -88,13 +88,18 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
> >>      struct vfio_platform_irq *irq_ctx = dev_id;
> >>      unsigned long flags;
> >>      int ret = IRQ_NONE;
> >> +    struct irq_data *d;
> >> +    bool is_forwarded;
> >>
> >>      spin_lock_irqsave(&irq_ctx->lock, flags);
> >>
> >>      if (!irq_ctx->masked) {
> >>              ret = IRQ_HANDLED;
> >> +            d = irq_get_irq_data(irq_ctx->hwirq);
> >> +            is_forwarded = irqd_irq_forwarded(d);
> >>
> >> -            if (irq_ctx->flags & VFIO_IRQ_INFO_AUTOMASKED) {
> >> +            if (irq_ctx->flags & VFIO_IRQ_INFO_AUTOMASKED &&
> >> +                                            !is_forwarded) {
> >>                      disable_irq_nosync(irq_ctx->hwirq);
> >>                      irq_ctx->masked = true;
> >>              }
> >> --
> >> 1.9.1
> >>
> > It makes sense that these needs to be all controlled in the kernel, but
> > I'm wondering if it would be cleaner / more correct to clear the
> > AUTOMASKED flag when the IRQ is forwarded and have vfio refuse setting
> > this flag as long as the irq is forwarded?
>
> If I am not wrong, even if the user sets AUTOMASKED, this info never is
> exploited by the vfio platform driver. AUTOMASKED only is set internally
> to the driver, on init, for level sensitive IRQs.
>
> It seems to be the same on PCI (for INTx). I do not see anywhere the
> user flag curectly copied into a local storage. But I prefer to be
> careful ;-)
>
> If confirmed, although the flag value is exposed in the user API, the
> user set value never is exploited so this removes the need to check.
>

Yeah, the way the API is right now the AUTOMASKED flag is only to be
communicated by the kernel to the user, never the other way around.

IMHO there shouldn't be a need to change that. The flag is there just
to inform the user for the kernel behavior for non-forwarded IRQs (and
it's still true if the user unforwards the IRQ later). The user
decides the mode of operation, but it might still be a bit of
information he wants to know.

> the forwarded IRQ modality being fully dynamic currently, then I would
> need to update the irq_ctx->flags on each vfio_irq_handler call. I don't
> know if its better?
>
> Best Regards
>
> Eric
>
>
> >
> > -Christoffer
> >
>



-- 
Antonios Motakis
Virtual Open Systems
