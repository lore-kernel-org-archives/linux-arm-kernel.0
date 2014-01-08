From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 8 Jan 2014 17:39:31 -0500
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140108213647.GT27432@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <CAOw6vbJNgdWJvb6t7zJ0Gm6gjXuq8Yd=ySgU+zqg-Kb1j1bBvw@mail.gmail.com>
 <20140108213647.GT27432@n2100.arm.linux.org.uk>
Message-ID: <CAOw6vbLBM77Rc554ZrXq_532zwLWyeJ7N_bC22QEaTtbmCUOWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 4:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 07, 2014 at 03:18:21PM -0500, Sean Paul wrote:
>> On Thu, Jan 2, 2014 at 4:27 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > Subsystems such as ALSA, DRM and others require a single card-level
>> > device structure to represent a subsystem.  However, firmware tends to
>> > describe the individual devices and the connections between them.
>> >
>> > Therefore, we need a way to gather up the individual component devices
>> > together, and indicate when we have all the component devices.
>> >
>> > We do this in DT by providing a "superdevice" node which specifies
>> > the components, eg:
>> >
>> >         imx-drm {
>> >                 compatible = "fsl,drm";
>> >                 crtcs = <&ipu1>;
>> >                 connectors = <&hdmi>;
>> >         };
>> >
>>
>> Hi Russell,
>> This looks really good. I'd definitely like to use it for the exynos
>> drm driver both to bind the various IP blocks together, and also to
>> pull in any attached bridges that are specified in the device tree.
>> Along those lines, it might be worthwhile to pull some of the master
>> bind functionality in your next patch into drm helpers so other
>> drivers can use them, and so we have concrete bindings across drm.
>
> Which bits do you think would be useful to move into the core?
> imx_drm_add_components() is rather imx-drm specific, especially for
> the CRTCs - it carries the knowledge that the OF device to be matched
> can be found in the _parent_ device, rather than the device registered
> into the component helpers.
>

Yeah, I was thinking of imx_drm_add_components() actually. It probably
doesn't make sense to enforce the parent relationship in a generic
manner, but it would be nice to have a helper which added the various
drm components (crtc/encoder/bridge/connector) with a consistent
binding.

We have 3 different exynos boards which would have the following
superdevices (please forgive my hypothetical syntax/naming):

Board 1:
exynos-drm {
        compatible = "exynos,drm";
        crtcs = <&fimd1>, <&mixer1>;
        encoders = <&dp1>, <&hdmi1>;
        bridges = <&ptn3460 &dp1>;
        connectors = <&ptn3460>, <&hdmi1>;
};

Board 2:
exynos-drm {
        compatible = "exynos,drm";
        crtcs = <&fimd1>, <&mixer1>;
        encoders = <&dp1>, <&hdmi1>;
        bridges = <&ps8622 &dp1>, <&anx7808 &hdmi1>;
        connectors = <&ps8622>, <&anx7808>;
};

Board 3:
exynos-drm {
        compatible = "exynos,drm";
        crtcs = <&fimd1>, <&mixer1>;
        encoders = <&dp1>, <&hdmi1>;
        connectors = <&dp1>, <&hdmi1>;
};

In addition to enforcing common bindings across drivers, we could also
assign bridges to encoders from the dt. The bridge->encoder
relationship is 1:1 at the moment, and the bridge driver can be a
completely separate entity from the encoder. Allowing assignment from
the dt means the encoder never needs to know whether a bridge is
connected.

Right now the encoder must enumerate all possible bridges to see if
they are present (check out "[PATCH v3 31/32] drm/exynos: Move lvds
bridge discovery into DP driver" for an example of what I mean).

Sean

> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
