From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 Nov 2012 08:38:21 +0200
Subject: tfp410 and i2c_bus_num
In-Reply-To: <20121118113437.GB30462@arwen.pp.htv.fi>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
 <20121116135155.GE18527@arwen.pp.htv.fi> <50A64D35.9050109@ti.com>
 <20121116151959.GA19411@arwen.pp.htv.fi> <50A65E40.9040208@ti.com>
 <20121116182146.GC20496@arwen.pp.htv.fi> <50A72390.3050509@ti.com>
 <20121118113437.GB30462@arwen.pp.htv.fi>
Message-ID: <50A9D3DD.6040807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(dropping Tony and stable)

On 2012-11-18 13:34, Felipe Balbi wrote:

> how are you toggling the gpio ? You said tfp410 isn't controlled at all
> except for the power down gpio. Who provides the gpio ?

It's a normal OMAP GPIO, going to TFP410. I use gpio_set_value() to
set/unset it.

>> Well, it's not that simple. TFP410 manages hot plug detection of the
>> HDMI cable (although not implemented currently), so the we'd need to
>> convey that information to the i2c-edid somehow. Which, of course, is
>> doable, but increases complexity.
> 
> I'd say it would decrease it since you would have a single copy of
> i2c-edid.c for DRM or DSS or any other panel/display framework.

Well. Reading EDID via i2c is one or two i2c reads. There's nothing else
to it.

If we had a separate, independent i2c-edid driver, we'd have to somehow
link the i2c-edid driver and tfp410 (or whatever driver would handle the
video link in that particular case) so that the i2c-edid driver would
know about hotplug events. We would also need to link the drivers so
that the edid can be associated with the video pipeline the tfp410 chip
is part of, and to the particular slot in the pipeline where the tfp410 is.

I haven't tried writing such a driver, but it sounds much more complex
to me than doing one or two i2c reads in the tfp410 driver.

>> Another thing is that even if in this case the i2c and EDID reading are
>> separate from the actual video path, that may not be the case for other
>> display solutions. We could have a DSI panel which reports its
>> resolution via DSI bus, or we could have an external DSI-to-HDMI chip,
>> which reads the EDID via i2c from the monitor, but reports them back to
>> the SoC via DSI bus.
> 
> In this last case we would see just the DSI, not the I2C bus, so it's
> like I2C bus doesn't exist, so in fact we would have two possibilities:
> 
> a) read EDID via I2C bus (standard HDMI)
> b) read EDID via DSI.

Right. And currently reading edid is done via read_edid call with
omapdss, and the caller doesn't care if read_edid uses i2c or DSI, so it
should just work.

> b) doesn't exist today so we need to care about it until something like
> what you say shows up in the market. Until then, we care for EDID over
> I2C IMHO.

There are chips such as I described, although not supported in the mainline.

>> So we need a generic way to get the resolution information, and it makes
>> sense to have this in the components of the video path, not in a
>> separate driver which is not part of the video path as such.
> 
> But the I2C bus isn't part of the video path anyway. It's a completely
> separate path which is dedicated to reading EDID. If you need a generic

While reading EDID is totally separate from the video data itself, it is
not separate from the hotplug status of the cable. And the EDID needs to
be associated with the video path in question, of course.

> way for that case you wanna cope with other methods for reading EDID,
> then you need a generic layer which doesn't care if it's I2C or DSI.
> Currently implementation is hardcoded to I2C anyway.

No, reading edid is done via generic read_edid call. TFP410 uses i2c to
read edid, but it could do it in any way it wants.

> In fact current implementation is far worse than having an extra
> i2c-edid.c driver because it doesn't encapsulate EDID implementation
> from tfp410.
> 
> Then moment you need to read EDID via DSI, you will likely have to pass
> a DSI handle to e.g. TFP410 so it can read EDID via DSI.

TFP410 is a parallel RGB to DVI chip. It's not related to DSI. The DSI
case would be with some other chip.

> What I'm suggesting, however, is that you have a layer hiding all that.
> Make your i2c-edid.c driver read EDID and report it to this generic
> layer, if some other driver in kernel needs the information, you should
> be calling into this generic edid layer to get the cached values.
> 
> If you don't need that data in kernel, then just expose it through a set
> of standard sysfs files and teach Xorg about those.

We need the data in the kernel.

>> And while the above issues could perhaps be solved, all we do is read
>> one or two 128 byte datablocks from the i2c device. I'm not sure if the
>> extra complexity is worth it. At least it's not on the top of my todo
> 
> When you have EDID over DSI, what will you do ?

Write the code to read the EDID =). How that is done in practice depends
on the chip in question, using chip specific DSI commands.

>> list as long as the current solution works =).
> 
> that's your choice.
> 
>>> If you have a generic i2c-edid.c simple driver, I guess X could be
>>> changes to read those values from sysfs and take actions based on those.
>>
>> We handle the EDID inside the kernel, although I'm not sure if drm also
>> exposes the EDID to userspace.
> 
> I suppose it does, but haven't looked through the code.
> 
>>> Looks like even drm_edid.c should change, btw.
>>
>> Yes, DRM handles it in somewhat similar way.
> 
> another reason to make a generic i2c-edid.c. It make no sense to have
> two pieces of code doing exactly the same thing, which is reading edid
> over an I2C link.

We could have a library with the code that does the one or two i2c
reads. And while I think it'd be good, we're talking about one or two
i2c reads. It wouldn't be a huge improvement.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/5a69f037/attachment.sig>
