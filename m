From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 17:43:23 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127154316.GG31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123150439.GB18754@mellanox.com>
 <20171127154316.GG31757@n2100.armlinux.org.uk>
Message-ID: <20171127174323.GK31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 03:43:16PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 23, 2017 at 08:04:39AM -0700, Jason Gunthorpe wrote:
> > Like Russell has said already, the kernel is the only place that could
> > actually have all the information needed. User space would have to use
> > some kind of trail and error approach to figure out what the offset
> > should be.
> 
> Jason,
> 
> Now that -rc1 is out, and I'm rebasing the branches, what I find is
> the patch that was merged is not the patch that I last tested.  The
> last patch I had from you was 22 Sep 2017.
> 
> The most obvious difference is in drivers/rtc/class.c:
> 
> -+      /* Drivers can revise this default after allocating the device. */
> ++      /* Drivers can revise this default after allocating the device. It
> ++       * should be the value of wallclock tv_nsec that the driver needs in
> ++       * order to synchronize the second tick over during set.
> ++       */
> 
> but there's also considerable differences in kernel/time/ntp.c, which
> seems to miss out on some fixes for bugs I reported along the way:
> 
>  +      getnstimeofday64(&now);
>  +
> -+      adjust = now;
> ++      now = adjust;
> 
> What's going on?
> 
> I've got a rebase mess here to sort out, and it's a horrid mess.
> 
> I think what's in -rc1 is rather fscked.

Having been through the conflict mess and come out with a resolution,
I think it might be okay, with the exception of the missing explanation
in drivers/rtc/class.c.  I do need to run some tests on it to make sure
though.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
