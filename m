From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 13 Apr 2016 16:23:45 +0300
Subject: [PATCH] i2c: designware-platdrv: get fast/std speed scl
 high/low count from DT
In-Reply-To: <20160413201637.284a3673@xhacker>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
 <CAHp75VcHNdAUeob2iR6U1HbUQzEccdjPy8ffuG4mB_=ZX7EokQ@mail.gmail.com>
 <20160413201637.284a3673@xhacker>
Message-ID: <1460553825.6620.134.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-13 at 20:16 +0800, Jisheng Zhang wrote:
> Dear Andy,
> 
> On Thu, 7 Apr 2016 21:05:35 +0300 Andy Shevchenko??wrote:
> 
> > 
> > On Wed, Apr 6, 2016 at 10:28 AM, Jisheng Zhang <jszhang@marvell.com>
> > wrote:
> > > 
> > > Sometimes, it's convenient to define the scl's high/low count
> > > directly,
> > > e.g HW people would do some measurement then directly give out the
> > > optimum counts. Previously, we solved the sda falling time and scl
> > > falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put
> > > them
> > > into dt, but what we really care isn't the sda/scl falling time.
> > > 
> > > From another side, the dw_i2c_acpi_configure() on ACPI platform
> > > also
> > > get hcnt/lcnt values rather than the sda/scl falling time from
> > > ACPI
> > > method, we want similar feature for DT platforms.
> > > ?
> > Instead of duplicating some words maybe better to explicitly define
> > two groups of parameters and one which supersedes the other.
> I'm sorry, I can't catch your meaning. Could you please kindly give
> more
> details? Or examples of "two groups of parameters"


> --- + - i2c-ss-scl-high-count : should contain the standard speed i2c
> > > clock SCL high
> > > +???count. 


> > > If defined, the i2c-scl-falling-time-ns and i2c-sda-falling-time-
> > > ns
> > > +???will be ignored.

I'm referring to the above sentence. Something like

There are two groups of values identifying i2c timings:

1. i2c-scl-falling-time-ns and i2c-sda-falling-time-ns
2. *-[hl]cnt

The second group of parameters supersedes the first one.


> > > +
> > > + - i2c-ss-scl-low-count : should contain the standard speed i2c
> > > clock SCL low
> > > +???count. If defined, the i2c-scl-falling-time-ns and i2c-sda-
> > > falling-time-ns
> > > +???will be ignored.
> > > +
> > > + - i2c-fs-scl-high-count : should contain the fast speed i2c
> > > clock SCL high
> > > +???count. If defined, the i2c-scl-falling-time-ns and i2c-sda-
> > > falling-time-ns
> > > +???will be ignored.
> > > +
> > > + - i2c-fs-scl-low-count : should contain the fast speed i2c clock
> > > SCL low
> > > +???count. If defined, the i2c-scl-falling-time-ns and i2c-sda-
> > > falling-time-ns
> > > +???will be ignored.
> > > +
> > > ?Example :
> > > 
> > > ????????i2c at f0000 {
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > index d656657..8739a60 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -188,6 +188,14 @@ static int dw_i2c_plat_probe(struct
> > > platform_device *pdev)
> > > ?????????????????????????????????????????&dev->scl_falling_time);
> > > ????????????????device_property_read_u32(&pdev->dev, "clock-
> > > frequency",
> > > ?????????????????????????????????????????&clk_freq);
> > > +???????????????device_property_read_u16(&pdev->dev, "i2c-ss-scl-
> > > high-count",
> > > +????????????????????????????????????????&dev->ss_hcnt);
> > > +???????????????device_property_read_u16(&pdev->dev, "i2c-ss-scl-
> > > low-count",
> > > +????????????????????????????????????????&dev->ss_lcnt);
> > > +???????????????device_property_read_u16(&pdev->dev, "i2c-fs-scl-
> > > high-count",
> > > +????????????????????????????????????????&dev->fs_hcnt);
> > > +???????????????device_property_read_u16(&pdev->dev, "i2c-fs-scl-
> > > low-count",
> > > +????????????????????????????????????????&dev->fs_lcnt);
> > > ????????}
> > > 
> > > ????????if (has_acpi_companion(&pdev->dev))
> > > --
> > > 2.8.0.rc3
> > > ?
> > 
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
