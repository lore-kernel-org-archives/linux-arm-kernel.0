From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 15 Nov 2011 11:07:40 -0800
Subject: [PATCH] ARM: SAMSUNG: Save/restore GPIO drive strength across
 suspend/resume
In-Reply-To: <CAJuYYwQNQZmMYgwcZr1M2dxfhjuJvL6AimfkQQoG_arxi6UwGg@mail.gmail.com>
References: <1321074108-10025-1-git-send-email-inderpal.singh@linaro.org>
 <CACRpkdbC=w5vRvgLVpAcmcampt-baTydpLHBexak4RzxUcO32Q@mail.gmail.com>
 <CAJuYYwSvRYWdoccSN3nU7G4zXyTjt7vkjAd_vDx=QchG+yd5Cg@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740805B13@HQMAIL01.nvidia.com>
 <CAJuYYwQNQZmMYgwcZr1M2dxfhjuJvL6AimfkQQoG_arxi6UwGg@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740805E0D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote at Monday, November 14, 2011 12:37 PM:
...
> I am not sure how this works, but with dynamic transitioning, will it
> be possible to program the pinmux registers dynamically when a
> driver/controller decides to idle for sometime and come back up again
> (not a system wide suspend-resume cycle). There might be a need for
> the driver to inform the pinmux subsystem of this case and allow the
> pinmux subsystem to re-program pinmux registers as required.

Well, such a feature doesn't exist yet.

But, I envisaged extending the existing:

pmx = pinmux_get()
pinmux_enable(pmx)
...
pinmux_disable(pmx)
pinmux_put(pmx)

to something like:

pmx = pinmux_get(active)
pinmux_enable(pmx)
...
pinmux_switch(suspend)
...
pinmux_switch(active)
...
pinmux_disable(pmx)
pinmux_put(pmx)

(I think LinusW proposed an alternative a while back last time we talked
about this)

This has received only limited discussion though, and there are probably
many gotchas to think through; I imagine any such feature is a way off.

-- 
nvpublic
