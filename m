From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Jun 2013 15:10:01 +0100
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <alpine.LFD.2.03.1306170725180.18597@syhkavp.arg>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
 <20130610232441.GI18614@n2100.arm.linux.org.uk>
 <20130611090459.GA9529@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1306111136060.18597@syhkavp.arg>
 <20130617101050.GD6809@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1306170725180.18597@syhkavp.arg>
Message-ID: <20130620141000.GD30328@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 12:25:48PM +0100, Nicolas Pitre wrote:
> On Mon, 17 Jun 2013, Mark Rutland wrote:
> 
> > On Tue, Jun 11, 2013 at 04:43:59PM +0100, Nicolas Pitre wrote:
> > > On Tue, 11 Jun 2013, Mark Rutland wrote:
> > > 
> > > > On Tue, Jun 11, 2013 at 12:24:41AM +0100, Russell King - ARM Linux wrote:
> > > > > On Mon, Jun 10, 2013 at 04:07:24PM +0100, Mark Rutland wrote:
> > > > > > When booting fewer cores than are physically present on a versatile
> > > > > > platform (e.g. when passing maxcpus=N on the command line), some
> > > > > > secondary cores may remain in the holding pen, which is marked __INIT.
> > > > > > Late in the boot process, the memory comprising the holding pen will be
> > > > > > released to the kernel for more general use, and may be overwritten with
> > > > > > arbitrary data, which can cause the held secondaries to start behaving
> > > > > > unpredictably. This can lead to all manner of odd behaviour from the
> > > > > > kernel.
> > > > > > 
> > > > > > Instead don't mark the section as __INIT. This means we can't reuse the
> > > > > > pen memory, but we won't get secondaries corrupting the rest of the
> > > > > > kernel.
> > > > > 
> > > > > __CPUINIT is appropriate here; __CPUINIT will be kept around if you have
> > > > > hotplug CPU suport, but if you don't it will be discarded after all
> > > > > secondary CPUs have booted.  And without hotplug CPU, you can't ask
> > > > > for the offline CPUs to be onlined.
> > > > 
> > > > Since 384a290283: "ARM: gic: use a private mapping for CPU target interfaces",
> > > > each CPU's gic_cpu_map entry is initialised to 0xff, so a call to
> > > > gic_raise_softirq will target *all* CPUs attached to the GIC if one of the CPUs
> > > > targetted has not been initialised.
> > > > 
> > > > Thus any call to versatile_boot_secondary will wake up *all* secondaries
> > > > physically present, throwing them all into the pen. If we use a subset of these
> > > > (e.g. from having "maxcpus=N" on the command line), some will be left in the
> > > > pen, even though we didn't ask for them explicitly. This will happen with or
> > > > without CPU_HOTPLUG.
> > > > 
> > > > Another option would be to add an optional description of a CPU's gic id to the
> > > > dt, which would allow us to avoid throwing these secondaries into the pen in
> > > > the first place.
> > > 
> > > You mean adding extra description in DT for hardware information that is 
> > > already perfectly self-discoverable, plus the code to parse it, just for 
> > > those rare cases where someone might want to use maxcpus=N on the kernel 
> > > cmdline while CONFIG_CPU_HOTPLUG=n ?
> > > 
> > > IMHO removing __CPUINIT from the holding pen is probably the preferable 
> > > alternative.
> > 
> > Ok, could I take that as your ack on the original patch?
> 
> Yes.  And feel free to complement it with the above justification.

Cheers.

I've dropped a version with an expanded description into Russell's patch system
as 7766/1, in the hope this could go in soon, as it appears to be affecting
others [1].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/177499.html
