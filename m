From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 3 Aug 2011 17:43:55 +0100
Subject: Shouldn't DT preserve pdev name and id to allow platform_match to
	work?
In-Reply-To: <4E396361.3060307@ti.com>
References: <4E396361.3060307@ti.com>
Message-ID: <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 4:04 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Grant,
>
> Going further with the usage of OF_DEV_AUXDATA_ID, I realized that this is is not doing what I was expecting. My expectation might be silly, but in order to make platform_match to work without DT matching mechanism, you need to have the driver name in the pdev->name field:
>
> ? ? ? ?/* fall-back to driver name match */
> ? ? ? ?return (strcmp(pdev->name, drv->name) == 0);
>
> Except that the of_device_add function is doing that:
> ? ? ? ?pdev->name = dev_name(&ofdev->dev);
> ? ? ? ?pdev->id = -1;

Yes, I know.  It is written that way on purpose so that it doesn't get
used to avoid adding a match table to the device driver because
auxdata is a stop-gap solution.  It is *not* intended to be used long
term (with one exception for passing platform callbacks when there is
no other solution).

auxdata passes platform_data and overrides the device name when there
is no way easy way to make the driver work without it.  It handles the
the current implementation of clocks and regulators which aren't yet
populated from the device tree.  It will go away when clock &
regulator bindings are implemented.

By implementing it the way it is, it ensures that no drivers
inadvertently depends on auxdata, and will thus break when the auxdata
entries are removed.  Manjunath mentioned that there is a patch that
allows the id to be set, but it still doesn't set the driver name in a
way that will allow existing drivers to bind using the old method, and
that is by design.

I understand what you are asking for, but the DT matching mechanism is
absolutely required.  Adding it to drivers is certainly not any more
onerous that maintaining a bunch of auxdata tables for boards.
Besides, part of the point of the move to DT is to eliminate device
and device data tables at the board file level, which is another
reason why auxdata is a temporary solution.

g.
