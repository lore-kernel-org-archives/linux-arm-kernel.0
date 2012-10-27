From: pavel@denx.de (Pavel Machek)
Date: Sat, 27 Oct 2012 13:43:56 +0200
Subject: ERRATA_751472 was Re: [PATCHv2] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <1351187384.15182.18.camel@dinh-ubuntu>
References: <1350581567-17229-1-git-send-email-dinguyen@altera.com>
 <50887348.9070904@gmail.com> <1351182356.15182.7.camel@dinh-ubuntu>
 <50895D9F.4080009@gmail.com>
 <1351187384.15182.18.camel@dinh-ubuntu>
Message-ID: <20121027114354.GB5912@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > multi_v7 works fine for me. But I need
> > > +#CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set 
> > 
> > Why? I don't think those should break other versions of A9. If they do,
> > we need to fix that. In general, we should turn on all errata for
> > multi-platform builds, so we need to make sure they are done in a
> > compatible way and can be bypassed if they have performance impacts.
> > That may ultimately require some runtime patching though.
> 
> Our virtual platform is having a problem with CONFIG_ARM_ERRATA_751472.
> It could be that our virtual platform is not simulating this
> correctly.

proc-v7.S:

#if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
        ALT_SMP(cmp r6, #0x30)                  @ present prior to r3p0
        ALT_UP_B(1f)
	mrclt   p15, 0, r10, c15, c0, 1         @ read diagnostic register
        orrlt   r10, r10, #1 << 11              @ set bit #11
        mcrlt   p15, 0, r10, c15, c0, 1         @ write diagnostic register
1:
#endif

Is ALT_SMP()/ALT_UP available this early during boot?

If it is, do we need the && defined(CONFIG_SMP)? ALT_UP_... should do
the right thing. (Okk, I guess the ifdef saves cca 16 bytes in the
image...)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
