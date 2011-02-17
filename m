From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Thu, 17 Feb 2011 02:18:14 +0200
Subject: [klibc] fwd: fix up ARM assembly to use 'bx lr' in place of 'mov
	pc, lr'.
In-Reply-To: <20110217000144.GA6995@virgil.dodds.net>
References: <20110216230648.GA7649@stro.at>
	<20110216235019.GA17674@shutemov.name>
	<20110217000144.GA6995@virgil.dodds.net>
Message-ID: <20110217001814.GA18903@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 04:01:44PM -0800, Steve Langasek wrote:
> Thanks for forwarding this on, maks.
> 
> On Thu, Feb 17, 2011 at 01:50:19AM +0200, Kirill A. Shutemov wrote:
> > > Date: Wed, 16 Feb 2011 22:05:42 -0000
> > > From: Steve Langasek <steve.langasek@canonical.com>
> > > Subject: [Bug 527720] Re: thumb2 porting issues identified: klibc uses mov.*pc
> 
> > > I've also touched it up to be mergeable with Debian (support v4t builds
> > > with #ifdef).
> 
> > > Confirmed that installing the resulting klibc packages on my beagleboard
> > > gives me a successfully-booting initramfs with klibc; and the
> > > vfork/setjmptest test cases all pass in the klibc package tree.
> 
> > > Fixes: https://bugs.launchpad.net/ubuntu/+source/klibc/+bug/527720
> 
> > > --- klibc-1.5.20.orig/usr/klibc/arch/arm/vfork.S
> > > +++ klibc-1.5.20/usr/klibc/arch/arm/vfork.S
> > > @@ -25,7 +25,11 @@ vfork:
> > >          ldrcs	r3, 1f
> > >          mvncs	r0, #0
> > >          strcs	r2, [r3]
> > > +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
> 
> > NAK. ARMv4T supports bx intruction. ARMv4 doesn't.
> 
> I see from
> https://wiki.ubuntu.com/ARM/Thumb2PortingHowto#Identifying%20the%20Target%20Architecture
> that you are correct - but then in
> https://wiki.ubuntu.com/ARM/Thumb2PortingHowto#Detailed%20Instruction%20Behaviour
> the recommendation given is to use exactly this guard for backwards
> compatibility.

glibc-ports:

sysdeps/arm/sysdep.h:
#if (!defined (__ARM_ARCH_2__) && !defined (__ARM_ARCH_3__) \
     && !defined (__ARM_ARCH_3M__) && !defined (__ARM_ARCH_4__))
# define __USE_BX__
#endif

sysdeps/arm/dl-machine.h:
#if defined(__USE_BX__)
#define BX(x) "bx\t" #x
#else
#define BX(x) "mov\tpc, " #x
#endif

> 
> I'm cc:ing Dave Martin from ARM who drafted this porting guide.  Dave, was
> there some other reason besides instruction compatibility to prefer the
> original "mov pc,lr" on armv4t, or is this simply a miscopy?
> 
> > >  	mov	pc, lr
> > > +#else
> > > +	bx	lr
> > > +#endif
> 
> Thanks,
> -- 
> Steve Langasek                   Give me a lever long enough and a Free OS
> Debian Developer                   to set it on, and I can move the world.
> Ubuntu Developer                                    http://www.debian.org/
> slangasek at ubuntu.com                                     vorlon at debian.org



-- 
 Kirill A. Shutemov
