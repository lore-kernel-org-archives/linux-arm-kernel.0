From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Apr 2015 11:53:45 +0100
Subject: [RFC] mixture of cleanups to cache-v7.S
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150402224947.GX24899@n2100.arm.linux.org.uk>
 <20150402225759.GY24899@n2100.arm.linux.org.uk>
 <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <20150403105345.GA24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:08:48AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 02, 2015 at 11:57:59PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 02, 2015 at 11:49:47PM +0100, Russell King - ARM Linux wrote:
> > > Several cleanups are in the patch below... I'll separate them out, but
> > > I'd like to hear comments on them.  Basically:
> > > 
> > > 1. cache-v7.S is built for ARMv7 CPUs, so there's no reason not to
> > >    use movw and movt when loading large constants, rather than using
> > >    "ldr rd,=constant"
> > > 
> > > 2. we can do a much more efficient check for the errata in
> > >    v7_flush_dcache_louis than we were doing - rather than putting the
> > >    work-around code in the fast path, we can re-organise this such that
> > >    we only try to run the workaround code if the LoU field is zero.
> > > 
> > > 3. shift the bitfield we want to extract in the CLIDR to the appropriate
> > >    bit position prior to masking; this reduces the complexity of the
> > >    code, particularly with the SMP differences in v7_flush_dcache_louis.
> > > 
> > > 4. pre-shift the Cortex A9 MIDR value to be checked, and shift the
> > >    actual MIDR to lose the bottom four revision bits.
> > > 
> > > 5. as the v7_flush_dcache_louis code is more optimal, I see no reason not
> > >    to enable this workaround by default now - if people really want it to
> > >    be disabled, they can still choose that option.  This is in addition
> > >    to Versatile Express enabling it.  Given the memory corrupting abilities
> > >    of not having this errata enabled, I think it's only sane that it's
> > >    something that should be encouraged to be enabled, even though it only
> > >    affects r0pX CPUs.
> > > 
> > > One obvious issue comes up here though - in the case that the LoU bits
> > > are validly zero, we merely return from v7_flush_dcache_louis with no
> > > DSB or ISB.  However v7_flush_dcache_all always has a DSB or ISB at the
> > > end, even if LoC is zero.  Is this an intentional difference, or should
> > > v7_flush_dcache_louis always end with a DSB+ISB ?
> > 
> > I should point out that if the DSB+ISB is needed, then the code can
> > instead become as below - basically, we just move the CLIDR into the
> > appropriate position and call start_flush_levels, which does the DMB,
> > applies the mask to extract the appropriate field, and then decides
> > whether it has any levels to process.
> 
> I've now tested this patch on the Versatile Express and SDP4430, and
> both seem to work fine with the patch below.

Here's the patches broken out.  My intention is to put the first five,
which should be entirely non-contravercial, into my for-next branch.
The last two, I'll wait until I hear back from you after the Easter
break.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
