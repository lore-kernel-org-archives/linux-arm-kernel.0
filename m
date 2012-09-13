From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 13 Sep 2012 11:26:16 +0100
Subject: [PATCH v3 06/25] docs: Xen ARM DT bindings
In-Reply-To: <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
 <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <503BFCD8.5090804@gmail.com>
 <alpine.DEB.2.02.1208281823270.15568@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
Message-ID: <20120913102616.GA2470@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 07:14:58PM +0100, Stefano Stabellini wrote:
> On Wed, 12 Sep 2012, Stefano Stabellini wrote:
> > On Tue, 28 Aug 2012, Rob Herring wrote:
> > > You should look at ePAPR 1.1 which defines hypervisor related bindings.
> > > While it is a PPC doc, we should reuse or extend what makes sense.
> > > 
> > > See section 7.5:
> > > 
> > > https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf
> > 
> > Thanks for the link, I wasn't aware of ePAPR.
> > 
> > The hypervisor node defined by ePAPR is not very different from what I
> > am proposing. Should I try to be compatible with the hypervisor
> > specification above (as in compatible = "epapr,hypervisor-1.1")?
> > Or should I just use it as a reference for my own specification?
> > 
> > Personally I would rather avoid full compatibility with ePAPR.
> 
> In particular reading section 7.5, these are the required properties of
> the ePAPR hypervisor node:
> 
> - compatible = "epapr,hypervisor-1.1"
> compared to what I am proposing, it is laking information about what
> hypervisor we are talking about (xen, kvm, vmware, etc) and the version
> of the ABI (xen-4.2).
> 
> - hcall-instructions
> potentially interesting, but given that for Xen we are quite happy with
> HVC, we are not going to add any secondary hypercall mechanisms,
> therefore at the moment it would just result in a BUG if the specified
> hcall instruction is != HVC. Besides if somebody else wanted to
> implemented the Xen hypercall interface in a different way they could
> just reimplement the hypercall wrappers, that would be easier than
> trying to do it with this property.

Some thoughts on this:

We decided that embedding machine instructions into the DT is a fairly
awful idea when discussing how to describe low-level debug UARTs in the
DT.  I don't think it's a lot better in this case (never mind issues
like ARM versus Thumb, endianness etc.)

If we are going to attempt to describe the call interface, we should
do it symbolically, allowing the hypervisor interface code in the kernel
to choose (or, if necessary, generate) the right call wrappers.

We will have this issue for descrbing power firmware interfaces for
example: we already know that this functionality might require an SMC
or HVC instruction to call it, depending on the platform.

A hypervisor with only one call ABI could leave this to be implicit,
providing there is a version number property of similar to allow future
changes to be accommodated.


Cheers
---Dave
