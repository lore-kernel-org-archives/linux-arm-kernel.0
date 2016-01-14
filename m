From: peter@korsgaard.com (Peter Korsgaard)
Date: Thu, 14 Jan 2016 12:43:00 +0100
Subject: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63EBEC7@penmbx01> (Wenyou
 Yang's message of "Thu, 14 Jan 2016 08:07:40 +0000")
References: <1452586629-1117-1-git-send-email-wenyou.yang@atmel.com>
 <1452586629-1117-2-git-send-email-wenyou.yang@atmel.com>
 <87oacp5zl7.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63EBC6E@penmbx01>
 <87egdk39ji.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63EBEC7@penmbx01>
Message-ID: <87a8o82xq3.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Yang," == Yang, Wenyou <Wenyou.Yang@atmel.com> writes:

Hi,

>> 
 >>> Isn't the regulator part of the act8945a identical to act8865? Can't we just use
 >>> the existing act8865-regulator.c driver? (E.G. support 8865 variant in the mfd
 >>> driver, but only register the regulator sub device?)
 >> 
 >> > Yes, the regulator part of the act8945a is identical to act8865.
 >> 
 >> > But the act8865-regulator driver is a struct i2c_driver, and the mfd  > sub-
 >> device driver is a platform_driver driver, it is not easy to use  > it.
 >> 
 >> But the mfd driver could support the act8865 variant as well (by only registering
 >> the regulator mfd cell).

 > I still don't understand.

 > The MFD sub device is registered as a platform device, the existing
 > act8865 driver is registered as an i2c_driver. How do they match? :)

 > Could you point out which exiting driver for me to reference.  Thank you!

What I'm saying is that it isn't nice that we end up with both
act8865-regulator.c and act8954-regulator.c doing 95% the same. This can
either be fixed by:

- Adding act8865 support to your mfd driver (but only registering the
  regulator subdev for act8865) and changing the existing
  act8865-regulator driver to work as a mfd subdev (platform device)

- Extending the act8865-regulator driver to register as a platform
  driver in ADDITION to a i2c driver so it can be used with mfd. The
  driver already uses regmap so it should only be a matter of adding the
  pdev probe/remove functions.

-- 
Venlig hilsen,
Peter Korsgaard 
