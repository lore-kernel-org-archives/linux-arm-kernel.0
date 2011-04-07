From: george@znau.edu.ua (George Kashperko)
Date: Thu, 07 Apr 2011 21:50:40 +0300
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <op.vtj8jn133ri7v4@arend-laptop>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTinubrmryu=Bco5_AVcj_arn7SWZxw@mail.gmail.com>
	<op.vti9ote53ri7v4@arend-laptop>
	<BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
	<BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
	<1302123428.20093.6.camel@maggie>
	<BANLkTimGSoYzp0Z4vyCS_H5PDKhgjYuLBA@mail.gmail.com>
	<1302124112.20093.11.camel@maggie>
	<BANLkTik76dwwnmmPzXL9Kkk7fdt01QPzZA@mail.gmail.com>
	<1302124737.27258.7.camel@dev.znau.edu.ua>
	<BANLkTi=4-LgrkjG96+Ar3SjMOsKh-dMuLg@mail.gmail.com>
	<1302134429.27258.32.camel@dev.znau.edu.ua>
	<BANLkTinfM0QLFwcKZXfWQ_jNYfBJg_et-Q@mail.gmail.com>
	<1302162886.10725.4.camel@maggie>  <op.vtj8jn133ri7v4@arend-laptop>
Message-ID: <1302202240.30694.16.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Thu, 07 Apr 2011 09:54:46 +0200, Michael B?sch <mb@bu3sch.de> wrote:
> 
> >> Ahh, so while talking about 4 windows, I guess you counted fixes
> >> windows as well. That would be right, matching my knowledge.
> >>
> >> When asking question about amount of cores we may want to use
> >> simultaneously I didn't think about ChipCommon or PCIe. The real
> >> problem would be to support for example two 802.11 cores and one
> >> ethernet core at the same time. That gives us 3 cores while we have
> >> only 2 sliding windows.
> >
> > Would that really be a problem? Think of it. This combination
> > will only be available on embedded devices. But do we have windows
> > on embedded devices? I guess not. If AXI is similar to SSB, the MMIO
> > of all cores will always be mapped. So accesses can be done
> > without switch or lock.
> 
> Agree. For embedded systems there is no need to switch cores. Each core  
> register space and wrapper register space is mapped. In the brcm80211 we  
> have the concept of fast versus slow host interface. The criteria for fast  
> host interface is based on following expression:
> 
> fast_host_bus = (host_bus_coretype == PCIE_CORE_ID) ||
> 	((host_bus_coretype == PCI_CORE_ID) && (host_bus_corerev >= 13))
> 
> If this is true, chipcommon and pci/pcie registers are accessed without  
> sliding the window using the fixed offsets Rafa? mentioned earlier. The  
> BAR0 window size is 16KB.
Well, the major pci window managing concept in your code isn't really
fast switching but rather smart switching. chipcommon and pci bridge
core specific processing is well refined in appropriate routines each
looking like:
irqdisable switchcore(cc_or_pcie)
... code ...
switchcore(back) irqenable

Thus you always have pci window pointing to the function core and can
ioread/iowrite without spinlocking windowed accesses.

Yes, you use also "fast" switching for pci rev. >= 13 && pcie avoiding
irq(ena|disa) for such a configurations but, as I've mentioned earlier,
for axi this is rudimentary from pci rev. < 13 times as both pci bridge
and chipcommon are available simultaneously with fixed windows.

> 
> > I do really think that engineers at broadcom are clever enough
> > to design a hardware that does not require expensive window sliding
> > all the time while operating.
> >
> 
> If a bigger window is clever enough ;-)
> 
> Gr. AvS

Have nice day,
George
