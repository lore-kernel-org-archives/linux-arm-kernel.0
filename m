From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 12:38:47 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <105706554.vF12QZslMx@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <8472808.1HUuK2O5nn@wuerfel> <56531F4F.9010100@codeaurora.org>
 <105706554.vF12QZslMx@wuerfel>
Message-ID: <20151123203847.GB19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Arnd Bergmann wrote:
> On Monday 23 November 2015 09:14:39 Christopher Covington wrote:
> > On 11/23/2015 03:15 AM, Arnd Bergmann wrote:
> > > On Sunday 22 November 2015 21:36:45 Nicolas Pitre wrote:
> > >> On Sun, 22 Nov 2015, Arnd Bergmann wrote:
> > > 
> > > Ok, thanks a lot! So the reporting in /proc/cpuinfo clearly matches
> > > the actual features, and we can just treat this as no LPAE / no IDIV
> > > for kernel compilation, as nobody ever seems to use THUMB2_KERNEL
> > > in practice.
> > > 
> > > PJ4-MP is like Cortex-A15/A7/A12/A17 and supports both IDIV and LPAE,
> > > which leaves the question whether Scorpion or Krait do the same as
> > > well, or whether they are outliers and need a special configuration.
> > 
> > LPAE is only supported in the Krait 450.
> > 
> > http://www.anandtech.com/show/7537/qualcomms-snapdragon-805-25ghz-128bit-memory-interface-d3d11class-graphics-more
> > 
> > I'm pretty sure idiv support came earlier, but I don't have the
> > specifics on hand.
> 
> I have seen that article, but didn't trust it as a canonical
> source of information here.
> 
> If you can confirm that it's right, that would mean that we
> don't support LPAE on mach-qcom, as the only SoC with Krait 450
> seems to be APQ8084, and mainline Linux doesn't run on that.

arch/arm/boot/dts/qcom-apq8084.dtsi exists in the mainline
kernel. We support more than what's in the Kconfig language
under mach-qcom. And yes LPAE is supported by apq8084 (as is
IDIV). Here's the /proc/cpuinfo on that device.

# cat /proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0x06f
CPU revision    : 1

processor       : 1
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0x06f
CPU revision    : 1

processor       : 2
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0x06f
CPU revision    : 1

processor       : 3
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0x06f
CPU revision    : 1

Hardware        : Qualcomm (Flattened Device Tree)
Revision        : 0000
Serial          : 0000000000000000

> 
> The ones we do support are MSM8x60 (Scorpion), MSM8960
> (Krait-without-number),and MSM7874 (Krait 400). Do those all
> support IDIV but not LPAE?
> 

Krait supports IDIV for all versions. Scorpion doesn't support
IDIV or lpae. Here's the output of /proc/cpuinfo on that device. 

# cat /proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 13.50
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0x02d
CPU revision    : 2

processor       : 1
model name      : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 13.50
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer : 0x51
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0x02d
CPU revision    : 2

Hardware        : Qualcomm (Flattened Device Tree)
Revision        : 0000
Serial          : 0000000000000000

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
