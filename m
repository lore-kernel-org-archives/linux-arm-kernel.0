From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jul 2013 10:19:52 +0100
Subject: [RFC PATCH V2 1/8] regulator: Introduce OMAP regulator to
 control PMIC over VC/VP
In-Reply-To: <51DC3487.2080503@ti.com>
References: <20130704154105.GD27646@sirena.org.uk>
 <20130705135507.GA17439@kahuna>
 <20130705140828.GA27646@sirena.org.uk> <51D6DD3A.1030002@ti.com>
 <20130705165235.GC27646@sirena.org.uk> <51D70356.30707@ti.com>
 <20130705174727.GF27646@sirena.org.uk> <51DAF55C.5040502@ti.com>
 <20130709152954.GF27646@sirena.org.uk> <51DC3487.2080503@ti.com>
Message-ID: <20130710091952.GF3179@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 11:04:23AM -0500, Nishanth Menon wrote:
> On 07/09/2013 10:29 AM, Mark Brown wrote:

> >This seems like something we should be able to cope with by for example
> >adding a bus for the custom PMIC interface or otherwise finding a way to

> I had considered introducing a custom bus for custom PMIC interface,
> but as you stated below, standard regulators will probably need some
> custom monkeying around.

We should just be able to use the platform bus here.

> >get to the data at runtime based on the compatible string.  This would
> >need some custom code in the regulators but would have the advantage of
> >keeping the data the same at least.  Hrm.

> Ofcourse,this will be to add custom set/get_voltage implementation
> using this "custom API" which we discussed was'nt that good an idea.

No, if the regulator isn't being interacted with directly then it
doesn't need to export any operations - just data.  The operations would
come from the magic SoC hardware that controls the regulator.  The code
in the drivers should be very small, if it isn't there's no point in
doing this.

> >>between PMICs? yep, twl4030 does 4mV/uSec, 6030 can do 6mV/uSec,
> >>TPS62361 can do 32mV/uSec, TWL6035/37 does 0.220mV/uSec

> >Those are ramp rates, they're not I2C I/O limits.  Ramp rates we already
> >know about.  I think what you're saying here is that this latency value
> >is actually about worst case ramp times?

> Arrgh.. my bad. I confused ramp time with I2C transfer timeout
> parameter. I know that I2C bus can be held[1] by PMIC as long as it
> is busy. Some custom ASIC can do some weird stuff I suppose. I dont
> seem to have clear data points in the sketchy TRMs for 6030/2 ,
> 6035, 5030, for these other than to state it is i2c specification
> compliant (/me grumbles). So, I just have emperical value which is a
> bit conservative and seem to work on the devices.

OK, no problem - like we said further up the thread I think adding
something to get the data
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130710/c6ebfb65/attachment-0001.sig>
