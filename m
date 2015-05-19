From: dgreid@chromium.org (Dylan Reid)
Date: Tue, 19 May 2015 09:37:58 -0700
Subject: [alsa-devel] [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
In-Reply-To: <20150519111602.GG2761@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk> <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
 <555659DB.9010204@metafoo.de> <20150519111602.GG2761@sirena.org.uk>
Message-ID: <CAEUnVG6QLtV3AXjdPAp5mYDTnmNVsyLfYQmLykeLMd-KgnX+5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 4:16 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 15, 2015 at 10:40:59PM +0200, Lars-Peter Clausen wrote:
>
>> I think the proper way to support this is come up with the concept of jack
>> detection providers and consumers. A component can register a jack detection
>> provider just like it can register a DAI. And then in the board driver you'd
>> just link the jack detection logic to the jack using the usual approach,
>> which is also used for DAIs (e.g. of node or device name). The core would
>> then take care of calling a enable callback or whatever is required to setup
>> the jack detection logic in the driver.
>
> Yes, nobody has really cared about it since we started pushing things
> out of the card init into the device level.  We would also need to add a
> way to force microphone biases on for devices where that's not a part of
> the jack detection IP.
>

Can the jacks can each be an aux_dev?  The jack driver would create
the jack at probe time and register it with the card in aux_dev->init.
cht_bsw_max98090_ti.c is already doing something similar, although all
contained in the machine driver.

If the jack detection circuit is integrated with a full codec, then
the codec driver can also create the jack and register it with the
card.

Then simple-card can have an optional property to specify aux devs.  A
GPIO jack device could handle simple switch-based jack detection.
