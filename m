From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 24 Jan 2015 00:38:02 +0200
Subject: [RFC PATCH 2/5] ARM: on IO mem abort - route the call to KVM MMIO
 bus
In-Reply-To: <54B3F488.5000207@linaro.org>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212651.10605.58116.stgit@i3820>
 <20141129112858.GB13623@macair>
 <CADDJ2=OB-HjB5xjZbuDNXuTTXwjJ2aG9WE4wEmP7ep+eF0VGyA@mail.gmail.com>
 <54B3F488.5000207@linaro.org>
Message-ID: <CADDJ2=MetB1TNpdqPDuBiybXLjMgOgG0ahV2jbaWM2Wu9EpH4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 6:21 PM, Eric Auger <eric.auger@linaro.org> wrote:
>
> On 12/05/2014 01:06 PM, Nikolay Nikolaev wrote:
> > On Sat, Nov 29, 2014 at 1:28 PM, Christoffer Dall
> > <christoffer.dall@linaro.org> wrote:
> >> On Mon, Nov 24, 2014 at 11:26:51PM +0200, Nikolay Nikolaev wrote:
> >>> On IO memory abort, try to handle the MMIO access thorugh the KVM
> >>> registered read/write callbacks. This is done by invoking the relevant
> >>> kvm_io_bus_* API.
> >>>
> >>> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> >>> ---
> >>>  arch/arm/kvm/mmio.c |   33 +++++++++++++++++++++++++++++++++
> >>>  1 file changed, 33 insertions(+)
> >>>
> >>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> >>> index 4cb5a93..81230da 100644
> >>> --- a/arch/arm/kvm/mmio.c
> >>> +++ b/arch/arm/kvm/mmio.c
> >>> @@ -162,6 +162,36 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>>       return 0;
> >>>  }
> >>>
> >>> +/**
> >>> + * kvm_handle_mmio - handle an in-kernel MMIO access
> >>> + * @vcpu:    pointer to the vcpu performing the access
> >>> + * @run:     pointer to the kvm_run structure
> >>> + * @mmio:    pointer to the data describing the access
> >>> + *
> >>> + * returns true if the MMIO access has been performed in kernel space,
> >>> + * and false if it needs to be emulated in user space.
> >>> + */
> >>> +static bool handle_kernel_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>> +             struct kvm_exit_mmio *mmio)
> >>> +{
> >>> +     int ret;
> >>> +
> >>> +     if (mmio->is_write) {
> >>> +             ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
> >>> +                             mmio->len, &mmio->data);
> >>> +
> >>> +     } else {
> >>> +             ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
> >>> +                             mmio->len, &mmio->data);
> >>> +     }
> >>> +     if (!ret) {
> >>> +             kvm_prepare_mmio(run, mmio);
> >>> +             kvm_handle_mmio_return(vcpu, run);
> >>> +     }
> >>> +
> >>> +     return !ret;
> >>> +}
> >>> +
> >>>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>>                phys_addr_t fault_ipa)
> >>>  {
> >>> @@ -200,6 +230,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>>       if (vgic_handle_mmio(vcpu, run, &mmio))
> >>>               return 1;
> >>>
> >>> +     if (handle_kernel_mmio(vcpu, run, &mmio))
> >>> +             return 1;
> >>> +
> >>
> >> Is this stuff always synchronously handled so that the mmio is properly
> >> populated upon handle_kernel_mmio on reads?
> >
> > If I get it right the kvm_io_bus_ API is intended to work
> > synchronously. Of course it probably depends
> > on how the registered device handles the read/write call.
> > Or maybe I misunderstand your question? Please clarify in that case.
>
> in case of ioeventfd implementation it is not the case since the write
> is deferred in the kernel thread which handles the eventfd.

Christofer was asking about reads. I guess about writes it does not
make any diiference as long as the needed values are copied into the
new thread.

regards,
Nikolay Nikolaev

>
> Best Regards
>
> Eric
> >
> > regards,
> > Nikolay Nikolaev
> >
> >>
> >> -Christoffer
>
