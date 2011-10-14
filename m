From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 14 Oct 2011 11:39:16 -0400 (EDT)
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20111013182827.GL18574@ponder.secretlab.ca>
Message-ID: <Pine.LNX.4.44L0.1110141137460.2036-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Grant Likely wrote:

> > However it's worth pointing out right at the start that we already have
> > device_pm_move_before(), device_pm_move_after(), and
> > device_pm_move_last().  They are intended specifically to provide
> > drivers with a way of making sure that dpm_list is in the right order 
> > -- people have been aware of these issues for some time.
> 
> I saw those.  I also notice that they are only used by device_move()
> when reparenting a device (which is another wrinkle I hadn't though
> about).  Reparenting a device becomes problematic if the probe order
> is also represented in the list.  If device_move() gets called, then
> any implicit probe-order sorting for that device would be lost.
> 
> I also notice that device_move disregards any children when moving a
> device, which could also be a problem.
> 
> Although it looks like the only users of device_move are:
> 
> drivers/media/video/pvrusb2/pvrusb2-v4l2.c
> drivers/s390/cio/device.c
> net/bluetooth/hci_sysfs.c
> net/bluetooth/rfcomm/tty.c
> 
> So it may not be significant to adapt.

I trust that very little will be needed.  I haven't checked the 
existing callers, but it's reasonable to require that a device being 
moved not have any children.

Alan Stern
