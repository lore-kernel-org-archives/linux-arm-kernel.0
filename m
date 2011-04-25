From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 25 Apr 2011 02:33:22 -0600 (MDT)
Subject: Common clock and dvfs
In-Reply-To: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1104250211000.6742@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cc Tony, Beno?t)

Hi,

By way of brief introduction, I'm currently the maintainer of the OMAP 
clock code and data, as well as some other low-level OMAP kernel pieces.

On Fri, 22 Apr 2011, Colin Cross wrote:

> The Tegra way is to put everything dvfs related under the clock
> framework.  Enabling (or preparing, in the new clock world) or raising
> the frequency calls dvfs_set_rate before touching the clock, which
> looks up the required voltage on a voltage rail, aggregates it with
> the other voltage requests, and passes the minimum voltage required to
> the regulator api.  Disabling or unpreparing, or lowering the
> frequency changes the clock first, and then calls dvfs_set_rate.  For
> a generic implementation, an SoC would provide the clock/dvfs
> framework with a list of clocks, the voltages required for each
> frequency step on the clock, and the regulator name to change.  The
> frequency/voltage tables are similar to OPP, except that OPP gets
> voltages for a device instead of a clock.  In a few odd cases (Tegra
> always has a few odd cases), a clock that is internal to a device and
> not exposed to the clock framework (pclk output on the display, for
> example) has a voltage requirement, which requires some devices to
> manually call dvfs_set_rate directly, but with a common clock
> framework it would probably be possible for the display driver to
> export pclk as a real clock.
> 
> The proposed OMAP4 way (I believe, correct me if I am wrong) is to
> create a new api outside the clock api that calls into both the clock
> api and the regulator api in the correct order for each operation,
> using OPP to determine the voltage.

Some people may have proposed this approach, but that's definitely not my 
perspective.  I don't think it's a good design, and have so far declined 
to merge any DVFS code that doesn't use clk_set_rate() as its interface 
(from the device driver's perspective), at least until the proponents of 
the separate-API camp can explain why it's needed.

> This has a few disadvantages (obviously, I am biased, having written 
> the Tegra code) - clocks and voltages are tied to a device, which is not 
> always the case for platforms outside of OMAP,

It's not the case for OMAP either.

> and drivers must know if their hardware requires voltage scaling.  The 
> clock api becomes unsafe to use on any device that requires dvfs, as it 
> could change the frequency higher than the supported voltage.
> 
> Is the clock api the right place to do dvfs, or should the clock api
> be kept simple, and more complicated operations like dvfs be kept
> outside?

My personal opinion is that the clock framework is the right place for 
this, since it's a defined interface that is already exposed to drivers.

However, since the current clock interface doesn't anticipate that some 
code (e.g. CPUFreq) may need to change a clock's rate while some other 
code (e.g. a device driver) is currently using that clock, the clock 
interface will need to be expanded somewhat to handle this safely.  Clock 
notifiers are needed, plus the ability for clock users to indicate when it 
is safe for an in-use clock's rate/parent to change.

I'd been planning to post patches for that stuff for 2.6.40 until all of 
the recent drama started.  I guess I should post them anyway...


- Paul
