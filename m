From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Sep 2017 15:26:40 +0200
Subject: [PATCH 2/2] RFC: drm/pl111: Support using the VGA bridge as
 fallback
In-Reply-To: <4828013.uWK28amVrN@avalon>
References: <20170901094629.6566-1-linus.walleij@linaro.org>
 <20170904074355.gjbf7he2dt5kszfg@phenom.ffwll.local>
 <4828013.uWK28amVrN@avalon>
Message-ID: <CACRpkdYNmku09W3wSFEpX7j8M_8d3w1RPoNhxm7hBDYqAuuBvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 4, 2017 at 11:51 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday, 4 September 2017 10:43:55 EEST Daniel Vetter wrote:
>> On Fri, Sep 01, 2017 at 11:46:29AM +0200, Linus Walleij wrote:

>> Wrt the more general problem: They way we solve this in the i915 atomic
>> framework is that the various ->fixup calls fill out relevant fields in
>> the drm_crtc_state. I guess we could add an ->atomic_check to bridges, add
>> a bus_flags to drm_crtc_state (or maybe just let everyone patch up
>> adjusted_mode->flags) instead?
>
> Furthermore, if we needed to have access to the connector in the display
> controller driver, this would call for creating the connector there, not in
> the bridge driver. I've advocated this for a long time, and still haven't
> given up all hopes of fixing it.

Hm as it is I am trying to adopt to circumstances, so I was just asked
to replace the custom connector with the generic panel bridge.
(bridge/panel.c)

Then we get the connector out of the generic panel bridge by just
dereferencing panel->connector, this is what the PL111 driver
is already doing for panels since its inception.

Maybe that is wrong, I don't know :/

But like Eric says, the core problem is that the display driver
say enable function needs to know the flags of what it should
output. This driver looks at

connector->display_info.bus_flags & DRM_BUS_FLAG_DE_LOW
connector->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE

So the bus flags really need to be available somehow.
I am doing it by keeping a local reference to the connector
in the driver state container.

I tried to dereference the connector from from the pipe at one
point, passing NULL to  but it didn't work out, it seems like
struct drm_simple_display_pipe_funcs
.enable() is called before attaching the connector or something
but I guess I should look closer.

Yours,
Linus Walleij
