From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 05 Dec 2011 20:45:47 +0100
Subject: [PATCH 2/2] [CPUFREQ] s3c64xx: Add VDDINT voltage scaling
In-Reply-To: <20111205192506.GE7467@opensource.wolfsonmicro.com>
References: <1323109322-24130-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <11611639.9NBo3p2F8o@flatron>
 <20111205192506.GE7467@opensource.wolfsonmicro.com>
Message-ID: <1968469.lEDYUZcgoo@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 of December 2011 19:25:06 Mark Brown wrote:
> On Mon, Dec 05, 2011 at 08:11:03PM +0100, Tomasz Figa wrote:
> > On Monday 05 of December 2011 18:57:58 Mark Brown wrote:
> > > > (min 1.15, max 1.3) for HCLK at 133 MHz and 1.05V (min 0.95,
> > > > max 1.3) for HCLK running at 66 MHz.
> > > 
> > > I've certainly got documentation that contradicts this, and for
> > > some
> > > reason synchronous clocks seem to require a higher VDDINT supply
> > > which baffles me rather.
> > 
> > I'm basing my statements on S3C6410 power design guide and source
> > code of original kernel for Samsung Galaxy GT-i5700 released by
> > Samsung on their open source portal.
> 
> So, if you look at the power design guide (or at least the version I
> have) that doesn't quite match that - for example, the recommended
> operating conditions section quotes 133MHz as 1.2V typical for async
> operation and 1.3V typical for sync operation.  There's also some
> examples in the power guide showing periods of operation with HCLK at
> 133MHz and VDDINT at 1.05V.  And driver code showing some variation from
> the power design guide :/

I think that people from Samsung should be able to say something a bit more 
precise on this. Am I right?

> > > > Anyway, the behavior will probably vary from board to board,
> > > > so I
> > > > would rather think about extending s3c64xx-cpufreq driver to
> > > > allow
> > > > per board frequency/voltage configuration., which would also
> > > > include settings optimized for your boards in their
> > > > board-specific code.> > 
> > > That seems quite tasteless frankly - the behaviour of the silicon
> > > is
> > > not board specific, and we do already have a facility in the
> > > regulator API to compensate for voltage drops in the board if
> > > that's an issue. Anything beyond that is policy and is in the
> > > domain of the governors.> 
> > Well, you are mostly right, but there is one aspect that varies
> > between boards, configuration. Boards can have different PLL
> > settings, run in synchronous or asynchronous mode and might have
> > power regulators of different qualities which will vary in voltage
> > ripple.
> 
> The regulators we should be able to take care of through the framework;
> it's a moderately common issue on brass board designs due to the
> physically larger form factors.  The PLL settings we'd ideally be able
> to change at runtime (especially the ARM one which would give us a lot
> more flexibility) and at worst should be able to figure out what to do
> with based on readback.

OK.

> > For example, in case of your boards, the regulator is nice and allow
> > reduction of VDDint voltage to minimal value (1.15V), but in general
> > Power Design Guide it is recommended to use the typical value
> > (1.25V).
> If it's a question of regulator quality the board should just be adding
> an offset in the constraints without the SoC drivers having to worry
> their pretty little heads about it.  Like I say it's not an unknown
> problem.  Often it's not actually the regulator but rather the board
> design that causes the issue, for example if you've got very long traces
> from the regulator to the device then you may experience voltage drops
> or other effects which impair the accuracy of the supply seen by the
> device.

Right, there is a field for regulator offset in regulation_constraints 
struct indeed. Somehow I missed it, sorry.

> > As far as I know, there are also different revisions of S3C6410,
> > capable of running at different maximal frequencies, at least 667
> > MHz and 800 MHz versions.
> 
> Yes, there are - I've got boards with both variants.  At the minute
> we're managing to cope with them by virtue of the different PLL settings
> constraining the frequencies we can set, if we ever get control of the
> ARM PLL the drivers will need to get a bit smarter.

OK.

> > > > This would also solve a major problem of current
> > > > s3c64xx-cpufreq
> > > > implementation, namely crashing boards running in synchronous
> > > > mode, because of odd frequencies specified, like 200 MHz
> > > > (achievable with PLL set to 800 MHz), while the requirement
> > > > is to keep the ARM frequency a multiple of HCLK when running
> > > > synchronously.
> > > 
> > > The clock code should just be adjusted to refuse to set invalid
> > > ARM
> > > clock ratios.
> > 
> > This might be some solution as well. I'm not yet sure if it solves
> > all the problems, but I will think about it.
> 
> It'd at least stop the system falling over in a big fat heap which seems
> like an improvement :)

OK. :)

The problem with voltages would be solved by offset given in constraints 
and the problem of incorrect frequencies should be fixable in s3c64xx-
cpufreq, so no more problems left. I think.
