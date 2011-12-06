From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 00:46:54 +0000
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
In-Reply-To: <alpine.LFD.2.02.1112051934000.2357@xanadu.home>
References: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
 <4EDD3E5E.6050106@gmail.com> <alpine.LFD.2.02.1112051707520.2357@xanadu.home>
 <20111205233621.GH14542@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112051934000.2357@xanadu.home>
Message-ID: <20111206004654.GK14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 07:37:26PM -0500, Nicolas Pitre wrote:
> On Mon, 5 Dec 2011, Russell King - ARM Linux wrote:
> 
> > On Mon, Dec 05, 2011 at 05:08:12PM -0500, Nicolas Pitre wrote:
> > > On Mon, 5 Dec 2011, Rob Herring wrote:
> > > 
> > > > On 12/05/2011 03:22 PM, Linus Walleij wrote:
> > > > > Hi Nico,
> > > > > 
> > > > > now I'm lost, I discussed by boot problems on ARM PB1176
> > > > > with Marc and after some investigation I found this strange thing on
> > > > > the lastest rc:s since -rc1:
> > > > > 
> > > > > In arch/arm/Kconfig ARM_PATCH_PHYS_VIRT is forcibly
> > > > > disabled like so:
> > > > > 
> > > > > depends on !ARCH_REALVIEW || !SPARSEMEM
> > > > 
> > > > should be !ARCH_REALVIEW && !SPARSEMEM ?
> > > 
> > > Indeed.
> > 
> > No, it's correct.  None of you are understanding the logic.
> > 
> > If you don't understand it, draw up a truth table:
> > 
> > ARCH_REALVIEW	SPARSEMEM	result
> > n		n		y
> > n		y		y
> > y		n		y
> > y		y		n
> > 
> > And this clearly shows that if we have realview _and_ sparsemem enabled,
> > then we don't want P2V patching in place.
> 
> I didn't look closely at Realview.  However the usefulness of P2V 
> patching when sparsemem is used is somewhat questionable I would say. 

No it isn't.

Provided there's a linear v:p mapping, P2V can be used.  Only when
there's a non-linear mapping does P2V fail.  That's got nothing to do
with sparsemem, as you can be using sparsemem and still have a linear
v:p mapping (and several platforms do.)
