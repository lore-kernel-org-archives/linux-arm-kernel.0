From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 May 2017 10:33:05 +0100
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low
 DRAM performance
In-Reply-To: <CAOEkoLziLQ4z1L=wdMF_5tcm3ETbSwLm-tvreB6uSFxobE8gjg@mail.gmail.com>
References: <CAOEkoLw3Y5h2P_aFeMKgHYyKZpQvsQsOPOLOuvaYZGOe+rHJWQ@mail.gmail.com>
 <20170516082922.GY22219@n2100.armlinux.org.uk>
 <CAOEkoLziLQ4z1L=wdMF_5tcm3ETbSwLm-tvreB6uSFxobE8gjg@mail.gmail.com>
Message-ID: <20170518093305.GL22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 04:25:12PM +0800, Zhao Yibin wrote:
> Hi, Russell,
> 
> I traced the page table of TTBR0,  and the map descriptor of the page
> allocated from share ram,
> TEX[0]-C-B is 0-1-1, LPAE is not enable, the TRE is 1, so TEX[0]-C-B
> is mapped to the 3rd index of PRRR and NMRR.
> PRRR register is 0xFF0A81A8, NMRR register is 0x40E040E0.
> So the memory type is normal, and IR/OR is "Region is Write-Back, no
> Write-Allocate." according to armv7 TRM
> 
> I don't know what read-allocate can be, if cortex-a7 is simliar to
> cortex-a15, then write-back read-allocate means
> "Write-Back Read-Allocate  => Write-Back Read-Write-Allocate",

The ARMv7 ARM gives details about how the PRRR and NMRR are decoded,
giving pseudocode (see B3.19 for ConvertAttrsHints(), and B3.19.9 for
the TEX remap decode pseudocode.)

The PRRR and NMRR settings give write-back cache policy with a read-
allocate _hint_.  The key thing here is that it's a _hint_, it doesn't
mandate what the hardware does.  Different CPUs are free to use the
hints in different ways.

What this means is that while one CPU may interpret a "read-allocate"
hint as meaning that it can allocate cache lines on read accesses,
another CPU may do something different - it may either decide to
augment that with "write-allocate" as well, or it may decide
"no-allocate" (which seems to be your case.)

There is no architected requirement here - it's implementation
dependent, and that implementation dependence makes it difficult to
deal with from a generic OS point of view.

What may be right for one CPU may not be correct for another CPU.  In
other words, we can't change this without risking causing regressions
for the CPUs that we know work.  For example, if we changed to write-
allocate mode (aka read-write-allocate), there could be some other a
CPU out there which decides to implement that as no-allocate.

However, if it's possible to identify your CPU uniquely, then it would
be possible to change it just for your CPU.  What is the CPU MIDR value?

> I tried change the value of TTB_FLAGS_UP to  the same as TTB_FLAGS_SMP
> in arch/arm/mm/proc-v7-2level.S.

You need to change PMD_FLAGS as well.  TTB determines the translation
table base register values, which are the attributes used by the page
table walker.  PMD determines what's used in the page tables themselves.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
