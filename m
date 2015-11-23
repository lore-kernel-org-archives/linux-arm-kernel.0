From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 13:04:24 +0000
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <56530AE6.2060407@dev.rtsoft.ru>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
 <5653099A.7020604@dev.rtsoft.ru> <56530AE6.2060407@dev.rtsoft.ru>
Message-ID: <20151123130424.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 03:47:34PM +0300, Nikita Yushchenko wrote:
> >>>>> While running an imx6s boasrd, I got following message in boot log:
> >>>>>
> >>>>> [    0.032414] CPU1: failed to boot: -38
> >>>>>
> >>>>> This looked strange: imx6s is singe-core and kernel perfectly knows
> >>>>> that. However, for some reason it tries to initialize CPU 1?
> >>>>>
> >>>>> I found this to be caused by
> >>>>> - CONFIG_SMP_ON_UP successfully detects that system is single core,
> >>>>> - this causes is_smp() to return false,
> >>>>> - this causes setup_arch() to skip smp_init_cpus() call,
> >>>>> - this skips board-specific code that sets cpu_possible mask.
> >>>>
> >>>> Right, so you should end up with the possible and present masks
> >>>> containing just one CPU, which should prevent the kernel trying to
> >>>> bring any secondary CPUs online.
> >>>
> >>> Kernel that is running here still tries to init CPU 1 for some reason.
> >>
> >> I *guess* cpus node [1] in your dts has more than one cpu entry, could
> >> you check please?
> > 
> > Indeed looks so:
> > 
> > # ls /proc/device-tree/cpus
> > #address-cells  #size-cells  cpu at 0  cpu at 1  name
> > 
> > But my custom device tree just includes imx6dl.dtsi
> > 
> > So it is imx6dl.dtsi in linux-imx tree broken?..
> 
> Just booted mainline...  unline linux-imx, it does not try to init cpu1.
> 
> However, imx6dl.dtsi from mainline also has both cpu at 0 and cpu at 1
> 
> So missing piece in linux-imx is elsewhere :(

It works as you mentioned - and it relies upon the code you tried to
modify.

The early boot code detects that the boot CPU is not SMP capable, so
through SMP_ON_UP, it "turns off" SMP support by fixing up the code
and making is_smp() return false.

This prevents smp_init_cpus() being called, which in turn prevents
imx_smp_init_cpus() executing, which prevents the CPU possible mask
including any CPU but the boot CPU.

As only the boot CPU is possible, this prevents the SMP code trying
to bring any secondary CPUs online.

Applying your patch which removes the is_smp() check will break this
logic.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
