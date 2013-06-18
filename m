From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jun 2013 16:13:43 +0100
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <1371562002.5375.27.camel@linaro1.home>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
 <1371562002.5375.27.camel@linaro1.home>
Message-ID: <20130618151343.GA2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:26:42PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2013-06-10 at 16:07 +0100, Mark Rutland wrote:
> > When booting fewer cores than are physically present on a versatile
> > platform (e.g. when passing maxcpus=N on the command line), some
> > secondary cores may remain in the holding pen, which is marked __INIT.
> > Late in the boot process, the memory comprising the holding pen will be
> > released to the kernel for more general use, and may be overwritten with
> > arbitrary data, which can cause the held secondaries to start behaving
> > unpredictably. This can lead to all manner of odd behaviour from the
> > kernel.
> > 
> > Instead don't mark the section as __INIT. This means we can't reuse the
> > pen memory, but we won't get secondaries corrupting the rest of the
> > kernel.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> 
> This gives section mismatch warnings when compiling with
> vexpress_defconfig:
> 
>         WARNING: vmlinux.o(.text+0x14128): Section mismatch in reference from the variable pen to the function .cpuinit.text:secondary_startup()
>         The function pen() references
>         the function __cpuinit secondary_startup().
>         This is often because pen lacks a __cpuinit 
>         annotation or the annotation of secondary_startup is wrong.
>         
>         WARNING: vmlinux.o(.text+0x14130): Section mismatch in reference from the variable pen to the variable .cpuinit.data:pen_release
>         The function pen() references
>         the variable __cpuinitdata pen_release.
>         This is often because pen lacks a __cpuinitdata 
>         annotation or the annotation of pen_release is wrong.
> 
> wonder if this is opening up a small can of worms...?

With the death of __cpuinit and __CPUINIT, this becomes a non-issue.
Realistically, how many ARM platforms are built without CPU hotplug?
My guess is none what so ever, because CPU hotplug is needed for PM.
