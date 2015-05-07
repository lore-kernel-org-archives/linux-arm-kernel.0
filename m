From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 7 May 2015 19:55:18 +0800
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <20150507112536.GD22115@arm.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <20150507090210.GB22115@arm.com> <554B305F.4080907@huawei.com>
 <20150507112536.GD22115@arm.com>
Message-ID: <20150507115518.GA15622@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 12:25:38PM +0100, Will Deacon wrote:
> On Thu, May 07, 2015 at 10:29:03AM +0100, Bintian wrote:
> > On 2015/5/7 17:02, Will Deacon wrote:
> > > On Tue, May 05, 2015 at 01:06:34PM +0100, Bintian Wang wrote:

[...]

> > > The bad news is that running hackbench quickly got the *heatsink*
> > > temperature to 73 degress C and rising (measured with an infrared
> > > thermometer).
> > This patch set is just for booting the small system, if you want to
> > test the temperature, I think you should using the HiKey released
> > version (https://www.96boards.org/).
> 
> I'm not really interested in the temperature numbers, but I am interested
> in the board not melting and potentially setting fire to my desk.

All cpus will be initialized w/t 800MHz, suppose the dynamic leakage is high;
w/t Bintian's patches, suppose the cpuidle also has not been enabled;
so there also have static leakage even cpus run into "wfi" state.

I also have not exactly power data for SoC, but suppose the leakage is
high.

> > This patch is just for the small system, and not include those drivers
> > for adjusting the CPU frequency, thermal control and so on. After this
> > patch is merged, all those drivers will be submitted later.
> 
> Should those drivers *really* exist only in the kernel? What happens if
> the kernel panics for some other reason? You'll basically have 8 spinning
> cores and no sensible way to handle the thermal interrupt.
> 
> Shouldn't there be something in the secure firmware as a last resort?

We are integrate Hisilicon's MCU firmware, which is the similiar
module w/t Juno's SCP. It will support mainly two functionality:

- CPU Frequency Scaling;

  CPUFreq driver has been merged yet. [2]

  For CPU frequency scaling part, Due MCU FW has some updating from
  hisilicon, so we need re-work cpu clock driver. [1]

- CPUIdle and system's low power state;

  This part need integrate ARM-TF w/t MCU FW to support PSCI;

> > > So my question is, does this SoC have an automatic thermal cut out? Whilst
> > > I'm all for merging enabling code into the kernel, if it really relies on
> > > the kernel to stop it from catching fire, maybe it's not a great idea
> > > putting these patches into people's hands just yet.
> > Hikey is a low cost board, I think it doesn't have an automatic thermal
> > cut out; I always use HiKey to test my patch, in the normal case, 
> > temperature is not a problem.
> 
> I don't see why the cost has anything to do with this issue; any money I
> save on the board will quickly be re-invested in my increased insurance
> premium.
> 
> All I think we need is for secure software to keep an eye on the temperature
> and hit the power controller if it goes over some `fatal' threshold.
> Ideally, you'd be able to use a secure interrupt for this, but I suspect
> that you don't have the right hardware features for that (please correct me
> if I'm wrong). An alternative would be to hang something off a secure timer
> and get the firmware to check the board temperature on some low-frequency
> periodic tick.

Now we are using thermal framework to monitor thermal and if
temperature hit the trip point it will take cpu as cooling device and
set limitation for cpu's max frequency. [3]

[1] http://archive.arm.linux.org.uk/lurker/message/20150326.111335.0d484b89.en.html
[2] http://archive.arm.linux.org.uk/lurker/message/20150330.052637.16e0f3f4.en.html
[3] http://archive.arm.linux.org.uk/lurker/message/20150424.035121.80e0e24b.en.html

Thanks,
Leo Yan
