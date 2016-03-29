From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2016 19:29:22 +0100
Subject: Bad mode in undefined instruction handler detected
In-Reply-To: <CAF_dkJA=4iqD=siV5RM7KTDfEQGtKc3G17E+C+K+-_hmneK4aA@mail.gmail.com>
References: <CAF_dkJBa3Y1EZGduZyjWqV3p5s7zf+Y4ppdeKW8anhd5nkjOPg@mail.gmail.com>
 <20160329165940.GA19428@n2100.arm.linux.org.uk>
 <CAF_dkJA=4iqD=siV5RM7KTDfEQGtKc3G17E+C+K+-_hmneK4aA@mail.gmail.com>
Message-ID: <20160329182922.GC19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 02:22:29PM -0400, Patrick Doyle wrote:
> Hmmm... inexplicably, compiling with frame pointers enabled doesn't
> seem to be an option for me :-(

Right, because the Kconfig system is setup to use a frame pointer
when the configuration options allow it, because not having it hurts
the ability to get sensible debugging from kernel crashes.

> with no option to set CONFIG_FRAME_POINTER in between.  Could that be
> because FRAME_POINTER looks like:
> 
> config FRAME_POINTER
>     bool
>     depends on !THUMB2_KERNEL
>     default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
>     help
>       If you say N here, the resulting kernel will be slightly smaller and
>       faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
>       when a problem occurs with the kernel, the information that is
>       reported is severely limited.
> 
> -- that is, not prompt for the "bool" option?  Is this an either/or
> choice for ARM_UNWIND vs FRAME_POINTER?

THUMB2_KERNEL is an option, which I believe you already have disabled.
So, the offending option is probably ARM_UNWIND.  You are provided with
the ARM_UNWIND option, and you need to say no to that.  Don't try to
build a kenrel with frame pointers and unwinding together - it'll
probably fail, or if you succeed in building it, it probably won't
work correctly since that's a combination we don't support.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
