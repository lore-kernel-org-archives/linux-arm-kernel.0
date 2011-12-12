From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 12 Dec 2011 12:48:57 +0100
Subject: [V1] mfd: Convert pm860x to use regmap api
In-Reply-To: <CAN1soZwdJJQDk+4gss8PhoyOikzEtAx1jqHQzXCt3u30_6LRZg@mail.gmail.com>
References: <1320925406-7445-1-git-send-email-jtzhou@marvell.com>
 <20111110130225.GG21630@sirena.org.uk>
 <CAN1soZwdJJQDk+4gss8PhoyOikzEtAx1jqHQzXCt3u30_6LRZg@mail.gmail.com>
Message-ID: <20111212114857.GC13952@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 10:08:08AM +0800, Haojian Zhuang wrote:
> On Thu, Nov 10, 2011 at 9:02 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Nov 10, 2011 at 07:43:26PM +0800, Jett.Zhou wrote:
> >> Convert the register read/write code to use the register map API. We
> >> still need some pm860x specific code and locking in place to make sure
> >> test page read/write can not be interrupted by other i2c operation based
> >> on pm860x chip;
> >
> > Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >
> > I'm assuming that the interruptions come from the fact that there's two
> > I2C clients?
> >
> 
> The patch is still invalid. It can't prevent pm860x i2c operation be
> interrupted by other clients.
> 
> There're two banks in 88pm8607. One is the normal bank, and the other
> one is the test bank. Accessing the test bank need a special I2C
> sequence.
> 
> Touching to 0xFA address
> Touching to 0xFB address
> Touching to 0xFF address
> Accessing bank register
> Touching to 0xFE address
> Touching 0xFC address
> 
> This sequence can't be interrupted. It means that we can't use
> i2c_master_send() to implement touching 0xFA address. Otherwise, other
> i2c operation may be inserted into 0xFA and 0xFB operation since the
> lock of i2c_adapter is already released.
> 
> So you need to fix this issue for accessing test bank first. Then you
> can replace i2c read/write implementation with regmap for only normal
> bank in 88pm8607.
Jett, could you please look at that ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
