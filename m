From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Aug 2013 11:19:21 -0400 (EDT)
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <CALicx6uKhd0z=81G68VvTjBpPy=vwK3tgK8zk11dpu34N=YyYA@mail.gmail.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1308131851300.14472@syhkavp.arg>
 <CALicx6uKhd0z=81G68VvTjBpPy=vwK3tgK8zk11dpu34N=YyYA@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1308141026210.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Vijay Kilari wrote:

> On Wed, Aug 14, 2013 at 4:22 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 8 Aug 2013, Will Deacon wrote:
> >
> >> On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
> >> > Hi Will,
> >> >
> >> > I am trying to make kexec work on BE kernel on ARM VE TC2.
> >> >
> >> > First, to make KEXEC work with SMP on ARM VE TC2 board,
> >> > I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
> >>
> >> Interesting, is this with a mainline kernel? I don't see how SMP kexec can
> >> work on TC2 without additional patches to park the secondary cores safely.
> >
> > BTW those patches are available in linux-next at the moment.
> 
> Thanks for this info.
> I see that MCPM, TC2_PM & SPC configuration needs to be enabled to have
> TC2 power management. However MCPM also depends on CCI configuration
> to register smps ops.
> In my config, I dont have CCI config enabled

You do need CCI support in addition to all the above.  Managing CPUs on 
TC2 is serious business !

> Can you please suggest right configuration to be enabled and also dts 
> configuration for SPC, CCI to enable TC2 power mgmt.

You need the following pieces of firmware:

mbb_v311.ebf or later in MB/HBI0190D/ and proper reference to it in 
MB/HBI0190D/board.txt.

dbb_v110.ebf or later in SITE1/HBI0249A/. The file 
SITE1/HBI0249A/board.txt must have a proper reference to that file,
as well as the following values in the "[SCC REGISTERS]" section:

SCC: 0x700 0x0032F003

Most important here is to have bits 12 through 15 set to 1.

Those firmware files should be available on ARM's web site.

You also need to have the following sections in your device tree source 
file:

- SPC/SCC

  Depending on the flavor of the patch you have, this is either 
  spc at 7fff0000 or scc at 7fff0000.  You should look for either 
  vexpress-spc.txt or vexpress-scc.txt in 
  Documentation/devicetree/bindings/arm/ and use the example therein.

- CCI

  You need a CCI section as examplified in 
  Documentation/devicetree/bindings/arm/cci.txt.

> Also I am using u-boot. Do I need to use UEFI/firmware to enable TC2 power mgmt?

No.  I'm using U-Boot as well.

> I remember, some time back, I have tried linaro tracking git and
> failed to boot my board

This is most likely because of the above firmware settings and device 
tree requirements.


Nicolas
