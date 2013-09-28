From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 28 Sep 2013 21:15:11 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <201309272344.01386.arnd@arndb.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309172245.25367.arnd@arndb.de>
 <20130926094251.GK16106@pengutronix.de>
 <201309272344.01386.arnd@arndb.de>
Message-ID: <20130928191511.GA2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 27, 2013 at 11:44:01PM +0200, Arnd Bergmann wrote:
> On Thursday 26 September 2013, Uwe Kleine-K?nig wrote:
> > I made that work now and can prepare a patch. I had to drop "depends on
> > !ARCH_MULTIPLATFORM" from XIP_KERNEL. That's because my machine only
> > works with XIP_KERNEL as it only has 4 MiB of RAM.
> 
> Ok, cool. We might run into a few problems with 'make randconfig' and
> 'make allyesconfig' when it becomes possible to enable XIP_KERNEL then.
> IIRC, there is no fundamental reason to disallow XIP_KERNEL with
> ARCH_MULTIPLATFORM, but I added the dependency because it causes
> build errors in combination with other options.
ah, OK. Do you have an idea to fix both?
 
> A few questions from my side, out of curiosity:
> 
> * Do you need any other patches (unrelated to EFM32) to run NOMMU on a
> recent kernel? When I last tried, I could not get any NOMMU build to work
> at all.
no, there isn't much needed on top of current mainline. My current wip is at

	git://git.pengutronix.de/git/ukl/linux.git efm32

I don't even rely on all the HACK-patches that are included there. (The
multi-arch stuff isn't there yet.)
 
> * Do you think 4MB is now a strict lower bound for running a modern
> kernel? It would be a good data point if we could show that any target
> with less than that is by definition broken and could get removed
> from the kernel. What is the size of your kernel and user space?
$ objdump -p vmlinux

vmlinux:     file format elf32-littlearm

Program Header:
    LOAD off    0x00000000 vaddr 0x88020000 paddr 0x88020000 align 2**15
         filesz 0x00000094 memsz 0x0000a9f4 flags rw-
    LOAD off    0x00008000 vaddr 0x8c000000 paddr 0x8c000000 align 2**15
         filesz 0x001679b0 memsz 0x001679b0 flags rwx
    LOAD off    0x00170000 vaddr 0x88008000 paddr 0x8c1679b0 align 2**15
         filesz 0x00018d2c memsz 0x00018d2c flags rw-
private flags = 5000002: [Version5 EABI] [has entry point]

my rootfs (busybox, no init) is 153600 bytes big.

After booting I get:

	/ # free
		     total         used         free       shared      buffers
	Mem:          3892         1428         2464            0            0
	-/+ buffers:               1428         2464

but it doesn't run anything but a busybox shell ATM. Assuming the next
smaller configuration is 2 MiB of RAM I'd say that machine can maybe
boot, but cannot do anything sensible after that.

> * What user space are you running? Anything that's easy to build
> for testing? Should that run with a mach-virt kernel built for
> ARMv7-A NOMMU?
There is a BSP publically available at

	http://git-public.pengutronix.de/?p=OSELAS.BSP-EnergyMicro-Gecko.git;a=summary

which also includes a README file. For troubleshooting /join #efm32 on
freenode.
 
> * An ARMv7-M kernel cannot run on either ARMv4/v5 nor ARMv6/v7-A, right?
The entry convention is different (ARMv7-M doesn't support the ARM
instruction set but you need to jump into the kernel in ARM mode for
v4-v7). Other that that I don't know if there is a problem. Maybe
Jonathan can say anything here? Or alternatively if you want an efm32
devboard, just tell me.

> Do you prevent building such a kernel in Kconfig?
I'm sure my Kconfig magic isn't waterproof. It took me a few tries to
expand the multiarch architecture selection to make v7-m selectable at
all.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
