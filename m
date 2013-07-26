From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Jul 2013 14:28:50 +0100
Subject: [PATCH RESEND v2] ARM: dt: Use the 'model' field for printing
 the hardware revision
In-Reply-To: <1374844784-2639-1-git-send-email-festevam@gmail.com>
References: <1374844784-2639-1-git-send-email-festevam@gmail.com>
Message-ID: <20130726132850.GM24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 10:19:44AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When booting a device tree kernel, we get the following output from 
> 'cat /proc/cpuinfo': 
> 
> $ cat /proc/cpuinfo 
> processor       : 0
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 531.66
> Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls 
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x2
> CPU part        : 0xc08
> CPU revision    : 5
> 
> Hardware        : Freescale i.MX51 (Device Tree Support)
> Revision        : 0000
> Serial          : 0000000000000000
> 
> The Hardware line does not really describe the hardware type, as it is reading
> the information from the dt 'machine' field.
> 
> In the dt case, read the 'model' field instead, so that we can have a better
> description output as follows:
> 
> Hardware        : Freescale i.MX51 Babbage Board
> 
> The hardware output string is unchanged for the non-dt kernel case.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

While I can see the advantage of preserving old ways to do things, that's
not always the best option.

If userspace wants to get at the DT information about a platform, we already
have ways that can happen already - we export the DT stuff so that kexec's
tools can get at it.

And... as the long term goal is to get rid of the individual machine_type
structures for DT, there's no point introducing the new "model" field in
that struct.

And no, you're not supposed to write to mdesc structures.  Thanks for
being the one to point out that they aren't const, I'll make them so now.
