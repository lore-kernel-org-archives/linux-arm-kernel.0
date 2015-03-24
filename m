From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Mar 2015 06:17:29 +0100
Subject: [PATCH 0/5] Driver for pxa architectures
In-Reply-To: <878uen78u5.fsf@free.fr>
References: <1426977868-5414-1-git-send-email-robert.jarzmik@free.fr>
 <201503231604.44551.arnd@arndb.de> <878uen78u5.fsf@free.fr>
Message-ID: <201503240617.29810.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 March 2015, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> ... removed people not concerned by pxa story ...
> 
> >> As for XIP support, I don't have a clear view if it's a requirement for
> >> multiplatform nor if it works in these builds.
> >
> > It would be nice to not have to support both options: if we put pxa into
> > ARCH_MULTIPLATFORM, I'd like to remove the existing entry from the choice
> > statement at the same time.
> Ah I wasn't aware of that ... that will deserve some thought from me ...

It's not 100% required, but it's what we ended up doing on all other
platforms.

> >> > I think all of them are theoretically doable, but I wasn't expecting
> >> > to ever get there.
> >> Well, that makes me a goal to reach, doesn't it ? I'll stick to optimism here,
> >> and we'll see within a year how far I manage to go :)
> >
> > Fair enough. Any work you do on this is highly appreciated anyway,
> > regardless of whether you complete it or not. BTW, one thought I had
> > a while ago was that we can move support for any PXA machines that are
> > DT enabled into mach-mmp, which hopefully will be fully DT-only and
> > multiplatform enabled at some point, and we can keep mach-pxa for the
> > legacy board files if you don't succeed in converting them all.
> 
> Actually, this deserves another discussion alltogether. My plan was not to
> convert all pxa board files to dt support, but all internal SoC IPs drivers +
> mach/plat support.
> 
> Or put another way at the end :
>  - there will be at least one pxa25x board which is fully DT converted
>  - there will be at least one pxa27x board which is fully DT converted
>  - there will be at least one pxa3xx board which is fully DT converted
> 
>  - there will be at least one pxa25x board which is not DT converted
>  - there will be at least one pxa27x board which is not DT converted
>  - there will be at least one pxa3xx board which is not DT converted
> 
> I want to keep the support for both legacy platform_data and DT for pxa
> architecture. The idea I had was that only fully DT converted machines will
> benefit from multiplatform support.

I see. On other platforms, we also have board files that are not DT
but are included in multiplatform. I don't see anything wrong in general.

The more important question is whether you want to keep having a single
kernel capable of running on all PXA machines (DT and ATAGS), while also
doing a subset of PXA that can be multiplatform with other ARMv5 targets
like pxa168 (MMP) but excluding the rest of PXA.

> As for mach-mmp, I don't see how this could work, as there are architecture
> specific parts that will probably remain, such as the suspend to RAM code
> (arch/arm/mach-pxa/sleep.S). This might be doable, even if I don't see how.

Those parts could be moved to plat-pxa.

	Arnd
