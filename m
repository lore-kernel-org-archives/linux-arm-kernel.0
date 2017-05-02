From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 May 2017 17:48:47 +0100
Subject: [PATCH 1/1] arm64: Always provide "model name" in /proc/cpuinfo
In-Reply-To: <15006378-af42-b029-f967-3f7230b64706@gmx.de>
References: <20170501223913.6894-1-xypron.glpk@gmx.de>
 <20170502110827.GA29224@e104818-lin.cambridge.arm.com>
 <15006378-af42-b029-f967-3f7230b64706@gmx.de>
Message-ID: <20170502164846.GD28132@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 06:28:40PM +0200, Heinrich Schuchardt wrote:
> On 05/02/2017 01:08 PM, Catalin Marinas wrote:
> > On Tue, May 02, 2017 at 12:39:13AM +0200, Heinrich Schuchardt wrote:
> >> There is no need to hide the model name in processes
> >> that are not PER_LINUX32.
> >>
> >> So let us always provide a model name that is easily readable.
> >>
> >> Fixes: e47b020a323d ("arm64: Provide "model name" in /proc/cpuinfo for PER_LINUX32 tasks")
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> ---
> >>  arch/arm64/kernel/cpuinfo.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >> index b3d5b3e8fbcb..9ad9ddcd2f19 100644
> >> --- a/arch/arm64/kernel/cpuinfo.c
> >> +++ b/arch/arm64/kernel/cpuinfo.c
> >> @@ -118,9 +118,8 @@ static int c_show(struct seq_file *m, void *v)
> >>  		 * "processor".  Give glibc what it expects.
> >>  		 */
> >>  		seq_printf(m, "processor\t: %d\n", i);
> >> -		if (compat)
> >> -			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
> >> -				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
> >> +		seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
> >> +			   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
> >>  
> >>  		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> >>  			   loops_per_jiffy / (500000UL/HZ),
> > 
> > Such patch seems to come up regularly:
> > 
> > https://patchwork.kernel.org/patch/9303311/
> > 
> > (and it usually gets rejected)
> > 
> Dear Catalin,
> 
> thank you for pointing me to the previous discussion. I understand that
> adding model name in the current form would not provide sufficient
> valuable information.
> 
> The real interesting thing in an ARM SOC is to see which CPU is A72,
> A57, A53 or whatever.

This information can be derived from the MIDR fields exposed in
/proc/cpuninfo

e.g.

CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x1
CPU part        : 0xd07
CPU revision    : 2

... is a Cortex-A57.

> This information is available from the device tree in the compatible
> property of the individual CPUs
> (/sys/firmware/devicetree/base/cpus/cpu@*/compatible), e.g.
> compatible =3D "arm,cortex-a53", "arm,armv8";
> 
> I guess this information is the closest to the model name property on
> other architectures that we can get.
> 
> Would exposing this information in /proc/cpuinfo as 'model name' make
> sense to you?

I would disagree with exposing this, as in practice it is wrong in some
DTs, and it's not avaialble on ACPI systems.

We already expose the information necessary to derive the name, given a
lookup table in userspace. We don't have sufficient information to build
this in the kernel in all cases, so I don't think that we should attempt
to do so.

Thanks,
Mark.
