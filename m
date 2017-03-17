From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Mar 2017 11:34:45 +0800
Subject: [PATCH 7/15] dt-bindings: display: sun4i: Add allwinner,
 tcon-channel property
In-Reply-To: <20170315173753.6zywfxapdczu2i34@rob-hp-laptop>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <46fdec2d680d539652f87d79c627973b3a568438.1488876832.git-series.maxime.ripard@free-electrons.com>
 <20170315173753.6zywfxapdczu2i34@rob-hp-laptop>
Message-ID: <CAGb2v67A2T4KeLBttAGLKoo7igBTnQH+5yxN-jJo1k7Ewfd9mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 1:37 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 07, 2017 at 09:56:26AM +0100, Maxime Ripard wrote:
>> The Allwinner Timings Controller has two, mutually exclusive, channels.
>> When the binding has been introduced, it was assumed that there would be
>> only a single user per channel in the system.
>>
>> While this is likely for the channel 0 which only connects to LCD displays,
>> it turns out that the channel 1 can be connected to multiple controllers in
>> the SoC (HDMI and TV encoders for example). And while the simultaneous use
>> of HDMI and TV outputs cannot be achieved, switching from one to the other
>> at runtime definitely sounds plausible.
>>
>> Add an extra property, allwinner,tcon-channel, to specify for a given
>> endpoint which TCON channel it is connected to, while falling back to the
>> previous mechanism if that property is missing.
>
> I think perhaps TCON channels should have been ports rather than
> endpoints. The fact that the channels are mutually exclusive can be
> handled in the driver and doesn't really matter in the binding. How
> painful would it be to rework things to move TCON channel 1 from port 0,
> endpoint 1 to port 1?

Having a separate output port for channel 1 was one option we discussed.
However it wouldn't work well with the kernel's of_graph based crtc
detection (drm_of_find_possible_crtcs / drm_of_find_possible_crtcs),
which has the crtcs bound via the output port. As the logic is used
by multiple drivers, I'm not sure it's easy to rework or test.

Also, we still have to support old device trees using channel 1 from
output port 0 endpoint 1. This is the TV encoder on sun5i (A10s/A13/R8).

Regards
ChenYu
