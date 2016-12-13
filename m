From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Dec 2016 11:30:44 +0000
Subject: [PATCH] ARM: soft-reboot into same mode that we entered the kernel
In-Reply-To: <20161213111115.GX14217@n2100.armlinux.org.uk>
References: <E1cFRAn-0003ob-HH@rmk-PC.armlinux.org.uk>
 <20161213105410.GB19985@leverpostej>
 <20161213111115.GX14217@n2100.armlinux.org.uk>
Message-ID: <20161213113044.GC19985@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:11:15AM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 13, 2016 at 10:54:11AM +0000, Mark Rutland wrote:
> > On Fri, Dec 09, 2016 at 07:49:37PM +0000, Russell King wrote:
> > >  ENTRY(__hyp_set_vectors)
> > > +	tst	r0, #31
> > > +	bne	1f
> > >  	__HVC(0)
> > > -	ret	lr
> > > +1:	ret	lr
> > >  ENDPROC(__hyp_set_vectors)
> > 
> > Why the new check? This looks unrelated to the rest of the patch.
> 
> It's not unrelated.  The ARM32 hyp-stub has a total crap ABI:
> 
> - r0 = -1 => read VBAR
> - r0 != -1 => write r0 to VBAR
>
> So, this check is there to ensure that you can't do something stupid
> like:
> 	__hyp_set_vectors(1)
> 
> and inadvertently end up invoking the restart method - the check is
> there to "make room" for the new hyp call in the ABI.

Ok. This is definitely less than ideal.

We should be able to fix that up more generally, and pass separate
parameters (as we do on arm64).

> It hasn't been clear what the scope of the API, or the stub ABI actually
> is - nothing about that is really documented,

The hyp-stub is part of the kernel image, and the API is private to that
particular image, so we can change things -- there's no ABI to worry
about.

> so I didn't want to
> radically redesign the stub ABI to be more sensible and risk breakage
> elsewhere - especially as I'm reliant on others to test this.  (All my
> 32-bit platforms enter the kernel in SVC mode from the boot loader, even
> those which are virtualisation-capable.)

Sure. I'm more than willing to review/test patches for this.

Thanks,
Mark.
