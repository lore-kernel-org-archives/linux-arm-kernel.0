From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 06 Feb 2015 11:05:39 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <20150206085855.7b8d494b@armhf>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
 <54CB6440.1010002@gmail.com> <20150130124144.501cf81d@armhf>
 <54CB732F.7010409@gmail.com> <20150130133913.083d1ade@armhf>
 <54CB7E33.3080909@gmail.com> <54CE354F.5090106@gmail.com>
 <54D3EB26.9020909@gmail.com> <20150206085855.7b8d494b@armhf>
Message-ID: <54D491F3.9060004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.02.2015 08:58, Jean-Francois Moine wrote:
> On Thu, 05 Feb 2015 23:13:58 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>>> At this moment, I am trying to configure the framebuffer, but as Moine
>>> told me,it seems there is not video driver support for this board in
>>> DT... :( .
>>
>> Not quite true. Video is made up of at least 4 different devices:
>> Framebuffer, GPU, Decode engine, and usually DVI/HDMI transmitter or
>> VGA.
>>
>> We do have a driver for the framebuffer (armada_drm) and there is great
>> work from Russell King and others on the GPU and Decode engine (IIRC).
>
> Yes, but it has no DT support. Mine has.

Yeah, it would be nice if you two stick together once again and work
that out for mainline?

>> If you are using the sb-a510, I can see from the manual, that DVI
>> transmitter is SIL164.. AFAIS there is a driver for it, that maybe
>> needs some polishing. Nobody ever tested VGA, but it shouldn't be too
>> hard to add support for it as it is directly supported by the
>> framebuffer HW.
>
> This asks for some VGA encoder/connector module.

Hmm, maybe it is just enough to tell the DRM driver to switch to
VGA and what i2c to use for DDC. I'll have to catch up with DRM
and DT.

> Actually, as Gabriel told me that his screen is directly connected to
> the RGB LCD output, I wrote a simple panel for him. This module just
> gets the display timings from the DT.

Ok. That makes it less complicated as there already should be support
for dumb RGB anyway.

>> One quite important driver at least for Dove is a clock source for
>> video. Internal clock generators for video are way to limited with
>> respect to frequencies to allow any useful resolution.
>
>  From my previous tests with the si5351 in the Cubox, most video modes
> should work without external clocks.

Well, this is not about a working corner case.. video modes are (more or
less) standardized and so is the clock frequency. Monitors are allowed
to reject any non-standard modes and it gets worse with TVs.

Ergo, we do want to hit the frequency as close as possible and Dove's
internal PLL simply cannot.

Sebastian
