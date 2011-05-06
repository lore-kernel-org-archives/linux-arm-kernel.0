From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 6 May 2011 17:13:25 +0900
Subject: Common clock and dvfs
In-Reply-To: <4DC311C6.7090707@ti.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<4DC311C6.7090707@ti.com>
Message-ID: <BANLkTikSFpNm55F66_DkabNTX8Yfh37NxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2011 at 6:08 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
[]
>
> Devices will indeed never care about voltage directly, but that will happen
> indirectly because of:
> - voltage domains dependency: Changing the MPU or IVA voltage domain might
> force the CORE voltage to increase its voltage due to HW limitation. We
> cannot have the CPU at 1GHz while the interconnect is at the lowest OPP.
> - voltage domain increase due to one device frequency increase might force
> the other voltage domain devices to increase their frequency.
> - Thermal management might be a good example as well, but in general
> changing the main contributors frequency (MPU, GPU) should be enough.
>
> In both cases, the indirect voltage change will trigger potentially
> frequency change.
>
> vdd1 <--> vdd2
> ?| ? ? ? ? |
> ?+----+ ? ?+----+
> ?| ? ?| ? ?| ? ?|
> devA devB devC devD
>
> With such partitioning, an increase of devA OPP, will increase vdd1 that
> will trigger an increase of vdd2 that will then broadcast to devices that
> belong to it. devC and devD might or not increase their frequency to reduce
> the energy consumption.
> Any devices like processors that can run fast and idle must run at the max
> frequency allowed by the current voltage.

As long as the voltage change in vdd1, which changes vdd2 (vdd1 and 2
are consumers of the same regulator, right?), can update OPP entries
related (enable/disable entries), devfreq can handle this.

If the clocks and devices (A~D) related are using devfreq, disabling,
enabling, and adding OPPs will instantly affect devfreq and adjust
clock frequency based on the enabled OPP entries only. Thus, if a
module is increasing the voltage, it just needs to disable some
low-voltage OPP entries although some set_min/max APIs mentioned by
Colin will be more useful.


-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
