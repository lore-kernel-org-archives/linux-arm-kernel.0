From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Sep 2012 13:37:03 +0300
Subject: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
In-Reply-To: <20120925102958.GL31374@n2100.arm.linux.org.uk>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
 <CAKdam572krJZcayRdJ_AciCUZH3LuzD9yoHenhxrB6j9xDZ6JQ@mail.gmail.com>
 <20120925083029.GG31374@n2100.arm.linux.org.uk>
 <20120925083118.GI9137@arwen.pp.htv.fi>
 <20120925091228.GI31374@n2100.arm.linux.org.uk>
 <20120925091112.GK9137@arwen.pp.htv.fi>
 <20120925092118.GJ31374@n2100.arm.linux.org.uk>
 <20120925094815.GL9137@arwen.pp.htv.fi>
 <20120925102958.GL31374@n2100.arm.linux.org.uk>
Message-ID: <20120925103652.GN9137@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 11:29:58AM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 25, 2012 at 12:48:16PM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Sep 25, 2012 at 10:21:18AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Sep 25, 2012 at 12:11:14PM +0300, Felipe Balbi wrote:
> > > > On Tue, Sep 25, 2012 at 10:12:28AM +0100, Russell King - ARM Linux wrote:
> > > > > On Tue, Sep 25, 2012 at 11:31:20AM +0300, Felipe Balbi wrote:
> > > > > > On Tue, Sep 25, 2012 at 09:30:29AM +0100, Russell King - ARM Linux wrote:
> > > > > > > How is this happening?  I think that needs proper investigation - or if
> > > > > > > it's had more investigation, then the results needs to be included in
> > > > > > > the commit description so that everyone can understand the issue here.
> > > > > > > 
> > > > > > > We should not be resuming a device which hasn't been suspended.  Maybe
> > > > > > > the runtime PM enable sequence is wrong, and that's what should be fixed
> > > > > > > instead?  
> > > > > > > 
> > > > > > > This sequence in the probe() function:
> > > > > > > 
> > > > > > >         pm_runtime_irq_safe(&pdev->dev);
> > > > > > >         pm_runtime_enable(&pdev->dev);
> > > > > > >         pm_runtime_get_sync(&pdev->dev);
> > > > > > > 
> > > > > > > would enable runtime PM while the s/w state indicates that it's disabled,
> > > > > > > and then that pm_runtime_get_sync() will want to resume the device.  See
> > > > > > > the section "5. Runtime PM Initialization, Device Probing and Removal"
> > > > > > > in Documentation/power/runtime_pm.txt, specifically the second paragraph
> > > > > > > of that section.
> > > > > > 
> > > > > > that was tested. It worked in pandaboard but didn't work on beagleboard
> > > > > > XM. Sourav tried to start a discussion about that, but it simply died...
> > > > > > 
> > > > > > In any case, pm_runtime_get_sync() in probe will always call
> > > > > > runtime_resume callback, right ?
> > > > > 
> > > > > Well, if the runtime PM state says it's suspended, and then you enable
> > > > > runtime PM, the first call to pm_runtime_get_sync() will trigger a resume
> > > > > attempt.  The patch description is complaining about resume events without
> > > > > there being a preceding suspend event.
> > > > > 
> > > > > This could well be why.
> > > > 
> > > > that's most likely, of course. But should we cause a regression to
> > > > beagleboard XM because of that ?
> > > 
> > > What would cause a regression on beagleboard XM?  I have not suggested
> > > any change other than more investigation of the issue and a fuller patch
> > > description - yet you're screaming (idiotically IMHO) that mere
> > > investigation would break beagleboard.
> > > 
> > > Well, if it's _that_ fragile, that mere investigation of this issue by
> > > someone elsewhere on the planet would break your beagleboard, maybe it
> > > deserves to be broken!
> > 
> > why are you always so over the top like that ? This is just
> > counter-productive to say the least.
> 
> Because you are accusing me of potentially breaking your beagleboard
> for merely suggesting further investigation and a better commit message.

Where did I accuse you of anyting ? I just mentioned we experienced a
regression with beagleboard XM when using pm_runtime_set_active().

here's my quote:

> that was tested. It worked in pandaboard but didn't work on
> beagleboard XM. Sourav tried to start a discussion about that, but it
> simply died...

To add extra info, here you go:

We pinged Paul and asked if he had seen that before, he had no
pointers... Because Documentation/power/runtime_pm.txt was using a
mystruct->is_suspended flag, we just decided to follow the same
"design" since no-one was able to suggest why pm_runtime_set_active()
was breaking beagleXM nor how it was supposed to actually work.

Reading the code: pm_runtime_set_active() would tell pm_runtime core
the device is actually active by setting runtime_status to RPM_ACTIVE,
thus the following pm_runtime_get_sync() wouldn't actually call
runtime_resume() callback, but it would increment usage_counter.

I can't see why this would fail on beagleXM, but it does and we'd like
to hear in which situations this could fail...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/69c28261/attachment.sig>
