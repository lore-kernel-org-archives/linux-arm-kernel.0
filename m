From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 25 Mar 2014 14:54:44 +0000
Subject: [PATCH 3/3] ARM: kprobes: Fix test code compilation errors for
 ARMv4 targets
In-Reply-To: <6485768.fvJS4nr3cP@wuerfel>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-4-git-send-email-tixy@linaro.org>
 <53318441.1060306@linaro.org> <6485768.fvJS4nr3cP@wuerfel>
Message-ID: <1395759284.3478.88.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-25 at 14:42 +0100, Arnd Bergmann wrote:
> On Tuesday 25 March 2014 09:27:29 David Long wrote:
> > On 03/11/14 12:54, Jon Medhurst wrote:
> > > Conditionally compile kprobes test cases for ARMv5 instructions to avoid
> > > compilation errors with ARMv4 targets like:
> > >
> > > /tmp/cc7Tx8ST.s:16740: Error: selected processor does not support ARM mode `clz r0,r0'
> > >
> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > 
> > This looks OK to me.  Feel free to add my ack.
> 
> Ah, I had a similar patch in my 'randconfig-fixes' series.

Where's that?

>  I noticed three
> other configurations that are broken with kprobes-test:
> 
> - ARMv3 (enabled by ARCH_RPC)

Didn't know we support < ARMv4!

> - ARMv7-M (enabled by ARCH_EFM32)

I guess that problem is because randconfig is enabling HAVE_KPROBES,
even though it wouldn't normally be selected, because we have

   config ARCH_ARM
	select HAVE_KPROBES if !XIP_KERNEL

and ARCH_EFM32 is XIP_KERNEL.

I think this problem goes all the way back to the commit which added
HAVE_KPROBES to all arches (3f550096dede4430f83b16457da83bf429155ac2)
That replaced 

   config KPROBES
	depends on ... (ARM && !XIP_KERNEL)

with the current select if !XIP_KERNEL, which made it possible to enable
kprobes for XIP when before we couldn't. And presumably that was for a
good reason like it doesn't work on XIP?

Not sure at the moment how best to fix that. (Making ARM_KPROBES_TEST
depend on !XIP_KERNEL doesn't solve the underlying problem of KPROBES
feature still being enabled for XIP kernels.)

> - CPU_ENDIAN_BE32 (enabled by building a big-endian kernel on ARMv5 or older)

> Should we treat those the same way, or just disable Kprobes for this case
> if nobody cares?

For CPU_ENDIAN_BE32 I have a feeling that the kprobes code wouldn't
work, would have to think more about why I have that feeling. If it
doesn't, we come back to the problem that arch code can't add
dependencies to CONFIG_KPROBES as things stand.

-- 
Tixy
