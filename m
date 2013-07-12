From: dsd@laptop.org (Daniel Drake)
Date: Fri, 12 Jul 2013 13:00:23 -0600
Subject: DT binding review for Armada display subsystem
In-Reply-To: <20130712203952.6b7aa927@armhf>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <20130712203952.6b7aa927@armhf>
Message-ID: <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 12:39 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> - I think it is better to keep the names 'lcd' for the memory to dumb panel
>   sub-devices and 'dcon' for the dumb panel to LCD/VGA sub-device, as
>   named in the spec.

I agree it is worth keeping the spec-defined names, if they do not
cause excessive confusion when mixed with the spec-defined names for
MMP2/MMP3. I'll check the spec you pointed out, thanks.

> - the phandles to the clocks does not tell how the clock may be set by
>   the driver (it is an array index in the 510).

In the other threads on clock selection, we decided that that exact
information on how to select a clock (i.e. register bits/values) must
be in the driver, not in the DT. What was suggested there is a
well-documented scheme for clock naming, so the driver knows which
clock is which. That is defined in the proposed DT binding though the
"valid clock names" part. For an example driver implementation of this
you can see my patch "armada_drm clock selection - try 2".

> - I don't see the use of the phandles in the leaves (dcon and tda998x).

That is defined by the video interfaces common binding. I'm not
immediately aware of the use, but the ability to easily traverse the
graph in both directions seems like a requirement that could easily
emerge from somewhere.

> Well, here is how I feel the DTs:
>
> - for the Cubox (one LCD, the DCON is not used, TDA998x for HDMI/DVI
>   output):

That is the same as my proposal except you have decided to use direct
phandle properties instead of using the common video interfaces
binding (which is just a slightly more detailed way of describing such
links). In the "best practices" thread, the suggestion was raised
multiple times of doing what v4l2 does, so thats why I decided to
explore this here.

> - for some tablet based on the Armada 510 with a LCD and a VGA connector:
>
>         video {
>                 compatible = "marvell,armada-video";
>                 marvell,video-devices = <&lcd0>, <&lcd1>, <&dcon>
>         };

This proposal is slightly different because it does not describe the
relationship between the LCD controllers and the DCON. Focusing
specifically on LCD1, which would be connected to a DAC via a phandle
property in your proposal. The interconnectivity between the
components represented as a graph (and in the v4l2 way, which includes
my proposal) would be:

LCD1 --- DCON --- DAC

However your phandle properties would "suggest" that LCD1 is directly
connected to the DAC. The driver would have to have special knowledge
that the DCON sits right in the middle. Maybe that is not an issue, as
it is obviously OK for the driver to have *some* knowledge about how
the hardware works :)

I don't think we have a full consensus on whether we want to go the
"v4l2 way" here. But I figured that would be a good thing to propose
in a first iteration to have a clearer idea of what the result would
look like. It sounds like you are not overly keen on it, I would be
interested to hear exactly why.

Thanks,
Daniel
