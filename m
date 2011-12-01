From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 1 Dec 2011 10:26:37 +0000
Subject: [Embeddedxen-devel] [Xen-devel] [ANNOUNCE] Xen port to
 Cortex-A15 / ARMv7 with virt extensions
In-Reply-To: <alpine.DEB.2.00.1111301820290.31179@kaball-desktop>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <201111301432.54463.arnd@arndb.de>
 <1322670473.31810.129.camel@zakaz.uk.xensource.com>
 <201111301815.01297.arnd@arndb.de>
 <alpine.DEB.2.00.1111301820290.31179@kaball-desktop>
Message-ID: <1322735197.31810.191.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 18:32 +0000, Stefano Stabellini wrote:
> On Wed, 30 Nov 2011, Arnd Bergmann wrote:

> 
> > KVM and Xen at least both fall into the single-return-value category,
> > so we should be able to agree on a calling conventions. KVM does not
> > have an hcall API on ARM yet, and I see no reason not to use the
> > same implementation that you have in the Xen guest.
> > 
> > Stefano, can you split out the generic parts of your asm/xen/hypercall.h
> > file into a common asm/hypercall.h and submit it for review to the
> > arm kernel list?
> 
> Sure, I can do that.
> Usually the hypercall calling convention is very hypervisor specific,
> but if it turns out that we have the same requirements I happy to design
> a common interface.

I expect the only real decision to be made is hypercall page vs. raw hvc
instruction.

The page was useful on x86 where there is a variety of instructions
which could be used (at least for PV there was systenter/syscall/int, I
think vmcall instruction differs between AMD and Intel also) and gives
some additional flexibility. It's hard to predict but I don't think I'd
expect that to be necessary on ARM.

Another reason for having a hypercall page instead of a raw instruction
might be wanting to support 32 bit guests (from ~today) on a 64 bit
hypervisor in the future and perhaps needing to do some shimming/arg
translation. It would be better to aim for having the interface just be
32/64 agnostic but mistakes do happen.

Ian.
