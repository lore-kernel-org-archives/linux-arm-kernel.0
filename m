From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 May 2016 11:39:19 +0200
Subject: [PATCH v3 19/55] KVM: arm/arm64: vgic-new: Add GICv3 world
 switch backend
In-Reply-To: <CAFEAcA9U9qqsSJt7RfNJmDutCsYwnaPGfi-sEcnxYYjSm5C8sA@mail.gmail.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-20-git-send-email-andre.przywara@arm.com>
 <20160510140454.GG27623@cbox>
 <CAFEAcA9U9qqsSJt7RfNJmDutCsYwnaPGfi-sEcnxYYjSm5C8sA@mail.gmail.com>
Message-ID: <20160511093919.GJ27623@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 03:15:12PM +0100, Peter Maydell wrote:
> On 10 May 2016 at 15:04, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Fri, May 06, 2016 at 11:45:32AM +0100, Andre Przywara wrote:
> >> +     /*
> >> +      * Currently all guest IRQs are Group1, as Group0 would result
> >> +      * in a FIQ in the guest, which it wouldn't expect.
> >
> > I still don't like or understand this comment.  This should simply say
> > that we're making a gross assumption about all interrupts being group1
> > here.
> 
> It's not really an assumption so much as it's a missing feature (aka bug):
> there's no reason the vGIC shouldn't support group 0 interrupts. We
> just get away with only supporting group 1 because Linux guests
> happen to only use group 1 interrupts. If/when the vGIC gains support
> for group0 interrupts, then it should reset with interrupts configured
> in group0 by default.
> 
> >> +      * Eventually we want to make this configurable, so we may
> >> +      * revisit this in the future.
> >> +      */
> 
> The only reason to make it configurable is to work around a guest
> kernel bug whereby Linux assumes that all interrupts start out
> in Group1. Marc sent out a patch earlier today that fixes that bug:
>  https://lkml.org/lkml/2016/5/10/297
> Depending on how long it takes you to fix this missing vgic feature,
> such kernels may all be long-forgotten, in which case you can
> get away without the config option :-)
> 
Agreed with all of the above.  My nit here is simply that if we don't
implement grouping support now, then it's just a gross hack, and we
should just state that until we fix it properly.

-Christoffer
