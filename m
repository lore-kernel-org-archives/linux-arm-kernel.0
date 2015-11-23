From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 22:19:21 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151123203847.GB19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <105706554.vF12QZslMx@wuerfel> <20151123203847.GB19156@codeaurora.org>
Message-ID: <133921941.Qfq59EaTOs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 12:38:47 Stephen Boyd wrote:
> On 11/23, Arnd Bergmann wrote:
> > On Monday 23 November 2015 09:14:39 Christopher Covington wrote:
> > > On 11/23/2015 03:15 AM, Arnd Bergmann wrote:
> > > LPAE is only supported in the Krait 450.
> > > 
> > > http://www.anandtech.com/show/7537/qualcomms-snapdragon-805-25ghz-128bit-memory-interface-d3d11class-graphics-more
> > > 
> > > I'm pretty sure idiv support came earlier, but I don't have the
> > > specifics on hand.
> > 
> > I have seen that article, but didn't trust it as a canonical
> > source of information here.
> > 
> > If you can confirm that it's right, that would mean that we
> > don't support LPAE on mach-qcom, as the only SoC with Krait 450
> > seems to be APQ8084, and mainline Linux doesn't run on that.
> 
> arch/arm/boot/dts/qcom-apq8084.dtsi exists in the mainline
> kernel. We support more than what's in the Kconfig language
> under mach-qcom.

Ok, cool. I'm sometimes confused by the model numbers, could you
do a separate patch to update the Kconfig help text?

> And yes LPAE is supported by apq8084 (as is
> IDIV). Here's the /proc/cpuinfo on that device.
> # cat /proc/cpuinfo
> processor       : 0
> model name      : ARMv7 Processor rev 1 (v7l)
> BogoMIPS        : 38.40
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm

Ok.

> > The ones we do support are MSM8x60 (Scorpion), MSM8960
> > (Krait-without-number),and MSM7874 (Krait 400). Do those all
> > support IDIV but not LPAE?
> > 
> 
> Krait supports IDIV for all versions. Scorpion doesn't support
> IDIV or lpae. Here's the output of /proc/cpuinfo on that device. 
> 
> # cat /proc/cpuinfo
> processor       : 0
> model name      : ARMv7 Processor rev 2 (v7l)
> BogoMIPS        : 13.50
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
> CPU implementer : 0x51
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0x02d
> CPU revision    : 2

Ok, that leaves just one missing puzzle piece: can you confirm that
no supported Krait variant other than Krait 450 / apq8084 has LPAE?

	Arnd 
