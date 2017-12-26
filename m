From: yong.deng@magewell.com (Yong)
Date: Tue, 26 Dec 2017 08:56:25 +0800
Subject: [linux-sunxi] [PATCH v4 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <20171225085802.lfyk4blmbqxq6r2m@core.my.home>
References: <1513935138-35223-1-git-send-email-yong.deng@magewell.com>
 <1513950408.841.81.camel@megous.com>
 <20171225111526.4663f997f5d6bfc6cf157f10@magewell.com>
 <20171225085802.lfyk4blmbqxq6r2m@core.my.home>
Message-ID: <20171226085625.22d600ded58e9ade49126486@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Dec 2017 09:58:02 +0100
Ond?ej Jirman <megous@megous.com> wrote:

> Hello,
> 
> On Mon, Dec 25, 2017 at 11:15:26AM +0800, Yong wrote:
> > Hi,
> > 
> > On Fri, 22 Dec 2017 14:46:48 +0100
> > Ond?ej Jirman <megous@megous.com> wrote:
> > 
> > > Hello,
> > > 
> > > Yong Deng p??e v P? 22. 12. 2017 v 17:32 +0800:
> > > > 
> > > > Test input 0:
> > > > 
> > > >         Control ioctls:
> > > >                 test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
> > > >                 test VIDIOC_QUERYCTRL: OK (Not Supported)
> > > >                 test VIDIOC_G/S_CTRL: OK (Not Supported)
> > > >                 test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
> > > >                 test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
> > > >                 test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > > >                 Standard Controls: 0 Private Controls: 0
> > > 
> > > I'm not sure if your driver passes control queries to the subdev. It
> > > did not originally, and I'm not sure you picked up the change from my
> > > version of the driver. "Not supported" here seems to indicate that it
> > > does not.
> > > 
> > > I'd be interested what's the recommended practice here. It sure helps
> > > with some apps that expect to be able to modify various input controls
> > > directly on the /dev/video# device. These are then supported out of the
> > > box.
> > > 
> > > It's a one-line change. See:
> > > 
> > > https://www.kernel.org/doc/html/latest/media/kapi/v4l2-controls.html#in
> > > heriting-controls
> > 
> > I think this is a feature and not affect the driver's main function.
> > I just focused on making the CSI main function to work properly in 
> > the initial version. Is this feature mandatory or most commonly used?
> 
> I grepped the platform/ code and it seems, that inheriting controls
> from subdevs is pretty common for input drivers. (there are varying
> approaches though, some inherit by hand in the link function, some
> just register and empty ctrl_handler on the v4l2_dev and leave the
> rest to the core).
> 
> Practically, I haven't found a common app that would allow me to enter
> both /dev/video0 and /dev/v4l-subdevX. I'm sure anyone can write one
> themselves, but it would be better if current controls were available
> at the /dev/video0 device automatically.
> 
> It's much simpler for the userspace apps than the alternative, which
> is trying to identify the correct subdev that is currently
> associated with the CSI driver at runtime, which is not exactly
> straightforward and requires much more code, than a few lines in
> the kernel, that are required to inherit controls:
> 
> 
> 	ret = v4l2_ctrl_handler_init(&csi->ctrl_handler, 0);
> 	if (ret) {
> 		dev_err(csi->dev,
> 			"V4L2 controls handler init failed (%d)\n",
> 			ret);
> 		goto handle_error;
> 	}
> 
> 	csi->v4l2_dev.ctrl_handler = &csi->ctrl_handler;
> 
> See: https://github.com/megous/linux/blob/linux-tbs/drivers/media/platform/sun6i-csi/sun6i_csi.c#L1005

Ok, I will add this. Thanks for your explication.

> 
> regards,
>   o.j.
> 
> > Thanks,
> > Yong


Thanks,
Yong
