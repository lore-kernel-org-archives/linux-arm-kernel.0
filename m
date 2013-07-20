From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Jul 2013 18:40:52 +0200
Subject: [PATCH v4] watchdog: Add MOXA ART watchdog driver
In-Reply-To: <1374229402-20432-1-git-send-email-jonas.jensen@gmail.com>
References: <1374053091-5907-1-git-send-email-jonas.jensen@gmail.com>
 <1374229402-20432-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201307201840.52455.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 July 2013, Jonas Jensen wrote:
> diff --git a/Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt b/Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt
> new file mode 100644
> index 0000000..5507f2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt
> @@ -0,0 +1,15 @@
> +MOXA ART Watchdog timer
> +
> +Required properties:
> +
> +- compatible : Should be "moxa,moxart-watchdog"
> +- reg : Should contain registers location and length
> +- clocks : Should contain phandle for the MOXA ART core clock "coreclk"
> +
> +Example:
> +
> +       watchdog: watchdog at 98500000 {
> +               compatible = "moxa,moxart-watchdog";
> +               reg = <0x98500000 0x10>;
> +               clocks = <&coreclk>;
> +       };

I think the property descriptions need to be clarified here:

* I think "should" makes no sense for the "compatible" property since it is
  required here, you probably mean "must", see http://www.ietf.org/rfc/rfc2119.txt. 

* for the clock, make sure that the description is from the point of view of
  the device you are describing, not from the perspective of the clock controller.
  The device should not make any assumptions about who provides a clock, only
  what it is used for, and it sounds like "coreclk" is an SoC-wide identifier,
  not the name of the clock input of the watchdog device. This is not as important
  as you don't define a "clock-names" property here, butsomething to keep in
  mind anyway.

	Arnd
