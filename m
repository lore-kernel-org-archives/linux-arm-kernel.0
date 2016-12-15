From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Dec 2016 11:35:39 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
 <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
Message-ID: <20161215113539.GK14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 11:18:48AM +0000, Marc Zyngier wrote:
> On 14/12/16 10:46, Russell King wrote:
> > @@ -231,10 +244,14 @@ ENDPROC(__hyp_stub_do_trap)
> >   * initialisation entry point.
> >   */
> >  ENTRY(__hyp_get_vectors)
> > -	mov	r0, #-1
> > +	mov	r0, #HVC_GET_VECTORS
> 
> This breaks the KVM implementation of __hyp_get_vectors, easily fixed
> with the following patchlet:

Right, so what Mark said is wrong:

"The hyp-stub is part of the kernel image, and the API is private to
 that particular image, so we can change things -- there's no ABI to
 worry about."

So no, I'm going with my original patch (which TI has tested) which is
the minimal change, and if we _then_ want to rework the HYP mode
interfaces, that's the time to do the other changes when more people
(such as KVM folk) are paying attention and we can come to a cross-
hypervisor agreement on what the interface should be.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
