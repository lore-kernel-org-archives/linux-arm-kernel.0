From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 17 Aug 2015 16:15:47 +0100
Subject: [PATCH 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <CACvgo537C6SRfhMTNoE4cSLJukcXuKLvt1TRykynX--ybEhmaQ@mail.gmail.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
 <CACvgo537C6SRfhMTNoE4cSLJukcXuKLvt1TRykynX--ybEhmaQ@mail.gmail.com>
Message-ID: <20150817151547.GA1020@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 16, 2015 at 09:56:33AM +0100, Emil Velikov wrote:
> Hi Liviu,

Hi Emil,

> 
> On 5 August 2015 at 15:28, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > The HDLCD controller is a display controller that supports resolutions
> > up to 4096x4096 pixels. It is present on various development boards
> > produced by ARM Ltd and emulated by the latest Fast Models from the
> > company.
> >
> I believe there is a unofficial requirement(?) for new drm drivers to
> use atomic modesetting. Not 100% sure on this one though. The
> following drivers: tegra, msm, rcar-du, i915, and Daniel's blog [1]
> [2] cat provide some information on the topic.

I am also interested to know if this is a requirement or not.
Thanks for the pointers, I will review them again to see if I did miss
anything. I remember reading them at the beginning of the year but probably
the Christmas haze did not clear enough when I did.

> 
> The driver seems to has has a bit of dead code guarded by
> HDLCD_*_UNDERRUN. Perhaps these macros should become build or runtime
> switch(es) ?

There is a comment in hdlcd_drv.h explaining what HDLCD_SHOW_UNDERRUN can
be used for. As for HDLCD_COUNT_BUFFERUNDERRUNS, you are right, it's dead
code from the earlier debugging code that got removed before submission.
I will correct that.

> 
> Most DRM drivers do not threat dma, bus_error, vsync and/or underrun
> interrupts as debug functionality. They are of limited use in this
> driver, presently, yet the CONFIG_DEBUG_FS guard seems a bit strange
> imho.

The HDLCD device has only 1 interrupt that can fire and there is no other
way to show the reason for the interrupt in the driver. It was useful when
debugging underruns and/or vsync issues so I thought it might be useful
to keep around. Putting it the other way: if you are going to use this device
and the image is not completely rendered I would not be able to give you
support to figure out what went wrong without this debugging information.
With this in place I can tell the difference between a busy system vs one
where the interrupt latency is large.

Best regards,
Liviu

> 
> Cheers,
> Emil
> 
> [1] http://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
> [2] http://blog.ffwll.ch/2015/01/update-for-atomic-display-updates.html
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
