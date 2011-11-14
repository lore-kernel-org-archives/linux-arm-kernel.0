From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 14 Nov 2011 11:00:45 -0800
Subject: [PATCH] ARM: SAMSUNG: Save/restore GPIO drive strength across
 suspend/resume
In-Reply-To: <CAJuYYwSvRYWdoccSN3nU7G4zXyTjt7vkjAd_vDx=QchG+yd5Cg@mail.gmail.com>
References: <1321074108-10025-1-git-send-email-inderpal.singh@linaro.org>
 <CACRpkdbC=w5vRvgLVpAcmcampt-baTydpLHBexak4RzxUcO32Q@mail.gmail.com>
 <CAJuYYwSvRYWdoccSN3nU7G4zXyTjt7vkjAd_vDx=QchG+yd5Cg@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740805B13@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote at Monday, November 14, 2011 6:57 AM:
> On 12 November 2011 16:30, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Sat, Nov 12, 2011 at 6:01 AM, Inderpal Singh
> > <inderpal.singh@linaro.org> wrote:
> >
> >> GPIO driver strength settings are not preserved across suspend/resume
> >> for s5pc100, s5pv210 and Exynos platforms which has been the cause of
> >> mmc/sd card read/write failures after resume. Fix this by saving and
> >> restoring the GPIO driver strength register settings across suspend/resume.
> >>
> >> Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
> >
> > On a related theme: I am thinking about how to support preserving
> > drive strength (etc) across suspend/resume and deepsleep in the
> > pincontrol subsystem.
> >
> > Currently I am playing with the idea to let pin groups have states,
> > as the different configurations seem to be 90% or so about very
> > specific sleep modes, so say:
> >
> > pinconf_set_group_state("mmcgroup", PINCONF_STATE_ACTIVE);
> > pinconf_set_group_state("mmcgroup", PINCONF_STATE_SUSPENDED);
> > pinconf_set_group_state("mmcgroup", PINCONF_STATE_SLEEP);
> 
> 
> The API name suggests that power state is set based on a pin group.
> For a driver, the following could be convenient as the driver transits
> through various power management states.
> 
> struct pinmux pmx;
> pmx = pinmux_get(dev, "i2c0");
> 
> [...]
> 
> pinmux_set_state(pmx, PINCONF_STATE_SLEEP);
> [...]
> pinmux_set_state(pmx, PINCONF_STATE_ACTIVE);

That seems a more consistent driver-oriented API, yes.

I'd of course lean towards adding the pin config data into the mapping
table, and using the existing feature struct pinmux_map name field to
name those states, and allowing dynamic transitioning between states,
rather than adding a complete new API and namespace for these states.

-- 
nvpublic
