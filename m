From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 29 Apr 2016 10:56:49 +0300
Subject: v4l subdevs without big device was Re:
 drivers/media/i2c/adp1653.c: does not show as /dev/video* or v4l-subdev*
In-Reply-To: <57230DE7.3020701@xs4all.nl>
References: <20160428084546.GA9957@amd> <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
Message-ID: <20160429075649.GG32125@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans and Pavel,

On Fri, Apr 29, 2016 at 09:31:51AM +0200, Hans Verkuil wrote:
> On 04/29/2016 09:15 AM, Pavel Machek wrote:
> > Hi!
> > 
> >> On n900, probe finishes ok (verified by adding printks), and the
> >> device shows up in /sys, but I  don't get /dev/video* or
> >> /dev/v4l-subdev*.
> >>
> >> Other drivers (back and front camera) load ok, and actually work. Any
> >> idea what could be wrong?
> > 
> > Ok, so I guess I realized what is the problem:
> > 
> > adp1653 registers itself as a subdev, but there's no device that
> > register it as its part.
> > 
> > (ad5820 driver seems to have the same problem).
> > 
> > Is there example "dummy" device I could use, for sole purpose of
> > having these devices appear in /dev? They are on i2c, so both can work
> > on their own.
> 
> Ah, interesting. This was discussed a little bit during the Media Summit
> a few weeks back:
> 
> http://linuxtv.org/news.php?entry=2016-04-20.mchehab
> 
> See section 5:
> 
> "5. DT Bindings for flash & lens controllers
> 
> There are drivers that create their MC topology using the device tree information,
> which works great for entities that transport data, but how to detect entities
> that don?t transport data such as flash devices, focusers, etc.? How can those be
> deduced using the device tree?
> 
> Sensor DT node add phandle to focus controller: add generic v4l binding properties
> to reference such devices."
> 
> This wasn't a problem with the original N900 since that didn't use DT AFAIK and
> these devices were loaded explicitly through board code.
> 
> But now you run into the same problem that I have.
> 
> The solution is that sensor devices have to provide phandles to those controller
> devices. And to do that you need to define bindings which is always the hard part.
> 
> Look in Documentation/devicetree/bindings/media/video-interfaces.txt, section
> "Optional endpoint properties".
> 
> Something like:
> 
> controllers: an array of phandles to controller devices associated with this
> endpoint such as flash and lens controllers.
> 
> Warning: I'm no DT expert, so this is just a first attempt.
> 
> Platform drivers (omap3isp) will have to add these controller devices to the list
> of subdevs to load asynchronously.

I seem to have patches I haven't had time to push back then:

<URL:http://salottisipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=~sailus/linux.git;a=shortlog;h=refs/heads/leds-as3645a>

This seems to be mostly in line with what has been discussed in the meeting,
except that the patches add a device specific property. Please ignore the
led patches in that tree for now (i.e. four patches on the top are the
relevant ones here).

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
