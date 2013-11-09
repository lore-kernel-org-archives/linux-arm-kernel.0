From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Nov 2013 10:28:36 +0000
Subject: imx-drm: Add HDMI support
In-Reply-To: <CAHCPf3uMnMgTH_ywpuWM5x-1vcvsEVHN8dn6=b26_-s75msbVA@mail.gmail.com>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
 <20131030190123.GM16735@n2100.arm.linux.org.uk>
 <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
 <20131107172920.GH16735@n2100.arm.linux.org.uk>
 <CAHCPf3unnmGDD2jGJYHdmYFALdcNa9OcWejLpUdzaxATSAyjSQ@mail.gmail.com>
 <20131109005317.GW16735@n2100.arm.linux.org.uk>
 <CAHCPf3uMnMgTH_ywpuWM5x-1vcvsEVHN8dn6=b26_-s75msbVA@mail.gmail.com>
Message-ID: <20131109102836.GX16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 12:11:51AM -0600, Matt Sealey wrote:
> That's exactly what I was saying in the first place, and what Alex
> Duecher said to me a year ago after I spent 2 days straight crashing
> an i.MX51 trying to figure out a way to get the connector to ask the
> CRTC for the right information.

I still completely disagree with you on that.  I've yet to see a
situation where you have different restrictions on what can be done
depending on which "CRTC" in the SoC you connect an interface to.

> In the case of "card drivers" for DRM,  on the kernel side, having a
> "card" driver per board to micromanage settings will get as unwieldy
> as having multiple platform-specific xorg-video-modesetting patches,

*sigh* completely the wrong end of the stick, and I bet most of the rest
of this email is pounded out based on that.

> I am betting the one you "have *right* *now*" is the above, you wrote
> a driver which, given a very specific set of device tree entries with
> specific compatible properties in combination, specifically
> initializes several i.MX6-specific components together in the right
> order. This also won't scale, going forward.

What utter rubbish.  I have nothing further to add other than you are
wrong.  I'm not going to give you any further information for you to
pound your poor keyboard with to compose another verbose reply which
has the wrong end of the stick.

> > If you'd like to rephrase in a more concise manner then I may read
> > your message.
> 
> Maybe I am just not explaining it well enough. Here it is in the
> shortest way I can do it.
> 
> * i.MX6Q - two discrete IPU with two DI. IPU have independent clock,
> up to 200MHz for HSC.
> * i.MX53/50 - one discrete IPU with two DI. IPU clock up to 150MHz for HSC.
> * i.MX51 - one discrete IPU with two DI. IPU clock up to 133MHz for HSC.
> 
> Same driver.

Right, so what you've just told me in a concise way is that the
restrictions are per-SoC, not per-CRTC as you've just been claiming in
your rediculously verbose emails (the rest of your email cut without
reading.)

So what we do is we arrange for the imx-drm connector layers to call
into the imx-drm-core layer, to ask the imx-drm CRTC layer what the
maximum pixel clock is.

We then have the connector compare the maximum pixel clock rate with
the clock rate required for the mode, and if the mode has a pixel
clock rate greater than the CRTC can provide, we return MODE_CLOCK_HIGH.

If done correctly, this doesn't require any code in the connector
layer: you arrange for imx-drm-core to provide a _generic_ cross-
connector function which provides this information, and you point
the connector's .mode_valid at that generic function.

There is no problem here.
