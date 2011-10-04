From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 09:58:10 -0600
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20111004145148.GA8021@manju-desktop>
References: <20110922184614.25419.84606.stgit@ponder>
	<20111004145148.GA8021@manju-desktop>
Message-ID: <CACxGe6tXEx1A+ZuBTUdi8jjfx_hOCaX6eSpUOOhNH9us+Mnczg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 4, 2011 at 8:51 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> On Thu, Sep 22, 2011 at 12:51:23PM -0600, Grant Likely wrote:
>> Hi Manjunath,
>>
>> Here's the current state of the patch. ?The major think that needs to
>> be done is to convert it to use a separate workqueue as described in
>> the TODO above. ?It also needs some users adapted to it. ?One of the
>> gpio drivers would work; preferably one of the newer drivers that
>> doesn't have a lot of drivers depending on the early_initcall()
>> behaviour yet.
>
> I have tested this patch on omap3 beagle board by making:
> 1. omap-gpio driver init as late_initcall instead of postcore_initcall
> 2. mmc driver probe will request gpio through gpio_request and gpio driver
> returns -EDEFER_PROBE which in turn makes mmc driver to request deferral probe.
> 3. When deferral probe gets activated, it scans driver entries and it will not
> find any match for mmc driver probe.

Looks like drivers/mmc/host/omap.c is using platform_driver_probe()
instead of platform_driver_register().  Add the probe hook to the
platform_driver structure and change it to call
platform_driver_register() and it should work.  Don't forget to change
mmc_omap_probe from __init to __devinit.

g.
