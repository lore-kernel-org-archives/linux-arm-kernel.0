From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Feb 2015 18:32:30 +0000
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <20150220175931.GL8656@n2100.arm.linux.org.uk>
References: <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
 <20150220102009.GF8656@n2100.arm.linux.org.uk>
 <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
 <20150220133806.GG8656@n2100.arm.linux.org.uk>
 <CAOMZO5BgrWGciKt0pjpbtX4wP0CgWWN39BcSjnSD89MxKEpBCg@mail.gmail.com>
 <20150220140440.GF31692@arm.com>
 <20150220175931.GL8656@n2100.arm.linux.org.uk>
Message-ID: <20150220183230.GP31692@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 05:59:31PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 20, 2015 at 02:04:40PM +0000, Will Deacon wrote:
> > On Fri, Feb 20, 2015 at 01:49:22PM +0000, Fabio Estevam wrote:
> > > On Fri, Feb 20, 2015 at 11:38 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > 
> > > > From what I can see, this doesn't _build_ a compiler.  It grabs
> > > > gcc-linaro-aarch64-linux-gnu-4.9-2014.08_linux.tar.xz from
> > > > http://releases.linaro.org/14.08/components/toolchain/binaries
> > > > and installs that - which contains a load of binaries.
> > > 
> > > That's correct. It uses the pre-built binaries from Linaro.
> > 
> > For sources, you can usually just pick up the latest GCC release. For
> > example, 4.9.2 worked for me:
> > 
> >   ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.9.2/gcc-4.9.2.tar.bz2
> > 
> > I can't recommend using trunk at the moment (i.e. GCC 5), as we hit some
> > issues with the PSCI calling code that I plan to post fixes for at -rc1.
> 
> Thanks, that version of gcc appears to work correctly with the kernel.
> I've updated the builder with that.
> 
> There's a number of worrying warnings for ldp/stp instructions though.
> Is that a binutils issue, or a KVM issue?

That one's a binutils issue -- it's erroneously aliasing sp and xzr. I filed
a bug internally with our tools team, so it should be fixed soon.

> I've sent Greg a fix for the drivers/base/component.c warning.
> 
> There's a number of warnings in drivers/pci/host/pci-xgene.c which
> look like they need resolving - returning NULL from a function which
> returns an 'int' has never been valid - has this commit (which seems
> to have introduced the problem) actually been tested?

Yeah, I noticed those but haven't dug into them yet (I also don't have
an xgene).

Will
