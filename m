From: ccross@google.com (Colin Cross)
Date: Fri, 22 Apr 2011 11:15:34 -0700
Subject: Common clock and dvfs
Message-ID: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we are approaching a common clock management implementation,
I was thinking it might be the right place to put a common dvfs
implementation as well.

It is very common for SoC manufacturers to provide a table of the
minimum voltage required on a voltage rail for a clock to run at a
given frequency.  There may be multiple clocks in a voltage rail that
each can specify their own minimum voltage, and one clock may affect
multiple voltage rails.  I have seen two ways to handle keeping the
clocks and voltages within spec:

The Tegra way is to put everything dvfs related under the clock
framework.  Enabling (or preparing, in the new clock world) or raising
the frequency calls dvfs_set_rate before touching the clock, which
looks up the required voltage on a voltage rail, aggregates it with
the other voltage requests, and passes the minimum voltage required to
the regulator api.  Disabling or unpreparing, or lowering the
frequency changes the clock first, and then calls dvfs_set_rate.  For
a generic implementation, an SoC would provide the clock/dvfs
framework with a list of clocks, the voltages required for each
frequency step on the clock, and the regulator name to change.  The
frequency/voltage tables are similar to OPP, except that OPP gets
voltages for a device instead of a clock.  In a few odd cases (Tegra
always has a few odd cases), a clock that is internal to a device and
not exposed to the clock framework (pclk output on the display, for
example) has a voltage requirement, which requires some devices to
manually call dvfs_set_rate directly, but with a common clock
framework it would probably be possible for the display driver to
export pclk as a real clock.

The proposed OMAP4 way (I believe, correct me if I am wrong) is to
create a new api outside the clock api that calls into both the clock
api and the regulator api in the correct order for each operation,
using OPP to determine the voltage.  This has a few disadvantages
(obviously, I am biased, having written the Tegra code) - clocks and
voltages are tied to a device, which is not always the case for
platforms outside of OMAP, and drivers must know if their hardware
requires voltage scaling.  The clock api becomes unsafe to use on any
device that requires dvfs, as it could change the frequency higher
than the supported voltage.

Is the clock api the right place to do dvfs, or should the clock api
be kept simple, and more complicated operations like dvfs be kept
outside?
