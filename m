From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 25 Oct 2012 07:46:38 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121024233356.1bda95bf@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210242006.55879.michael@walle.cc>
 <20121024200128.GY21046@lunn.ch> <20121024233356.1bda95bf@skate>
Message-ID: <20121025054638.GB8590@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 11:33:56PM +0200, Thomas Petazzoni wrote:
> Andrew,
> 
> On Wed, 24 Oct 2012 22:01:28 +0200, Andrew Lunn wrote:
> 
> > I guess it is too early to use gpio. I don't think the gpio driver has
> > not been configured yet.
> > 
> > I need to think about this.
> > 
> > What happens if you comment out these two gpio_set_value calls?
> 
> The problem is (probably, I haven't tested) that in
> mach-kirkwood/board-dt.c, the of_platform_populate() function is called
> after all the board-specific init. So all the devices described in the
> DT, including GPIO banks, have not been registered yet. Most likely the
> of_platform_populate() should come before the board specific inits.

Thanks Thomas, i will play around with this.

I'm just wondering if we are going to get into ordering issues. These
gpio operations are providing power to subsystems. We probably need
that to happen before the driver is loaded. If we call
of_platform_populate() too early, do we have the danger the driver
probing is going to happen before the init routine can enable the
power?

It seems like we want pinctrl/gpio working first, with pins hogged as
specified in DT, then the board init() function, then the rest of DT
setup.

> Also there should probably  be a gpio_request() before those
> gpio_set_value().

Yes. That worked before, but might break now. Most of the init()
functions do actually make a gpip_request() call.

     Andrew
