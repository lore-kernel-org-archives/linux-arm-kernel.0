From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Dec 2014 15:47:28 +0100
Subject: [PATCH 3/5] arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
In-Reply-To: <CAFEAcA8ysq5UD4WcfuJqSUV=E8zJR259=8v5S9q1o5aVJpPJQQ@mail.gmail.com>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <1417113660-23610-4-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA8ysq5UD4WcfuJqSUV=E8zJR259=8v5S9q1o5aVJpPJQQ@mail.gmail.com>
Message-ID: <20141202144728.GH545@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 10:53:50PM +0000, Peter Maydell wrote:
> On 27 November 2014 at 18:40, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > It is not clear that this ioctl can be called multiple times for a given
> > vcpu.  Userspace already does this, so clarify the ABI.
> >
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  Documentation/virtual/kvm/api.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index bb82a90..fc12b4f 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -2453,6 +2453,9 @@ return ENOEXEC for that vcpu.
> >  Note that because some registers reflect machine topology, all vcpus
> >  should be created before this ioctl is invoked.
> >
> > +Userspace can call this function multiple times for a given VCPU, which will
> > +reset the VCPU to its initial states.
> 
> How about being a little bit more explicit here with something like:
> 
> "Userspace can call this function multiple times for a given VCPU, including
> after the VCPU has been run. This will reset the VCPU to its initial
> state."

yeah, better.

> 
> (I notice that api.txt is inconsistent about using "vcpu" or "VCPU"
> or "vCPU"... do we have a preference for new text?)
> 

I generally try to match whatever the context is, but I clearly failed
here.  I don't think there's a preference, no.

> > +
> >  Possible features:
> >         - KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
> >           Depends on KVM_CAP_ARM_PSCI.  If not set, the CPU will be powered on
> 
> Do you have to use the same set of feature flags for second and
> subsequent VCPU_INIT calls, or can they be different each time?
> 
That's a good question.  Do you have any opinion on the matter?

It seems weird to change the target of a Vcpu from some core to another
core, but there is not reason why you shouldn't be able to set a vCpU to
be powered off when run, just because it wasn't earlier on, is
there?

Thanks,
-Christoffer
