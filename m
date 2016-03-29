From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2016 18:05:59 +0100
Subject: [RFC PATCH 2/3] arm64: Expose physical/virtual address bits
 through cpuinfo
In-Reply-To: <20160329112940.GE3701@e103592.cambridge.arm.com>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458898209-7486-3-git-send-email-wangkefeng.wang@huawei.com>
 <20160329112940.GE3701@e103592.cambridge.arm.com>
Message-ID: <20160329170559.GB19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 12:29:40PM +0100, Dave Martin wrote:
> On Fri, Mar 25, 2016 at 05:30:08PM +0800, Kefeng Wang wrote:
> > ARMv8 Physical Address range allows 0x0~0x6, the 0x6 is supported
> > in ARMv8.2, permitted values in ID_AA64MMFR0_EL1 are:
> > 0000  32 bits, 4GB.
> > 0001  36 bits, 64GB.
> > 0010  40 bits, 1TB.
> > 0011  42 bits, 4TB.
> > 0100  44 bits, 16TB.
> > 0101  48 bits, 256TB.
> > 0110  52 bits, 4096TB.
> > All other values are reserved.
> > 
> > Meanwhile, ARMv8 can support 48bit or 52bit virtual addresses,
> > larger virtual address(52bit) is introduced in ARMv8.2.
> > 
> > Exposing the physical and virtual address bits to userspace through
> > procfs like x86, then it is easy to check the capacity of them that
> > cpu supported from cpuinfo.
>
> Can you say why this information is useful for userspace?
> 
> Once anything is added to cpuinfo it becomes ABI and must be supported
> forever, so we want to avoid adding anything that is not absolutely
> definitely needed...

It's also something that becomes different between ARM32 and ARM64, and
I'm not adding it to ARM32 without a _very_ good justification why we
need such information exported to userspace.

Given that userspace is fully insulated on 32-bit ARM from any knowledge
of LPAE, I see zero reason why userspace needs to have any knowledge of
the LPAE physical address space.  Even my work on kexec on the most
weird of ARMv7 LPAE platforms (where system memory is above 4GB phys)
there's no reason for userspace to have any specific knowledge of LPAE.
IOW, /dev/mem is just a file, just like any other file larger than 4GB.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
