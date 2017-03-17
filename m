From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Fri, 17 Mar 2017 14:49:27 -0300
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170317121608.GE21222@n2100.armlinux.org.uk>
References: <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170317114203.GZ21222@n2100.armlinux.org.uk>
 <1489752127.2905.49.camel@pengutronix.de>
 <20170317121608.GE21222@n2100.armlinux.org.uk>
Message-ID: <20170317144927.1298d5b3@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, 17 Mar 2017 12:16:08 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> escreveu:

> On Fri, Mar 17, 2017 at 01:02:07PM +0100, Philipp Zabel wrote:
> > I think most of the simple, fixed pipeline use cases could be handled by
> > libv4l2, by allowing to pass a v4l2 subdevice path to v4l2_open. If that
> > function internally would set up the media links to the
> > nearest /dev/video interface, propagate format, resolution and frame
> > intervals if necessary, and return an fd to the video device, there'd be
> > no additional complexity for the users beyond selecting the v4l2_subdev
> > instead of the video device.  
> 
> ... which would then require gstreamer to be modified too. The gstreamer
> v4l2 plugin looks for /dev/video* or /dev/v4l2/video* devices and monitors
> these for changes, so gstreamer applications know which capture devices
> are available:
> 
>   const gchar *paths[] = { "/dev", "/dev/v4l2", NULL };
>   const gchar *names[] = { "video", NULL };
> 
>   /* Add some depedency, so the dynamic features get updated upon changes in
>    * /dev/video* */
>   gst_plugin_add_dependency (plugin,
>       NULL, paths, names, GST_PLUGIN_DEPENDENCY_FLAG_FILE_NAME_IS_PREFIX);
> 
> I haven't checked yet whether sys/v4l2/gstv4l2deviceprovider.c knows
> anything about the v4l2 subdevs.

Not only gstreamer do that, but all simple V4L2 applications, although
on most of them, you can either pass a command line argument or setup
the patch via GUI.

Btw, I've no idea from where gstreamer took /dev/v4l2 :-)
I'm yet to find a distribution using it.

On the other hand, /dev/v4l/by-patch and /dev/v4l/by-id are usual directories
where V4L2 devices can be found, and should provide persistent names. So, IMHO,
gst should prefer those names, when they exist:

$ tree /dev/v4l
/dev/v4l
??? by-id
??? ??? usb-046d_HD_Pro_Webcam_C920_55DA1CCF-video-index0 -> ../../video1
??? ??? usb-Sunplus_mMobile_Inc_USB_Web-CAM-video-index0 -> ../../video0
??? by-path
    ??? platform-3f980000.usb-usb-0:1.2:1.0-video-index0 -> ../../video1
    ??? platform-3f980000.usb-usb-0:1.5:1.0-video-index0 -> ../../video0




Thanks,
Mauro
