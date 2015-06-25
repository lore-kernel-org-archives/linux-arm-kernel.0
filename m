From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Jun 2015 14:30:34 +0200
Subject: [PATCH] arm64/kvm: Add generic v8 KVM target
In-Reply-To: <558A7936.7020109@arm.com>
References: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
 <CAFEAcA92uymQ3LjPQnuFiwvjSgc+jY54VrfK_Sh4v1DJ+=OPpw@mail.gmail.com>
 <558A6A84.5020603@arm.com> <20150624085128.GA22785@cbox>
 <558A7936.7020109@arm.com>
Message-ID: <20150625123034.GE28244@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 10:32:38AM +0100, Marc Zyngier wrote:
> Hi Christoffer,
> 
> On 24/06/15 09:51, Christoffer Dall wrote:
> > On Wed, Jun 24, 2015 at 09:29:56AM +0100, Marc Zyngier wrote:
> >> On 22/06/15 09:44, Peter Maydell wrote:
> >>> On 17 June 2015 at 10:00, Suzuki K. Poulose <suzuki.poulose@arm.com> wrote:
> >>>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> >>>>
> >>>> This patch adds a generic ARM v8 KVM target cpu type for use
> >>>> by the new CPUs which eventualy ends up using the common sys_reg
> >>>> table. For backward compatibility the existing targets have been
> >>>> preserved. Any new target CPU that can be covered by generic v8
> >>>> sys_reg tables should make use of the new generic target.
> >>>
> >>> How do you intend this to work for cross-host migration?
> >>
> >> It is not meant to work for cross migration at all.
> >>
> >>> Is the idea that the kernel guarantees that "generic" looks
> >>> 100% the same to the guest regardless of host hardware? I'm
> >>> not sure that can be made to work, given impdef differences
> >>> in ID register values, bp/wp registers, and so on.
> >>>
> >>> Given that, it seems to me that we still need to provide
> >>> KVM_ARM_TARGET_$THISCPU defines so userspace can request
> >>> a specific guest CPU flavour; so what does this patch
> >>> provide that isn't already provided by just having userspace
> >>> query for the "preferred" CPU type as it does already?
> >>
> >> The way I see this working is that a "generic" CPU cannot be migrated
> >> (because we don't know anything about it). If it can be identified as a
> >> known (non generic) implementation, then we can migrate it.
> >>
> > Concretely, how should this work?  Be enforced by userspace or should we
> > deny certain SET_ONE_REG operations from working on this target?
> 
> I can definitely see MIDR overriding failing on a generic CPU. Also, you
> shouldn't be able to select a generic CPU if we know about the physical CPU.
> 

If I am migrating from an A57 to an A53, but the VM was started as
"generic CPU" then we rely on the user discovering that this is not
supported when trying to set the MIDR from userspace in KVM?

> > 
> > Also, can we imagine any scenario where the generic CPU cannot me
> > modeled for a VM on a specific piece of hardware (current or future)?
> 
> What is the definition of a generic CPU here? In the above, generic
> really means "Unknown", so I can't immediately see what it would mean to
> model this.
> 
ok, good way to phrase it, I suppose that's a non-issue then.

Thanks,
-Christoffer
