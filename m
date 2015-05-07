From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 May 2015 12:25:38 +0100
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <554B305F.4080907@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <20150507090210.GB22115@arm.com> <554B305F.4080907@huawei.com>
Message-ID: <20150507112536.GD22115@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 10:29:03AM +0100, Bintian wrote:
> On 2015/5/7 17:02, Will Deacon wrote:
> > On Tue, May 05, 2015 at 01:06:34PM +0100, Bintian Wang wrote:
> >> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> >> initial support for Hi6220 SoC and HiKey development board, which
> >> supports octal ARM Cortex A53 cores. Initial support is minimal and
> >> includes just the arch configuration, clock driver, device tree
> >> configuration.
> >>
> >> PSCI is enabled in device tree and there is no problem to boot all the
> >> octal cores, and the CPU hotplug is also working now, you can download
> >> and compile the latest firmware based on the following link to run this
> >> patch set:
> >> https://github.com/96boards/documentation/wiki/UEFI
> >>
> >> Changes v4:
> >> * Rebase to kernel 4.1-rc1
> >> * Delete "arm,cortex-a15-gic" from the gic node in dts
> >
> > I gave these patches a go on top of -rc2 using the ATF and UEFI you link to
> > above.
> >
> > The good news is that the thing booted and all the cores entered at EL2.
> > Thanks!
> Really thank you very much for testing this patch set.

Feel free to add my tested-by if you like.

> > The bad news is that running hackbench quickly got the *heatsink*
> > temperature to 73 degress C and rising (measured with an infrared
> > thermometer).
> This patch set is just for booting the small system, if you want to
> test the temperature, I think you should using the HiKey released
> version (https://www.96boards.org/).

I'm not really interested in the temperature numbers, but I am interested
in the board not melting and potentially setting fire to my desk.

> This patch is just for the small system, and not include those drivers
> for adjusting the CPU frequency, thermal control and so on. After this
> patch is merged, all those drivers will be submitted later.

Should those drivers *really* exist only in the kernel? What happens if
the kernel panics for some other reason? You'll basically have 8 spinning
cores and no sensible way to handle the thermal interrupt.

Shouldn't there be something in the secure firmware as a last resort?

> > So my question is, does this SoC have an automatic thermal cut out? Whilst
> > I'm all for merging enabling code into the kernel, if it really relies on
> > the kernel to stop it from catching fire, maybe it's not a great idea
> > putting these patches into people's hands just yet.
> Hikey is a low cost board, I think it doesn't have an automatic thermal
> cut out; I always use HiKey to test my patch, in the normal case, 
> temperature is not a problem.

I don't see why the cost has anything to do with this issue; any money I
save on the board will quickly be re-invested in my increased insurance
premium.

All I think we need is for secure software to keep an eye on the temperature
and hit the power controller if it goes over some `fatal' threshold.
Ideally, you'd be able to use a secure interrupt for this, but I suspect
that you don't have the right hardware features for that (please correct me
if I'm wrong). An alternative would be to hang something off a secure timer
and get the firmware to check the board temperature on some low-frequency
periodic tick.

Will
