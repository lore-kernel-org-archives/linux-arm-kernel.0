From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 06 Sep 2018 19:54:37 +0300
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <d07214d3005fb7229f17dd62d1b5b8ee@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
 <10044412.4MiZRujKJI@avalon> <d07214d3005fb7229f17dd62d1b5b8ee@agner.ch>
Message-ID: <1611934.U20VZ57ca3@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Thursday, 6 September 2018 19:48:51 EEST Stefan Agner wrote:
> On 06.09.2018 05:25, Laurent Pinchart wrote:
> > On Thursday, 6 September 2018 14:07:41 EEST Linus Walleij wrote:
> >> On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
> >> > On 05.09.2018 00:44, Laurent Pinchart wrote:
> >> > 
> >> > Good point! I actually really don't like that we use the same flags
> >> > here
> >> > but from a different perspective. Especially since the flags defines
> >> > document things differently:
> >> > 
> >> > /* drive data on pos. edge */
> >> > #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> >> > /* drive data on neg. edge */
> >> > #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
> >> 
> >> Maybe a stupid comment from my side, but can't we just change the
> >> documentation to match the usecases?
> >> 
> >> /* Trigger pixel data latch on positive edge */
> >> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> > 
> > The flags are used for the drm_connector bus_flags field, and really mean
> > driving on the positive/negative edges. We this can't change their meaning
> > like this.
> > 
> >> > Using the opposite perspective would also need translation in crtc
> >> > drivers... So far no driver uses sampling_edge.
> >> > 
> >> > I would prefer if we always use the meaning as documented by the flags.
> >> > 
> >> > I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
> >> > DRM_BUS_FLAG_PIXDATA_NEGEDGE.
> >> > 
> >> > Linus Walleij, you added sampling edge, any thoughts?
> >> 
> >> I just thought it was generally useful to have triggering edge encoded
> >> into the bridge as it makes it clear that this edge is something
> >> that is a delayed version of the driving edge which is subject to
> >> clock skew caused by the speed of electrons in silicon and
> >> copper and slew rate caused by parasitic capacitance.
> > 
> > I agree that we need both the driving and sampling edge. In many case they
> > will be opposite, and providing some kind of appropriate defaults in APIs
> > is fine by me, but we need a way to specify both when needed.
> 
> We do have pixel clock flags for displays, but also they are actually
> controller oriented:
> 
> https://elixir.bootlin.com/linux/latest/source/include/video/display_timing.
> h#L15
> 
> I guess having different flags to denote driving and sampling edge
> independently would be ideal. But then, is there really a use case where
> it wouldn't be the exact opposite?

Yes, for instance when the transmission delay for clock and data signals is 
different, you may want to sample on the same edge used by the transmitter to 
latch the output. Linus had that case, which prompted him to add the sampling 
edge field.

> The other bus flags are actually fine as is. I suggest to just stick
> with the bus flags as we have them now, at least for now.
> 
> Alternatively, we could provide "consumer/bridge" oriented flags which
> use the same bit and just are the opposite of the controller oriented
> flags, e.g.:
> 
> /* drive data on pos. edge */
> #define DRM_BUS_FLAG_PIXDATA_POSEDGE	(1<<2)
> /* drive data on neg. edge */
> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE	(1<<3)
> /* sample data on neg. edge */
> #define DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE	(1<<2)
> /* sample data on pos. edge */
> #define DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE	(1<<3)

-- 
Regards,

Laurent Pinchart
