From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 13 Jul 2011 18:46:24 +0400
Subject: [RFC/RFT 2/2] davinci: use generic memory mapped gpio for
	tnetv107x
In-Reply-To: <20110706220240.GF5371@ponder.secretlab.ca>
References: <cover.1309840042.git.nsekhar@ti.com>
	<6639b07562e3e6643dd07d5ed3907cb5158ce16b.1309840042.git.nsekhar@ti.com>
	<20110706220240.GF5371@ponder.secretlab.ca>
Message-ID: <20110713144624.GA7875@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Wed, Jul 06, 2011 at 04:02:40PM -0600, Grant Likely wrote:
[...]
> > +		{
> > +			.name	= "dat",
> > +			.start	= TNETV107X_GPIO_BASE + 0x4,
> > +			.end	= TNETV107X_GPIO_BASE + 0x4 + 0x4 - 1,
> > +		},
> > +		{
> > +			.name	= "set",
> > +			.start	= TNETV107X_GPIO_BASE + 0x10,
> > +			.end	= TNETV107X_GPIO_BASE + 0x10 + 0x4 - 1,
> > +		},
> > +		{
> > +			.name	= "dirin",
> > +			.start	= TNETV107X_GPIO_BASE + 0x1c,
> > +			.end	= TNETV107X_GPIO_BASE + 0x1c + 0x4 - 1,
> > +		},
> > +		{
> > +			.name	= "en",
> > +			.start	= TNETV107X_GPIO_BASE + 0x28,
> > +			.end	= TNETV107X_GPIO_BASE + 0x28 + 0x4 - 1,
> > +		},
> > +	},
> > +};
> 
> Wow, this ends up looking horrible. (yes, I know it is not your
> fault).  I backed off earlier on using resources for the offsets, but
> I want to change my mind again and make interface a register range +
> offsets to the control registers.

Why is this horrible? Are you proposing a single resource + platform
data for the offsets? If so, this won't look any better, but in return

- this would complicate device registration logic and driver logic
  itself (i.e. we need to allocate platform data in the arch code,
  then parse and store the structure in the driver). The platform
  data is simply unnecessary -- we have resources that describe
  memory just fine, much better then raw 'unsigned long offset';

- we lose the ability to operate on spread registers (think of
  "enable" register is down below 2MB gap, near the pinmux
  registers block);

- In the device tree, we really want to describe registers in the
  regs = <> property, because that's where memory resources should
  be. (We also want to map address position into resource name, but
  that's different story).

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
