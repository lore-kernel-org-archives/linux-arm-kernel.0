From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Apr 2018 15:55:41 +0100
Subject: [PATCH 1/2 v4] drm/pl111: Support the Versatile Express
In-Reply-To: <CACRpkdaQ+9+6OHk7s=vsTF=CesMLyKQmN2O3U3pVUa0RRSnxOA@mail.gmail.com>
References: <20180423072017.6690-1-linus.walleij@linaro.org>
 <4255fd6b-caf7-1347-b97b-ab7b229a08ba@arm.com>
 <CACRpkdYpMsGOTPU81cO92DFSrzt659UmD_p5uKehBWnZk-cjnw@mail.gmail.com>
 <c9d69109-1220-b201-e1bd-255c31c1a214@arm.com>
 <CACRpkdaQ+9+6OHk7s=vsTF=CesMLyKQmN2O3U3pVUa0RRSnxOA@mail.gmail.com>
Message-ID: <14c7fb88-120c-5aa6-e1f3-a26650e857c3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/18 19:51, Linus Walleij wrote:
> On Fri, Apr 27, 2018 at 5:02 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> I dug a little bit and it seems pl111_modeset_init() is deferring because it
>> can't find endpoint 0. And given that that's apparently pointing at some
>> non-existent panel rather than the DVI encoder as I would (naively) expect,
>> I can at least form a self-consistent explanation and give up on the grounds
>> that I'm probably missing some important DT changes.
> 
> Yeah it does help if I also send the required DT changes :/
> 
> Sorry for my absentmindedness, I'll shoot it off right now so you
> can test it.

Hooray, thanks for that.

For these 2 patches with a V2P-CA15_A7 tile and the DT fixed up,

Tested-by: Robin Murphy <robin.murphy@arm.com>

Framebuffer console and /dev/fb0 access for the motherboard CLCD works, 
and it keeps out of the way as expected with CONFIG_DRM_HDLCD=y. I can't 
convince an X session to start, but that appears more to do with sii902x 
falling apart*, which I can't be bothered to even try debugging.

Robin.


*specifically, lots of this, which I imagine is related to xorg trying 
to either read the EDID or change mode:
...
[  243.439669] i2c i2c-0: sendbytes: NAK bailout.
[  243.454247] i2c i2c-0: sendbytes: NAK bailout.
[  247.743261] i2c i2c-0: sendbytes: NAK bailout.
[  247.770281] sii902x 0-0039: failed to read status (-6)
[  247.786609] i2c i2c-0: sendbytes: NAK bailout.
[  248.118522] i2c i2c-0: sendbytes: NAK bailout.
[  248.145485] sii902x 0-0039: failed to read status (-6)
[  248.177800] i2c i2c-0: sendbytes: NAK bailout.
[  258.256500] i2c i2c-0: sendbytes: NAK bailout.
[  258.274763] i2c i2c-0: sendbytes: NAK bailout.
[  268.499637] i2c i2c-0: sendbytes: NAK bailout.
[  268.517899] i2c i2c-0: sendbytes: NAK bailout.
...
