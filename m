From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 12:28 +0100
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <547EEF9A.9010906@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <20141203102829.GA17502@cbox> <547EEF9A.9010906@arm.com>
Message-ID: <2906594.cDZcXzbGMh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 11:10:18 Andre Przywara wrote:
> On 03/12/14 10:28, Christoffer Dall wrote:
> > On Tue, Dec 02, 2014 at 04:24:53PM +0000, Andre Przywara wrote:
> >> On 30/11/14 08:30, Christoffer Dall wrote:
> >>
> >> If we are flexible with the mapping at VM creation time, QEMU could just
> >> use a mapping depending on max_cpus:
> >> < 128 VCPUs: use the current mapping
> >> 128 <= x < 1020: use a more compressed mapping
> >>> = 1020: map the redistributor somewhere above 4 GB
> > 
> > I don't understand what the compressed mapping is. 
> 
> Currently we have in QEMU:
>    0 MB -  128 MB: Flash
>  128 MB -  144 MB: CPU peripherals (GIC for now only)
>  144 MB -  144 MB: UART (64k)
>  144 MB -  144 MB: RTC (64k)
>  160 MB -  256 MB: virtio (32 * 512 Bytes used)
>  256 MB - 1024 MB: PCI
> 1024 MB - ???? MB: DRAM
> 
> So we waste quite some space between 144 MB and 256 MB, where we
> currently use only 3 64K pages. If we would move those three pages
> closer to the 256 MB region, we could extend the GIC mapping space from
> 16 MB (127 VCPUs) to almost 128 MB (good for 1022 VCPUs).

Having a more compressed mapping sounds useful, but you could also consider
carving the GIC registers out of the PCI range and make PCI memory space
smaller if there are lots of CPUs.

Is there also a 64-bit PCI memory space behind the DRAM?

	Arnd
