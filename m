From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 19 Jun 2018 16:57:41 +0200
Subject: next/master boot: 138 boots: 8 failed,
 112 passed with 18 offline (next-20180619)
In-Reply-To: <20180619144143.GE11230@sirena.org.uk>
References: <5b290c6d.1c69fb81.fc936.98ee@mx.google.com>
 <69c0adb9-b784-4f73-fcc9-ff1a01ce27c5@arm.com>
 <20180619144143.GE11230@sirena.org.uk>
Message-ID: <7241956.9AMTTgrPoJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On Tue, Jun 19, 2018 at 07:00:13AM -0700, kernelci.org bot wrote:
> > 
> > Today and yesterday's -next is failing to boot on rk3399-firefly in two
> > 
> > configs:
> >>     defconfig:
> >>         rk3399-firefly:
> >>             lab-baylibre-seattle: failing since 1 day (last pass:
> >>             next-20180615 - first fail: next-20180618)>>     
> >>     defconfig+CONFIG_RANDOMIZE_BASE=y:
> >>         rk3399-firefly:
> >>             lab-baylibre-seattle: failing since 1 day (last pass:
> >>             next-20180615 - first fail: next-20180618)> 
> > The log ends with:
> > 
> > [    2.629278] SWITCH_REG2: supplied by vcc3v3_sys
> > [    2.633030] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1]
> > Detected! [    2.633723] fan53555-reg: supplied by vcc_sys
> > [    2.6353|] Internal error: undefined instruction: 0 [#1] PREEMPT SMP
> > 
> > which is rather entertaining.

> Am Dienstag, 19. Juni 2018, 16:41:43 CEST schrieb Mark Brown:
> On Tue, Jun 19, 2018 at 03:22:47PM +0100, Sudeep Holla wrote:
> > Based on the logs from successful boots, I see it's CPUFreq that gets
> > probed after fan53555-reg. I also see that it warns about unlisted OPPs
> > in the successful boots. I guess, the undefined instruction could occur
> > if there's issue with CPU DVFS(under voltage or frequency that's not
> > supported). I don't have much knowledge on the platform, I am just
> > guessing on the possible cause here.
> 
> Yeah, that was my guess - either an out of spec voltage/frequency was
> selected or the regulator isn't able to keep up with the voltage
> transition or a load spike and the power browns out.

I guess this is related to
	arm64: dts: rockchip: correct voltage selector Firefly-RK3399 [0]

which is in so far interesting as the patch seems to fix a similar issue
to the above with the opposite "fcs,suspend-voltage-selector" value.
And also claims to be in line with the vendor kernel.

>From looking at the schematics, we might have a discrepancy between the
fcs,suspend-voltage-selector and vsel input-pin leading to a gpio
[likely depending on what the bootloader set this pin up for].

I'll drop the patch for now and get in contact with the patch submitter.


Heiko

[0] https://patchwork.kernel.org/patch/10447075/
