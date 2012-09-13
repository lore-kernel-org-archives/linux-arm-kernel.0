From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 13 Sep 2012 11:29:38 +0100
Subject: [PATCH v3 06/25] docs: Xen ARM DT bindings
In-Reply-To: <50514634.3080303@gmail.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
 <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <503BFCD8.5090804@gmail.com>
 <alpine.DEB.2.02.1208281823270.15568@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
 <50514634.3080303@gmail.com>
Message-ID: <20120913102938.GB2470@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 09:34:28PM -0500, Rob Herring wrote:
> On 09/12/2012 01:14 PM, Stefano Stabellini wrote:
> > On Wed, 12 Sep 2012, Stefano Stabellini wrote:
> >> On Tue, 28 Aug 2012, Rob Herring wrote:
> >>> You should look at ePAPR 1.1 which defines hypervisor related bindings.
> >>> While it is a PPC doc, we should reuse or extend what makes sense.
> >>>
> >>> See section 7.5:
> >>>
> >>> https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf
> >>
> >> Thanks for the link, I wasn't aware of ePAPR.
> >>
> >> The hypervisor node defined by ePAPR is not very different from what I
> >> am proposing. Should I try to be compatible with the hypervisor
> >> specification above (as in compatible = "epapr,hypervisor-1.1")?
> >> Or should I just use it as a reference for my own specification?
> >>
> >> Personally I would rather avoid full compatibility with ePAPR.
> > 
> > In particular reading section 7.5, these are the required properties of
> > the ePAPR hypervisor node:
> > 
> > - compatible = "epapr,hypervisor-1.1"
> > compared to what I am proposing, it is laking information about what
> > hypervisor we are talking about (xen, kvm, vmware, etc) and the version
> > of the ABI (xen-4.2).
> 
> compatible properties are often changed. If we do deviate on the rest of
> the binding, then it needs to be different.
> 
> Turns out that powerpc KVM guests use "linux,kvm" and "epapr,hypervisor"
> doesn't even appear in the kernel.
> 
> We also perhaps have to consider the possibility of Xen on PowerPC. Then
> alignment is more important.
> 
> > - hcall-instructions
> > potentially interesting, but given that for Xen we are quite happy with
> > HVC, we are not going to add any secondary hypercall mechanisms,
> > therefore at the moment it would just result in a BUG if the specified
> > hcall instruction is != HVC. Besides if somebody else wanted to
> > implemented the Xen hypercall interface in a different way they could
> > just reimplement the hypercall wrappers, that would be easier than
> > trying to do it with this property.
> 
> It's really about the parameters passed with the HVC. The ePAPR may be a
> good model for defining this. Just grepping "hypervisor" under
> arch/powerpc, it's pretty clear hypervisor support happened first and
> the ePAPR came second. Hopefully we can avoid that for ARM.

Do you think it's feasible to standardise on some interoperable ABI for
kvm and Xen?  This sounds pretty optimistic, but I'm not aware of all
the technicalities, or what possible third-party hypervisors are out
there.

If we could do it, it would be good.  But I have my doubts about the
feasibility and the benefits.  If different hypervisors are significantly
imcompatible, then having a common low-level ABI doesn't help all that
much.

Cheers
---Dave
