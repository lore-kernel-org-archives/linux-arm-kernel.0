From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 13 Sep 2012 12:12:54 +0100
Subject: [PATCH v3 06/25] docs: Xen ARM DT bindings
In-Reply-To: <20120913102616.GA2470@linaro.org>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
 <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <503BFCD8.5090804@gmail.com>
 <alpine.DEB.2.02.1208281823270.15568@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1209121849200.15568@kaball.uk.xensource.com>
 <20120913102616.GA2470@linaro.org>
Message-ID: <alpine.DEB.2.02.1209131206510.15568@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Sep 2012, Dave Martin wrote:
> On Wed, Sep 12, 2012 at 07:14:58PM +0100, Stefano Stabellini wrote:
> > On Wed, 12 Sep 2012, Stefano Stabellini wrote:
> > - hcall-instructions
> > potentially interesting, but given that for Xen we are quite happy with
> > HVC, we are not going to add any secondary hypercall mechanisms,
> > therefore at the moment it would just result in a BUG if the specified
> > hcall instruction is != HVC. Besides if somebody else wanted to
> > implemented the Xen hypercall interface in a different way they could
> > just reimplement the hypercall wrappers, that would be easier than
> > trying to do it with this property.
> 
> Some thoughts on this:
> 
> We decided that embedding machine instructions into the DT is a fairly
> awful idea when discussing how to describe low-level debug UARTs in the
> DT.  I don't think it's a lot better in this case (never mind issues
> like ARM versus Thumb, endianness etc.)
> 
> If we are going to attempt to describe the call interface, we should
> do it symbolically, allowing the hypervisor interface code in the kernel
> to choose (or, if necessary, generate) the right call wrappers.
> 
> We will have this issue for descrbing power firmware interfaces for
> example: we already know that this functionality might require an SMC
> or HVC instruction to call it, depending on the platform.
> 
> A hypervisor with only one call ABI could leave this to be implicit,
> providing there is a version number property of similar to allow future
> changes to be accommodated.

I completely agree with Dave.
I have no problems adding a symbolic property to say "we are using hvc
with parameters on registers". I just want to avoid having actual
machine instructions (and potentially dealing with executing them) into
the DT.

Maybe we could have a "calling-convention" property that can be "xen"
or something else. When a new hypervisor vendor comes along it can
change the value of "calling-convention" to "foo".
