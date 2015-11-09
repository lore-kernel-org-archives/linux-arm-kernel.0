From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 9 Nov 2015 19:40:57 +0100 (CET)
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <5669629.gUNGHpWjD7@wuerfel>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
 <6253831.r99BEBrMgd@wuerfel> <alpine.LNX.2.00.1511071112380.9964@T520.local>
 <5669629.gUNGHpWjD7@wuerfel>
Message-ID: <alpine.LNX.2.00.1511091859530.25338@T520.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sat, 7 Nov 2015, Arnd Bergmann wrote:

> On Saturday 07 November 2015 11:56:44 Hans Ulli Kroll wrote:
> > On Fri, 6 Nov 2015, Arnd Bergmann wrote:
> > > On Friday 06 November 2015 16:04:08 Catalin Marinas wrote:
> > > > On Fri, Nov 06, 2015 at 10:57:58AM +0100, Arnd Bergmann wrote:
> > > > > On Thursday 05 November 2015 18:27:18 Catalin Marinas wrote:
> > > > > > On Wed, Nov 04, 2015 at 02:55:01PM -0800, Linus Torvalds wrote:
> > > > > > > On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > > It's good for single-process loads - if you do a lot of big fortran
> > > > > > > jobs, or a lot of big database loads, and nothing else, you're fine.
> > > > > > 
> > > > > > These are some of the arguments from the server camp: specific
> > > > > > workloads.
> > > > > 
> > > > > I think (a little overgeneralized), you want 4KB pages for any file
> > > > > based mappings,
> > > > 
> > > > In general, yes, but if the main/only workload on your server is mapping
> > > > large db files, the memory usage cost may be amortised.
> > > 
> > > This will still only do you good for a database that is read into memory
> > > once and not written much, and at that point you can as well use hugepages.
> > > 
> > > The problems for using 64kb page cache on file mappings are
> > > 
> > > - while you normally want some readahead, the larger pages also result
> > >   in read-behind, so you have to actually transfer data from disk into
> > >   RAM without ever accessing it.
> > > 
> > > - When you write the data, you have to write the full 64K page because
> > >   that is the granularity of your dirty bit tracking.
> > > 
> > > So even if you don't care at all about memory consumption, you are
> > > still transferring several times more data to and from your drives.
> > > As mentioned that can be a win on some storage devices, but usually
> > > it's a loss.
> > > 
> > 
> > there is also a maybe a bigger problem.
> > I know this from my Zyxel NAS540, this thing is build around the Mindspeed 
> > Comcerto 2000 SoC
> > 
> > Zyxel is currently rolling back to support 4k page sizeses in upcommig 
> > 5.10 firmware release, because Minspeed did some stupid thing :
> > 
> > It's not possible to use some standard ARMv7 toolchain and build your 
> > own/needed userspace tools.
> > 
> > And this in change which causes the pain 
> > 
> > diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> > -#define ELF_EXEC_PAGESIZE      4096
> > +#define ELF_EXEC_PAGESIZE      (PAGE_SIZE)
> 
> In ARM32 binutils, ELF_MAXPAGESIZE was changed last year to 64KB, so
> binutils-2.25 or higher should support this by default, as long as you
> recompile all user binaries.
> 

Thanks for the hint ...

> > The SoC is mostly build from off the shelf IP's
> > SATA, NAND, SPI and so on
> > The only thing which is completly braindead is MAC
> > It's using some kind of VLAN tagging to support tree ports,
> > only one descriptor chain for all three interfaces.
> 
> You mean they used 64KB logical page sizes to work around a broken
> ethernet MAC?
> 
> 	Arnd
> 

No.
The MAC is some other issue :
I think the main purpose of this design to use this SoC for Deep 
Packet Inspection in HW.
They use also this MAC (or is't queue) for for en/decrypting traffic 
for the WIFI devices, in the sources it's called vwd.
-> virtual wirelss divice.

IP-Stack -> VWD -> WIFI-DEV

FYI, Here is the Datasheed (only 4 Pages)
http://downloads.codico.com/MISC/Newsletter/2013/2013_02/862xx-BRF-001-M_C2K.pdf

But this is to much, to wrap my head around.

Hans Ulli
