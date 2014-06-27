From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 00:07:36 +0100
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627223328.GB17988@brightrain.aerifal.cx>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627223328.GB17988@brightrain.aerifal.cx>
Message-ID: <20140627230736.GX32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 06:33:28PM -0400, Rich Felker wrote:
> On Fri, Jun 27, 2014 at 11:17:44PM +0100, Russell King - ARM Linux wrote:
> > As I've already said, that's a system integrator bug to have a kernel
> > without a kuser page with userspace which requires it.
> > 
> > I think you're are missing one obvious solution to this which you can do:
> > you are passed the HWCAP fields in the ELF auxinfo.  This will tell you
> > if the CPU has TLS support or not.  If it has TLS support, then you don't
> > need to use the kuser helpers, and you know that it is a CPU which is ARM
> > architecture v6k or later,
> 
> Are you sure? I think the minimum models for TLS and for LDREX/STREX
> are different; one is plain v6 and the other is v6k.

LDREX/STREX is v6+.  TLS is v6k+.

> This greatly
> complicates the issue since the kernel only tells you if the TLS
> register is available, not if the atomics are.

uname() ?

> > If you want to know that the CPU supports the DMB
> > instruction rather than the CP15 barrier instruction, then you have to
> > check the uname details, or read /proc/cpuinfo (but I'd rather you
> > didn't.)
> 
> These are not safe operations. /proc may not be mounted, or the file
> descriptor table may be full and open may fail, etc.

Balderdash.  Since when has uname not been safe?

> > In addition, the HWCAP fields tell you about some of the other
> > instructions and FP options which are available to you, whether there's
> > integer division available, etc.
> 
> Yes but for all of those it's safe to assume the lowest baseline. For
> TLS and atomics, removal (even optional) of kuser helper page means
> it's not safe to assume the lowest baseline; there MUST be a fallback
> to use the higher-model-only instructions if the kernel lacks kuser
> helper.

The kuser helpers can NOT be removed unless the CPU is v6k+.  Let me
put that a different way: the kuser helpers can not be removed unless
the ELF HWCAPs indicate TLS support.

If the ELF HWCAPs indicate TLS support, then you have atomics and you
have TLS registers, and you may or may not have the kuser helpers.
If it indicates no TLS support, then you will always have kuser helpers.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
