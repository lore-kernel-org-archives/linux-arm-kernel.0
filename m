From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Nov 2012 14:16:30 +0200
Subject: tfp410 and i2c_bus_num
In-Reply-To: <50AA1376.6060801@ti.com>
References: <20121116135155.GE18527@arwen.pp.htv.fi> <50A64D35.9050109@ti.com>
 <20121116151959.GA19411@arwen.pp.htv.fi> <50A65E40.9040208@ti.com>
 <20121116182146.GC20496@arwen.pp.htv.fi> <50A72390.3050509@ti.com>
 <20121118113437.GB30462@arwen.pp.htv.fi> <50A9D3DD.6040807@ti.com>
 <20121119092744.GB4211@arwen.pp.htv.fi> <50AA1376.6060801@ti.com>
Message-ID: <20121119121630.GC15540@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 19, 2012 at 01:09:42PM +0200, Tomi Valkeinen wrote:
> On 2012-11-19 11:27, Felipe Balbi wrote:
> 
> >> If we had a separate, independent i2c-edid driver, we'd have to somehow
> >> link the i2c-edid driver and tfp410 (or whatever driver would handle the
> >> video link in that particular case) so that the i2c-edid driver would
> >> know about hotplug events. We would also need to link the drivers so
> >> that the edid can be associated with the video pipeline the tfp410 chip
> >> is part of, and to the particular slot in the pipeline where the tfp410 is.
> > 
> > that should all be doable, just look at how v4l2 handles pipelining the
> > video data (all in userland though) and you'll see it's definitely
> > possible.
> 
> Afaik, v4l2 handles only the pipeline for video. This i2c-edid would not
> be part of the video pipeline, so I don't see a connection to v4l2.

hehe, I was using an example of building a pipeline and adding whatever
devices you wanted to the pipeline ;-)

> And I'm not saying it's not possible, or that the current way is good or
> correct. I'm saying it's not easy, and definitely more complex than the
> current tfp410 implementation. The amount of code related to this
> feature would multiply.
> 
> If we had 10 different tfp410 like drivers, then obviously there'd be
> more pressing reason to clean this up. But currently we have only one
> place where this code is used.

fair enough, but I'd say there are two places: DSS and DRM.

> >> I haven't tried writing such a driver, but it sounds much more complex
> >> to me than doing one or two i2c reads in the tfp410 driver.
> > 
> > until you have e.g. tfp999, tfp534, tfp678 (hypothetical device numbers,
> > they probably don't exist) which are all SW incompatible and you have to
> > duplicate i2c reads in all of them. Whereas if you had a dedicated
> > i2c-edid.c driver, you would only have to tell them where to get EDID
> > structure from.
> > 
> > Also, if you have systems with different panel interfaces, they will use
> > the same i2c-edid.c and just instantiate that class multiple times.
> 
> Yep. Althought the same could be done with a common edid library,
> without an i2c-edid driver.

correct.

> >>>> So we need a generic way to get the resolution information, and it makes
> >>>> sense to have this in the components of the video path, not in a
> >>>> separate driver which is not part of the video path as such.
> >>>
> >>> But the I2C bus isn't part of the video path anyway. It's a completely
> >>> separate path which is dedicated to reading EDID. If you need a generic
> >>
> >> While reading EDID is totally separate from the video data itself, it is
> >> not separate from the hotplug status of the cable. And the EDID needs to
> >> be associated with the video path in question, of course.
> > 
> > yes, but that can't be done in another way right ? Try something like
> > having a EDID provider and an EDID consumer. The provider will be
> > i2c-edid.c or dvi-edid.c and the consumer will a generic layer which
> > tfp410 would use to request certain attributes from the EDID structure.
> 
> TFP410 doesn't need the EDID for anything, it just provides it as raw
> data. Parsing the EDID is done in other layers. But as you said, instead
> of tfp410 fetching the EDID and providing it, tfp410 could get the EDID
> from the i2c-edid driver and pass it forward.

Or whatever layer needs EDID would fetch it directly instead of going
through tfp410.

> > I think that would look a lot nicer as the underlying implementation for
> > requesting EDID would be completely encapsulated from its users.
> 
> If with "users" you mean, for example, tfp410, then true. But tfp410
> doesn't use EDID for anything, it just provides it. For the actual users
> of the EDID data reading the EDID is encapsulated already.

fair enough.

> >> No, reading edid is done via generic read_edid call. TFP410 uses i2c to
> >> read edid, but it could do it in any way it wants.
> > 
> > it's not very well designed, then, if tfp410 still needs to fetch the
> > i2c adapter. It still has to know about the underlying bus for reading
> > EDID.
> 
> Well, yes. TFP410 is a RGB to DVI chip. It knows that the underlying bus
> is DVI, and that there are i2c lines to read the EDID. There are no
> other option what the busses could be. So I don't see any problem with
> knowing the underlying bus.

passing i2c_bus_num should be an indicator that something is wrong with
your design. Note that not only TFP410 knows that it has an underlying
i2c bus, it needs to know exactly which bus it needs to use. Also keep
in mind that i2c bus numbers are assigned by the kernel and could be
anything. Any changes to the order of adding i2c buses, might break your
i2c_bus_num parameter.

Of course this is all hypothetical, but it shows that current design is
fragile, IMHO.

> >>> In fact current implementation is far worse than having an extra
> >>> i2c-edid.c driver because it doesn't encapsulate EDID implementation
> >>> from tfp410.
> >>>
> >>> Then moment you need to read EDID via DSI, you will likely have to pass
> >>> a DSI handle to e.g. TFP410 so it can read EDID via DSI.
> >>
> >> TFP410 is a parallel RGB to DVI chip. It's not related to DSI. The DSI
> >> case would be with some other chip.
> > 
> > it doesn't change what I said, however. Another chip will need to be
> > passed in a DVI handle.
> 
> I'm sorry, but I don't understand what you're saying above...
> 
> If we have a DSI-2-DVI chip, then reading the EDID would be done by
> sending a DSI command to the chip, which would return the EDID data.

yeah, nevermind. If it's done by a DSI-2-DVI chip, then it already _has_
the DSI handle. my bad.

> Which would be passed forward when someone requests it. There would not
> be anything in common with tfp410 and i2c implementation.
> 
> >> We could have a library with the code that does the one or two i2c
> >> reads. And while I think it'd be good, we're talking about one or two
> >> i2c reads. It wouldn't be a huge improvement.
> > 
> > fair enough... it looks like this is going nowhere, so best we come back
> > to this later. No reason to block your patch.
> 
> Well, the patch is a fix for stable kernels, so even if we had a great
> idea how to rewrite the dss device handling, it wouldn't affect this
> patch =).

ok good ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/600a6104/attachment-0001.sig>
