From: ccross@google.com (Colin Cross)
Date: Fri, 22 Apr 2011 12:48:37 -0700
Subject: Common clock and dvfs
In-Reply-To: <20110422194027.GB4768@sirena.org.uk>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
	<20110422194027.GB4768@sirena.org.uk>
Message-ID: <BANLkTin9mbGKAMB4Bgd=5th+6FgS9gMCtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 12:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Apr 22, 2011 at 11:15:34AM -0700, Colin Cross wrote:
>
>> Now that we are approaching a common clock management implementation,
>> I was thinking it might be the right place to put a common dvfs
>> implementation as well.
>
> I looked at this a bit when doing the S3C64xx stuff.
>
>> frequency changes the clock first, and then calls dvfs_set_rate. ?For
>> a generic implementation, an SoC would provide the clock/dvfs
>> framework with a list of clocks, the voltages required for each
>> frequency step on the clock, and the regulator name to change. ?The
>> frequency/voltage tables are similar to OPP, except that OPP gets
>> voltages for a device instead of a clock. ?In a few odd cases (Tegra
>
> This sounds like it assumes a 1:1 mapping between clocks and supplies
> which is going to break at some point. ?It should be handlable but will
> add complexity.
>

Almost every platform requires a many-to-one mapping between clocks
and supplies (many clocks fed off one supply), and I bet at least one
platform has one clock that requires changing two supplies, so a
many-to-many mapping is probably required.  It's not hard, I
implemented it for Tegra before moving to a many-to-one - each
relationship between a clock and a supply can be treated
independently, so the pointers in the clock and dvfs structs can just
be converted to lists of an intermediate struct.
