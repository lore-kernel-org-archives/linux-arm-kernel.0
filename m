From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Jul 2013 10:40:05 +0300
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <51DBB96E.90600@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi> <51DBA0C2.6030003@ti.com>
 <20130709064212.GB5552@arwen.pp.htv.fi> <51DBB96E.90600@ti.com>
Message-ID: <20130709074005.GG5552@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 09, 2013 at 12:49:10PM +0530, Rajendra Nayak wrote:
> >>>> Right, but calling serial_omap_restore_context() even when the context
> >>>> is not lost, should not ideally cause an issue.
> >>>
> >>> it does in one condition. If context hasn't been saved before. And that
> >>> can happen in the case of wrong pm runtime status for that device.
> >>>
> >>> Imagine the device is marked as suspended even though it's fully enabled
> >>> (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> >>> your context structure is all zeroes (context has never been saved
> >>> before) then when you call pm_runtime_get_sync() on probe() your
> >>> ->runtime_resume() will get called, which will restore context,
> >>> essentially undoing anything which was configured by u-boot.
> >>
> >> This could be a problem for drivers which do a save context in ->runtime_suspend()
> >> but from what I see with omap serial, there is no save context done as part of
> >> ->runtime_suspend.
> > 
> > right, because context is "saved" in set_termios. probe() will get
> > called much before set_termios() has a chance to run, right ?
> > 
> > Same problem will trigger in that case.
> > 
> > I still think patch below is necessary
> 
> Right, I'll try some on those lines. Looks like a
> pm_runtime_set_active() is done for the console in the non DT case in
> omap_serial_init_port(). It seems to be missing in the DT case.

yeah, based on conversation I had with Alan Stern a while back,
pm_runtime_set_*() is best called by the underlying 'bus' and I tend to
agree with him on that.

Our HWMOD being our 'bus' (not really, but still), is the entity which
knows if the device is powered or not and should make sure to call
pm_runtime_set_*() for all devices.

> Although I feel this should fix the issue we have right now, I wonder
> if there could ever be a case with uart being suspended and having to
> resume again before a set_termios? What I mean to ask is, if the omap
> serial driver assuming a resume to happen only post a set_termios is
> always valid.

Meaning, probe() -> suspend() -> resume() ? I don't think that would
ever happen. ->set_termios() would always get called and that's actually
what triggers the resume.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/b1c30c1f/attachment.sig>
