From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 18 Apr 2018 10:41:28 +0200
Subject: [PATCH v2 5/6] drm/atmel-hlcdc: add support for connecting to
 tda998x HDMI encoder
In-Reply-To: <0155b3cc-29ce-fa43-5588-b465c6ee064a@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-6-peda@axentia.se>
 <20180418093649.2c304f29@bbrezillon>
 <0155b3cc-29ce-fa43-5588-b465c6ee064a@axentia.se>
Message-ID: <20180418104128.6747ad47@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2018 10:02:12 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-18 09:36, Boris Brezillon wrote:
> > On Tue, 17 Apr 2018 15:10:51 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> When the of-graph points to a tda998x-compatible HDMI encoder, register
> >> as a component master and bind to the encoder/connector provided by
> >> the tda998x driver.  
> > 
> > Can't we do the opposite: make the tda998x driver expose its devices as
> > drm bridges. I'd rather not add another way to connect external
> > encoders (or bridges) to display controller drivers, especially since,
> > when I asked DRM maintainers/devs what was the good approach to
> > represent such external encoders they pointed me to the drm_bridge
> > interface.  
> 
> From the cover letter:
> 
> "However, I don't know if the tilcdc driver is interfacing with the
> tda998x driver in a sane and modern way"
> 
> So, which way is the future? Should bridges become components or should
> existing bridge-like components no longer be components? Are there others?

Well, what I've been told a while ago is that drm_bridge will take over
drm_encoder_slave and custom drm_encoder/drm_connector implementations
when it comes to representing bridges.

AFAIU, using the component framework to bind all elements of the
pipeline to the display controller is orthogonal to how you represent
elements in the pipeline. I mean, you could have a bridge that
registers as a component so that display controllers drivers who want
to use the component framework don't have to re-code the
component-to-bridge glue every time, and those who don't use the
component framework can still get access to the bridge.
