From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2015 22:08:33 +0100
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <CAFEAcA_pNaD5c12c6D0GtLkQ_zrJx009Y5qZffmv02hirvewdg@mail.gmail.com>
References: <561E6407.6000002@sigmadesigns.com>
 <20151014174503.GQ32532@n2100.arm.linux.org.uk>
 <CAFEAcA_pNaD5c12c6D0GtLkQ_zrJx009Y5qZffmv02hirvewdg@mail.gmail.com>
Message-ID: <20151014210833.GS32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 09:19:56PM +0100, Peter Maydell wrote:
> On 14 October 2015 at 18:45, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Oct 14, 2015 at 04:17:43PM +0200, Marc Gonzalez wrote:
> >> Hello everyone,
> >>
> >> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
> >>
> >> On my platform, Linux v4.2 running in non-secure mode panics in
> >> l2c310_enable() with the pc pointing at this instruction:
> >>
> >> c03390cc: ee013f30 mcr 15, 0, r3, cr1, cr0, {1}
> >>
> >> which corresponds to set_auxcr IIUC.
> > ...
> >> According to the Cortex A9 documentation,
> >> ACTLR is RO in non-secure mode if NSACR[18]=0 and RW if NSACR[18]=1
> >>
> >> I suppose writing to a RO register cause the exception I see?
> >
> > It should not, the write should be ignored and no exception should be
> > raised.
> 
> My reading of the v7 ARM ARM ('Read-only and write-only encodings'
> under section B3.15.2) is that writes via MCR to a register defined as 'RO'
> are UNPREDICTABLE. (In v8 this is tightened up, and such write
> attempts are UNDEFINED.)

Sorry, but this isn't the case - the ARM ARM defines it otherwise:

"B4.1.1 ACTLR, IMPLEMENTATION DEFINED Auxiliary Control Register, VMSA
The ACTLR characteristics are:
The ACTLR provides IMPLEMENTATION DEFINED configuration and control options.

...
Configurations

If the implementation includes the Security Extensions, this register
is Banked. However, some bits might define global configuration settings,
and be common to the Secure and Non-secure copies of the register."

> More specifically for this case, the Cortex-A9 TRM description of
> NSACR.NS_SMP says that if it is zero then "A write to Auxiliary Control
> Register in Non-secure state takes an Undefined Instruction exception".
> So the behaviour Marc reports is expected if NS_SMP is 0.

Well, if that's what the CA9 TRM says, that's the behaviour that the
device has, which is contary to the ARM ARM.

If the ACTLR is not writable, then FLZ can't be enabled on the platform.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
