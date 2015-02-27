From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 27 Feb 2015 09:46:11 -0800
Subject: Bug in i2c-core?
In-Reply-To: <20150227170545.GS7789@pengutronix.de>
References: <54F0507F.6030804@armadeus.com>
 <20150227153725.7404dea1@free-electrons.com>
 <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
 <20150227170545.GS7789@pengutronix.de>
Message-ID: <20150227174611.GC6679@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 06:05:45PM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Feb 27, 2015 at 07:29:30AM -0800, Dmitry Torokhov wrote:
> > On February 27, 2015 6:37:25 AM PST, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> > >Dear S?bastien SZYMANSKI,
> > >
> > >On Fri, 27 Feb 2015 12:09:51 +0100, S?bastien SZYMANSKI wrote:
> > >
> > >>         error = input_register_device(sx8654->input);
> > >>         if (error)
> > >>                 return error;
> > >
> > >Where is your ->remove() function that unregisters the input device?
> > 
> > Everything seems to be allocated with devm so remove is not needed.
> Everything is devm_* but input_register_device, right?

Input is allocated with devm_* and input_register_device knows how to
deal with that:

/**
 * devm_input_allocate_device - allocate managed input device
 * @dev: device owning the input device being created
 *
 * Returns prepared struct input_dev or %NULL.
 *
 * Managed input devices do not need to be explicitly unregistered or
 * freed as it will be done automatically when owner device unbinds from
 * its driver (or binding fails). Once managed input device is
 * allocated,
 * it is ready to be set up and registered in the same fashion as
 * regular
 * input device. There are no special devm_input_device_[un]register()
 * variants, regular ones work with both managed and unmanaged devices,

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 * should you need them. In most cases however, managed input device
 * need
 * not be explicitly unregistered or freed.
 *
 * NOTE: the owner device is set up as parent of input device and users
 * should not override it.
 */


Thanks.

-- 
Dmitry
