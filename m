From: kim.phillips@freescale.com (Kim Phillips)
Date: Mon, 9 Jul 2012 19:45:14 -0500
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120709065116.GB11635@S2101-09.ap.freescale.net>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
 <20120706002254.GB20175@S2101-09.ap.freescale.net>
 <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
 <20120709065116.GB11635@S2101-09.ap.freescale.net>
Message-ID: <20120709194514.e6a854441fa69a54fadc296d@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jul 2012 14:51:18 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Fri, Jul 06, 2012 at 05:56:34PM -0500, Kim Phillips wrote:
> > but it doesn't function as it stands right now, at least on Power.
> > The compatible in the device tree's sec_mon node "fsl,sec-v4.0-mon"
> > and the driver's "fsl,sec-v4.0-mon-rtc-lp" don't match.  Here are
> > the device tree changes I used:
> > 
> > diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
> > index 7990e0d..14c933b 100644
> > --- a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
> > @@ -104,6 +104,14 @@ crypto: crypto at 300000 {
> >  
> >  sec_mon: sec_mon at 314000 {
> >         compatible = "fsl,sec-v4.2-mon", "fsl,sec-v4.0-mon";
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       ranges = <0 0x314000 0x1000>;
> >         reg = <0x314000 0x1000>;
> >         interrupts = <93 2 0 0>;
> > +
> > +       sec_mon_rtc_lp at 34 {
> > +               compatible = "fsl,sec-v4.2-mon-rtc-lp", "fsl,sec-v4.0-mon-rtc-lp";
> > +               reg = <0x34 0x58>;
> > +       };
> >  };
> > 
> Yes, the way that this dts is written as well as the examples in
> Documentation/devicetree/bindings/crypto/fsl-sec4.txt assume there
> is a sec_mon driver.  This driver will match "fsl,sec-v4.0-mon" and
> populate rtc-lp device probed by the rtc-snvs driver created by the
> patch.
> 
> While there is no such sec_mon driver right now.  I did a quick
> tweaking on imx6q.dtsi to have rtc-snvs probed without the need of
> sec_mon driver.

...

> > btw, I don't see any imx6q.dtsi changes.
> > 
> See below.
> 
> Either way, being a driver of SNVS LP RTC, rtc-snvs should just stand
> as it stands right now.  It should not care about how the device is
> populated, by DT core or by sec_mon driver.
> 
> Regards,
> Shawn
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 8c90cba..26c42da 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -455,8 +455,16 @@
>                         };
> 
>                         snvs at 020cc000 {
> -                               reg = <0x020cc000 0x4000>;
> -                               interrupts = <0 19 0x04 0 20 0x04>;
> +                               compatible = "fsl,sec-v4.0-mon", "simple-bus";

ah, "simple-bus" was the missing tweak.

I'm not sure if this is appropriate vs. having common arch code
publish SNVS devices; see e.g., the other fsl,* devices in
arch/powerpc/platforms/85xx/common.c:mpc85xx_common_ids[].

Either way, I'd like to get support without having to manually tweak
the device tree, i.e., the patch doesn't work as-is.

btw, testing on a p4080r2 produces a soft lockup:

root at p4080ds:~# modprobe rtc-snvs
snvs_rtc ffe314034.sec_mon_rtc_lp: rtc core: registered ffe314034.sec_mon_r as rtc1
root at p4080ds:~# hwclock -w -f /dev/rtc1 
BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:0:4]
Modules linked in: rtc_snvs nfsd exportfs
irq event stamp: 54
hardirqs last  enabled at (53): [<c04f90dc>] _raw_spin_unlock_irq+0x30/0x58
hardirqs last disabled at (54): [<c04f8808>] _raw_spin_lock_irq+0x24/0x70
softirqs last  enabled at (0): [<c001eff8>] copy_process+0x2f4/0xde4
softirqs last disabled at (0): [<  (null)>]   (null)
NIP: f10b80b4 LR: f10b8074 CTR: 00000003
REGS: ee071d70 TRAP: 0901   Not tainted  (3.5.0-rc5-00099-gd8715a7-dirty)
MSR: 00029002 <CE,EE,ME>  CR: 42042022  XER: 00000000
TASK = ee06f470[4] 'kworker/0:0' THREAD: ee070000 CPU: 0
GPR00: 00000000 ee071e20 ee06f470 c04f9058 00000001 f10b8074 00000000 00000002 
GPR08: 00000001 f10bc054 00000000 00000000 c04f901c 
NIP [f10b80b4] snvs_rtc_alarm_irq_enable+0xb4/0xf8 [rtc_snvs]
LR [f10b8074] snvs_rtc_alarm_irq_enable+0x74/0xf8 [rtc_snvs]
Call Trace:
[ee071e20] [f10b8074] snvs_rtc_alarm_irq_enable+0x74/0xf8 [rtc_snvs] (unreliable)
[ee071e40] [c038c118] rtc_timer_do_work+0x184/0x20c
[ee071f10] [c003fc4c] process_one_work+0x1d4/0x48c
[ee071f50] [c0040d4c] worker_thread+0x184/0x358
[ee071f90] [c0046458] kthread+0x84/0x88
[ee071ff0] [c000d434] kernel_thread+0x4c/0x68
Instruction dump:
7c0004ac 7d404c2c 0c0a0000 4c00012c 7c0004ac 7c004c2c 0c000000 4c00012c 
7f8a0000 409effdc 7c0004ac 7c004c2c <0c000000> 4c00012c 7c0004ac 7d604c2c 

I debugged it to the innermost loop of rtc_write_sync_lp(), where
count2 and count3 are always equal.  Should there be a timeout in
that loop?  Do you know if this is because the machine isn't
in trusted mode?  Any other hints appreciated.

Kim
