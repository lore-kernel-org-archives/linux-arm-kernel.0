From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 07 Mar 2014 00:42:23 +0100
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <530F4761.2020000@ti.com>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <20140227134348.GK21483@n2100.arm.linux.org.uk> <530F4761.2020000@ti.com>
Message-ID: <1764424.18FbCM7BbM@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 16:10:41 Tomi Valkeinen wrote:
> On 27/02/14 15:43, Russell King - ARM Linux wrote:
> > That may be - but the problem with CDF solving this problem is that it's
> > wrong.  It's fixing what is in actual fact a *generic* problem in a much
> > too specific way.  To put it another way, it's forcing everyone to fix
> > the same problem in their own separate ways because no one is willing to
> > take a step back and look at the larger picture.
> > 
> > We can see that because ASoC has exactly the same problem - it has to
> > wait until all devices (DMA, CPU DAIs, codecs etc) are present before it
> > can initialise, just like DRM.  Can you re-use the CDF solution for ASoC?
> > No.  Can it be re-used elsewhere in non-display subsystems?  No.
> > 
> > Therefore, CDF is yet another implementation specific solution to a
> > generic problem which can't be re-used.
> > 
> > Yes, I realise that CDF may do other stuff, but because of the above, it's
> > a broken solution.
> 
> What? Because CDF didn't fix a particular subproblem for everyone, it's
> broken solution? Or did I miss your point?

Furthermore CDF was an RFC, a proof of concept implementation of the various 
components involved to solve the problems at hand. It was in no way meant to 
be merged as-is, and I would certainly have made the asynchronous registration 
code generic had I been requested to do so specifically. Unfortunately and 
sadly miscommunication lead to CDF being rejected in one block with a fuzzy 
message on how to proceed. We won't rewrite the past, but let's move forward 
in the right direction.

> The main point of CDF is not solving the initialization issue. If that
> was the point, it would've been Common Initialization Framework.
> 
> The main point of CDF is to allow us to have encoder and panel drivers
> that can be used by all platforms, in complex display pipeline setups.
> It just also has to have some solution for the initialization problem to
> get things working.
> 
> In fact, Laurent's CDF version has a solution for init problem which, I
> my memory serves me right, is very much similar to yours. It just wasn't
> generic. I don't remember if Laurent had a specific master node defined,
> but the LCD controller was very much like it. It would be trivial to
> change it to use the component helpers.

That's correct. The CDF composite device model was based on the V4L2 composite 
device model, implemented in drivers/media/v4l2-core/v4l2-async.c. Both are 
very similar in purpose to the component framework. The reason why it wasn't 
generic in the first place was that I wanted to implement a full solution as a 
proof of concept first between polishing each part independently. That turned 
out not to be the best decision ever.

> My solution is different, because I don't like the idea of requiring all
> the display components to be up and running to use any of the displays.
> In fact, it's not a solution at all for me, as it would prevent displays
> working on boards that do not have all the display components installed,
> or if the user didn't compile all the drivers.

As mentioned in my reply to Russell's component framework patch, I would like 
to base v4l2-async on top of the component framework. For this to be possible 
we need support for partial bind in the component framework, which would make 
it possible to support your use cases. Let's discuss how to achieve that in 
the other mail thread.

-- 
Regards,

Laurent Pinchart
