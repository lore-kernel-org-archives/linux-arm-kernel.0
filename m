From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 28 Nov 2018 09:20:57 +0100
Subject: [PATCH] drm/fbdev: Make skip_vt_switch the default
In-Reply-To: <3d406677-9d7d-6d8d-85af-1cfb253d1838@linux.intel.com>
References: <20181127170952.28507-1-daniel.vetter@ffwll.ch>
 <20181127173424.301-1-daniel.vetter@ffwll.ch>
 <3d406677-9d7d-6d8d-85af-1cfb253d1838@linux.intel.com>
Message-ID: <20181128082057.GH4266@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 08:17:04AM +0100, Maarten Lankhorst wrote:
> Op 27-11-18 om 18:34 schreef Daniel Vetter:
> > KMS drivers really should all be able to restore their display state
> > on resume without fbcon helping out. So make this the default.
> >
> > Since I'm not entirely foolish, make it only a default, which drivers
> > can still override. That way when the inevitable regression report
> > happens I can fix things up with a one-liner plus FIXME comment that
> > someone should fix up the suspend/resume code in that driver.
> >
> > But at least all new drivers won't be broken by accident as soon as
> > you turn off fbcon because "suspend/resume worked when I tested it".
> >
> > v2: Keep this for radeon because of
> >
> > commit 18c437caa5b18a235dd65cec224eab54bebcee65
> > Author: Alex Deucher <alexander.deucher@amd.com>
> > Date:   Tue Nov 14 17:19:29 2017 -0500
> >
> >     Revert "drm/radeon: dont switch vt on suspend"
> >
> > Thanks to Michel D?nzer for pointing this one out.
> 
> Maybe just reload the gamma lut on resume for radeon, instead of relying on fbcon?

It also caused random sound issues and other fun. Also, afaiui radeon does
load the lut. Except because of timing or bad luck, it doesn't work
reliably, and the vt switch doing it a 2nd time helps out.
-Daniel

> Otherwise patch looks sane, would be nice if radeon was fixed instead of worked around.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
