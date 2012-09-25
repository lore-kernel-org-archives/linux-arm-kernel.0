From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Sep 2012 10:12:28 +0100
Subject: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
In-Reply-To: <20120925083118.GI9137@arwen.pp.htv.fi>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
 <CAKdam572krJZcayRdJ_AciCUZH3LuzD9yoHenhxrB6j9xDZ6JQ@mail.gmail.com>
 <20120925083029.GG31374@n2100.arm.linux.org.uk>
 <20120925083118.GI9137@arwen.pp.htv.fi>
Message-ID: <20120925091228.GI31374@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 11:31:20AM +0300, Felipe Balbi wrote:
> On Tue, Sep 25, 2012 at 09:30:29AM +0100, Russell King - ARM Linux wrote:
> > How is this happening?  I think that needs proper investigation - or if
> > it's had more investigation, then the results needs to be included in
> > the commit description so that everyone can understand the issue here.
> > 
> > We should not be resuming a device which hasn't been suspended.  Maybe
> > the runtime PM enable sequence is wrong, and that's what should be fixed
> > instead?  
> > 
> > This sequence in the probe() function:
> > 
> >         pm_runtime_irq_safe(&pdev->dev);
> >         pm_runtime_enable(&pdev->dev);
> >         pm_runtime_get_sync(&pdev->dev);
> > 
> > would enable runtime PM while the s/w state indicates that it's disabled,
> > and then that pm_runtime_get_sync() will want to resume the device.  See
> > the section "5. Runtime PM Initialization, Device Probing and Removal"
> > in Documentation/power/runtime_pm.txt, specifically the second paragraph
> > of that section.
> 
> that was tested. It worked in pandaboard but didn't work on beagleboard
> XM. Sourav tried to start a discussion about that, but it simply died...
> 
> In any case, pm_runtime_get_sync() in probe will always call
> runtime_resume callback, right ?

Well, if the runtime PM state says it's suspended, and then you enable
runtime PM, the first call to pm_runtime_get_sync() will trigger a resume
attempt.  The patch description is complaining about resume events without
there being a preceding suspend event.

This could well be why.
