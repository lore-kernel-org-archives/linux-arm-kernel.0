From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Sep 2018 12:55:21 +0300
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <3c048938d12a070c03f0cbdbc89c86e8@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
 <CACRpkdaUuWUHZgT0b64hMNZm3oy=7rece3H0p5VVe4d8jpFRaw@mail.gmail.com>
 <3c048938d12a070c03f0cbdbc89c86e8@agner.ch>
Message-ID: <2058139.n7KhRLb94F@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Friday, 7 September 2018 21:25:40 EEST Stefan Agner wrote:
> On 07.09.2018 00:10, Linus Walleij wrote:
> > On Thu, Sep 6, 2018 at 10:25 PM Stefan Agner <stefan@agner.ch> wrote:
> >> Ok, I read a bit up on the history of bridge timing, especially:
> >> https://www.spinics.net/lists/dri-devel/msg155618.html
> >> 
> >> IMHO, this got overengineered. For displays we do not need all that
> >> setup/sample delay timing information, and much longer cables are in
> >> use. So why is all that needed for bridges?
> > 
> > I also avoided the overhead of creating this abstraction initially.
> > 
> > But after doing it I have this Stockholm syndrome that I start
> > liking what Laurent told me to do.
> > 
> >> For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
> >> clearly states:
> >> Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
> >> 
> >> So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
> >> should be used, which makes the pl111 driver setting TIM2_IPC:
> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/inde
> >> x.html
> > 
> > That is easy to say, but if I just set that up in code, even with a good
> > comment it is hard for the next reader to understand what is going
> > on. The central question will be, why does PL111 need to do this
> > but not R-Car though they are using the same bridge?
> 
> That is something I have experienced before. Depending on drive
> strength, and I guess sampling delay etc, it might sample just late
> enough that signals are stable and no issues are really visible on the
> screen. In those cases different cabling, changes in drive strength, or
> even production variations might suddenly show artefacts though... My
> point being, just because it supposedly works, does not mean that it is
> right.
> 
> I did introduce the bus flags a while ago:
> https://patchwork.kernel.org/patch/8254801/
> https://patchwork.kernel.org/patch/8254821/
> 
> And then had to debug quite some controller and display issues around
> pixel clock polarity:
> https://patchwork.kernel.org/patch/8117181/
> https://patchwork.kernel.org/patch/9465485/
> 
> E.g. in that last case, the pixel clock polarity flags were interpreted
> wrong on both controller and display side. Hence this worked fine for
> the case already upstream, but it did not work in my case...
> 
> In the end, best thing is to look on the bus. Parallel display signals
> are still rather slow, and usually rather easy to scope.
> 
> PL111 needs to do this because its standard setting is driving on rising
> edge. However, most displays as well as that bridge sample data on
> rising edge.
> 
> I guess R-Car DU drives on negative edge by default, but can't say for
> sure without hardware/data sheet.

No, it drives on the rising edge by default.

> As far as I can tell the R-Car DU driver also does not use the
> DRM_BUS_FLAG_PIXDATA_*EDGE flags currently.

That's because the hardware default happens to work. As soon as I'll need to 
support a system that requires the other edge, I'll have to add the 
corresponding logic to the driver. So far it hasn't been needed, so I haven't 
bothered.

> > So this elaborate model gives a better transfer of abstract concepts
> > to whoever needs to touch that code next. The code is not just
> > logic, but also our map of the world and the documentation of our
> > problem space.
> > 
> > Donald Knuth has this idea about literate programming which even
> > turns the documentation/implementation process around. We are
> > not there, not even remotely, but IMO the more complex the problem.
> > the more we need to convey our thinking, not just our solution.
> 
> Fully agree.
> 
> My argument here is, that the map of the world (code) and the problem
> are not aligned.

-- 
Regards,

Laurent Pinchart
