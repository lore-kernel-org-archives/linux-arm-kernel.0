From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 19 May 2013 10:30:00 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <20130519080152.0b486b75@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf> <5197D6C1.3060702@gmail.com>
 <20130519080152.0b486b75@armhf>
Message-ID: <51988D88.10306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2013 08:01 AM, Jean-Francois Moine wrote:
> On Sat, 18 May 2013 21:30:09 +0200
> Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
>> So in the end, we will have a DT node for the HW controllers found
>> in Dove SoCs, a node for TDA998x, and a node for the video card, i.e.
>> _how_ lcd controllers, external encoders, clocks, maybe audio, ...
>> are hooked up on that specific board.
>
> Here is my dove-cubox.dts. What is wrong with it?

Oh come on, seriously?

There is _nothing_ wrong with it, it already reflects what I told you
would be required for generic Dove SoC board video.

> 	video {
> 		compatible = "marvell,dove-video";
> 	};

As you may have noticed, the RFC node I sent yesterday. Is in _no_ way
different from a functional point of view. I added a video-memory
property, I renamed the compatible string. And I moved clocks property
to the video card *but* as I said in the RFC description:

"This adds a video card node required for rmk's dove_drm driver. Reg
property matches reserved memory region (currently 16M at top of 
memory), clocks property should carry extclk0 for now."

It is a node *required for rmk's dove_drm driver* for you to _test_
that very driver.

> &lcd0 {
> 	status = "okay";
> 	clocks =<&core_clk 3>,<0>,<&lcdclk>,<&si5351 0>;
> 	marvell,port-type =<11>;		/* HDMIA */
> 	marvell,external-encoder =<&tda998x>;
> };

Again, there is no DT support in *rmk's driver*! I didn't add those
to the RFC node. I provided a DT node to *test* rmk driver. While
you were busy with complaining about things we already answered,
I did test the driver on both Cubox and D2Plug. Now I can start
with looking into rmk's driver and _suggest_ to fix this or that.

> /* --- test (not cubox) ---- *
> &dcon { status = "okay"; };
>
> &lcd1 {
> 	status = "okay";
> 	clocks =<&core_clk 3>,<0>,<&lcdclk>,<0>;
> 	marvell,port-type =<1>;
> 	display-timings {
> 		mode {
> 			hactive =<1920>;
> 			vactive =<1080>;
> 			hfront-porch =<88>;
> 			hsync-len =<44>;
> 			hback-porch =<148>;
> 			vfront-porch =<4>;
> 			vsync-len =<5>;
> 			vback-porch =<36>;
> 			clock =<148500>;
> 		};
> 	};

I would be surprised if, lcd1 will ever be capable of driving
1080p60 on a *VGA port*!

Seriously, start _reading_ what we say. I want all those
features I already told you for your driver, in mainline driver
too. All I told you was to prevent you from doing dirty little
Cubox specific hacks that I would have to remove for e.g. D2Plug.

*But* if you ask me if we should take Russell's or your driver
as a basis, the answer is Russell's. Colon.

Sebastian
