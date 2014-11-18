From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 18 Nov 2014 14:21:59 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <546B40FA.2070409@samsung.com>
References: <20141116075928.GA9763@amd>
 <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
 <546AFEA5.9020000@samsung.com> <20141118084603.GC4059@amd>
 <546B19C8.2090008@samsung.com> <20141118113256.GA10022@amd>
 <546B40FA.2070409@samsung.com>
Message-ID: <20141118132159.GA21089@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>>@@ -19,5 +30,10 @@ Examples:
> >>>  system-status {
> >>>  	       label = "Status";
> >>>  	       linux,default-trigger = "heartbeat";
> >>>+	       iout-torch = <500 500>;
> >>>+	       iout-flash = <1000 1000>;
> >>>+	       iout-indicator = <100 100>;
> >>>+	       flash-timeout = <1000>;
> >>>+
> >>>	...
> >>>  };
> >>>
> >>>I don't get it; system-status describes single LED, why are iout-torch
> >>>(and friends) arrays of two?
> >>
> >>Some devices can control more than one led. The array is for such
> >>purposes. The system-status should be probably renamed to
> >>something more generic for both common leds and flash leds,
> >>e.g. system-led.
> >
> >No, sorry. The Documentation/devicetree/bindings/leds/common.txt
> >describes binding for _one LED_. Yes, your device can have two leds,
> >so your devices should have two such blocks in the device tree... Each
> >led should have its own label and default trigger, for example. And I
> >guess flash-timeout be per-LED, too.
> 
> I think that a device tree binding describes a single physical device.
> No matter how many sub-leds a device controls, it is still one
> piece of hardware.

You got this wrong, sorry.

In my case, there are three physical devices:

adp1653
	white LED
	red LED

Each LED should have an label, and probably default trigger -- default
trigger for red one should be "we are recording video" and for white
should be "this is flash for default camera".

If the hardware LED changes with one that needs different current, the
block for the adp1653 stays the same, but white LED block should be
updated with different value.

> default-trigger property should also be an array of strings.

That is not how it currently works.

> I agree that flash-timeout should be per led - an array, similarly
> as in case of iout's.

Agreed about per-led, disagreed about the array. As all the fields
would need arrays, and as LED system currently does not use arrays for
label and linux,default-trigger, I believe we should follow existing
design and model it as three devices. (It _is_ physically three devices.)

> >>The v4l2-flash sub-device registers with v4l2-async API
> >>in a media device. Exemplary support for v4l2-flash
> >>sub-devices is added to the exynos4-is driver in the patch [5].
> >
> >Thanks for the links. It seems that aside from moving adp1653 driver
> >to device tree, it should be moved to the LED framework, but that's a
> >topic for another patch.
> 
> Like I mentioned in the previous message the LED Flash class patch
> isn't in its final shape yet. Nonetheless I think that we should
> agree on the leds/common.txt documentation improvements and
> define DT documentation for adp1653 accordingly.

Agreed.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
