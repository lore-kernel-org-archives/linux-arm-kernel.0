From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 11:56:56 +0000
Subject: [RFC PATCH v3] ARM: imx: Add basic imx6q thermal management
In-Reply-To: <CAMXH7KE3CUvoZgW2UQiPLc3-oAHO0gcH4GRHU46ScyK519nvfQ@mail.gmail.com>
References: <1326862087-17816-1-git-send-email-rob.lee@linaro.org>
 <1326862087-17816-2-git-send-email-rob.lee@linaro.org>
 <CAMXH7KE3CUvoZgW2UQiPLc3-oAHO0gcH4GRHU46ScyK519nvfQ@mail.gmail.com>
Message-ID: <20120118115656.GE1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 05:40:02AM -0600, Rob Lee wrote:
> > + ? ? ? /* In the rarest of cases, order matters here - resume goes first */
> > + ? ? ? th_zone->therm_dev->device.class->resume = imx6q_thermal_resume;
> > + ? ? ? th_zone->therm_dev->device.class->suspend = imx6q_thermal_suspend;
> On second thought, I should have barrier between these two statements
> to guarantee order.  I think mb() would be ok.

Err, no.  This is a serious bug.

You're writing to this structure:

static struct class thermal_class = {
        .name = "thermal",
        .dev_release = thermal_release,
};

in thermal_sys.c, which would be shared with other thermal drivers.  This
is far from safe - it's insane.

The ordering or mb() is the least of your problems.

If there isn't suspend/resume support provided, please talk to the thermal
people about how to do this.
