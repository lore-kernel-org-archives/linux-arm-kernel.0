From: balbi@ti.com (Felipe Balbi)
Date: Sun, 18 Nov 2012 13:34:37 +0200
Subject: tfp410 and i2c_bus_num
In-Reply-To: <50A72390.3050509@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
 <20121116135155.GE18527@arwen.pp.htv.fi> <50A64D35.9050109@ti.com>
 <20121116151959.GA19411@arwen.pp.htv.fi> <50A65E40.9040208@ti.com>
 <20121116182146.GC20496@arwen.pp.htv.fi> <50A72390.3050509@ti.com>
Message-ID: <20121118113437.GB30462@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 17, 2012 at 07:41:36AM +0200, Tomi Valkeinen wrote:
> On 2012-11-16 20:21, Felipe Balbi wrote:
> > Hi,
> > 
> > On Fri, Nov 16, 2012 at 05:39:44PM +0200, Tomi Valkeinen wrote:
> >>>>> To be fair, the whole i2c_bus_num looks like a big hackery introduced by
> >>>>> the way panel drivers are written for OMAP DSS.
> >>>>>
> >>>>> TFP410 is an I2C client, not an OMAPDSS client. After a quick look at
> >>>>> the driver, there's is no such thing as a DSS bus, so looks like you
> >>>>> should have an I2C driver for TFP410 and the whole DSS stuff should be
> >>>>> just a list of clients, but not a struct bus at all.
> >>>>>
> >>>>> The fact that you have to pass the I2C bus number down to the panel
> >>>>> driver is already a big indication of how wrong this is, IMHO.
> >>>>
> >>>> Without going deeper in the dss device model problems, I would agree
> >>>> with you if this was about i2c panel, but this is not quite like that.
> >>>>
> >>>> A panel controlled via i2c would be an i2c device. But TFP410 is not
> >>>> controlled via i2c. It's not really controlled at all except via
> >>>> power-down gpio. TFP410 doesn't need the i2c to be functional at all.
> >>>
> >>> then why does it need the i2c adapter ? What is this power-down gpio ?
> >>> Should that be hidden under gpiolib instead ?
> >>
> >> For the i2c, see below. Power-down GPIO is used to power down and up the
> >> tfp410 chip.
> > 
> > that much I guessed ;-) Should it be hidden under gpiolib ?
> 
> I have to say I have no idea what you mean... Hidden how?

how are you toggling the gpio ? You said tfp410 isn't controlled at all
except for the power down gpio. Who provides the gpio ?

> >>>> The i2c lines do not even touch TFP410 chip, so to be precise, the i2c
> >>>> lines should not be TFP410's concern. The i2c lines come from the
> >>>> monitor and go to OMAP's i2c pins. But TFP410 driver is a convenient
> >>>> place to manage them.
> >>>
> >>> fair enough... but who's actually using those i2c lines ? OMAP is the
> >>> I2C master, who's the slave ? It's something in the monitor, I assume...
> >>>
> >>> IIUC, this I2C bus goes over the HDMI wire ?
> >>
> >> Yes, the i2c goes over HDMI wire. OMAP is the master, monitor is the
> >> slave. You can see some more info from
> >> http://en.wikipedia.org/wiki/Display_Data_Channel under DDC2 section.
> >>
> >> It is used to read the EDID
> >> (http://en.wikipedia.org/wiki/Extended_display_identification_data)
> >> information from the monitor, which tells things like supported video
> >> timings etc.
> >>
> >> As for why the tfp410 driver handles the i2c... We don't have a better
> >> place. There's no driver for the monitor. Although in the future with
> > 
> > than that's wrong :-) If TFP410 isn't really using I2C it shouldn't need
> > the whole i2c_bus_num logic. I'm far from fully understanding dss
> > architecture but it looks like what you want is a generic 'i2c-edid.c'
> > which just reads the edid structure during probe and caches the values
> > and exposes them via sysfs ?!? (perhaps you also need a kernel API to
> > read those values... I don't know; but that's also doable).
> 
> Well, it's not that simple. TFP410 manages hot plug detection of the
> HDMI cable (although not implemented currently), so the we'd need to
> convey that information to the i2c-edid somehow. Which, of course, is
> doable, but increases complexity.

I'd say it would decrease it since you would have a single copy of
i2c-edid.c for DRM or DSS or any other panel/display framework.

> Another thing is that even if in this case the i2c and EDID reading are
> separate from the actual video path, that may not be the case for other
> display solutions. We could have a DSI panel which reports its
> resolution via DSI bus, or we could have an external DSI-to-HDMI chip,
> which reads the EDID via i2c from the monitor, but reports them back to
> the SoC via DSI bus.

In this last case we would see just the DSI, not the I2C bus, so it's
like I2C bus doesn't exist, so in fact we would have two possibilities:

a) read EDID via I2C bus (standard HDMI)
b) read EDID via DSI.

b) doesn't exist today so we need to care about it until something like
what you say shows up in the market. Until then, we care for EDID over
I2C IMHO.

> So we need a generic way to get the resolution information, and it makes
> sense to have this in the components of the video path, not in a
> separate driver which is not part of the video path as such.

But the I2C bus isn't part of the video path anyway. It's a completely
separate path which is dedicated to reading EDID. If you need a generic
way for that case you wanna cope with other methods for reading EDID,
then you need a generic layer which doesn't care if it's I2C or DSI.
Currently implementation is hardcoded to I2C anyway.

In fact current implementation is far worse than having an extra
i2c-edid.c driver because it doesn't encapsulate EDID implementation
from tfp410.

Then moment you need to read EDID via DSI, you will likely have to pass
a DSI handle to e.g. TFP410 so it can read EDID via DSI.

What I'm suggesting, however, is that you have a layer hiding all that.
Make your i2c-edid.c driver read EDID and report it to this generic
layer, if some other driver in kernel needs the information, you should
be calling into this generic edid layer to get the cached values.

If you don't need that data in kernel, then just expose it through a set
of standard sysfs files and teach Xorg about those.

> And while the above issues could perhaps be solved, all we do is read
> one or two 128 byte datablocks from the i2c device. I'm not sure if the
> extra complexity is worth it. At least it's not on the top of my todo

When you have EDID over DSI, what will you do ?

> list as long as the current solution works =).

that's your choice.

> > If you have a generic i2c-edid.c simple driver, I guess X could be
> > changes to read those values from sysfs and take actions based on those.
> 
> We handle the EDID inside the kernel, although I'm not sure if drm also
> exposes the EDID to userspace.

I suppose it does, but haven't looked through the code.

> > Looks like even drm_edid.c should change, btw.
> 
> Yes, DRM handles it in somewhat similar way.

another reason to make a generic i2c-edid.c. It make no sense to have
two pieces of code doing exactly the same thing, which is reading edid
over an I2C link.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121118/82455579/attachment-0001.sig>
