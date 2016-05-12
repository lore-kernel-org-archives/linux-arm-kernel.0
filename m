From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 May 2016 15:25:02 +0300
Subject: [RFC] Reset pins of phys and their representation in a device tree
In-Reply-To: <20160512071542.GC30822@pengutronix.de>
References: <20160512071542.GC30822@pengutronix.de>
Message-ID: <e75ab3a0-da5e-fef1-d5e1-65c37e7714eb@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 5/12/2016 10:15 AM, Uwe Kleine-K?nig wrote:

> I have a machine here where the reset pin of the phy is connected to a
> GPIO.
>
> There are different possibilities available today to handle this
> situation, here are the ones I'm aware of:
>
>  - Use a gpio-hog to set the reset gpio to non-active
>    This might result in dependency problems (and that's what I am
>    currently faced with) because there is no connection in the device
>    tree between the hog and the phy.
>
>  - [Documentation/devicetree/bindings/net/fsl-fec.txt]
>    The fec node supports properties
>
> 	phy-reset-gpios = <&gpio2 14 0>;
> 	phy-reset-duration = <200> /* milliseconds */;
>
>    Something similar exists in TI's vendor kernel
>    (http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/17d192b999ee904ced223c16cef76111a51c461b)
>    with different (and IMHO bader) naming.
>    This is the wrong place to specify the gpios; they shouldn't be in the
>    mac's node, but in a phy node instead.
>
> So what I actually want is to put the gpio specification in the right
> place and let it look as follows:
>
> 	mymdiobus {
> 		[...]
> 		myfirstphy: ethernet-phy at 0 {
> 			compatible = "ethernet-phy-ieee802.3-c22";
> 			reg = <0>;
>
> 			reset-gpios = <&gpio2 14 0>;
> 			reset-duration-ms = <200>;
> 		};
>
> 		mysecondphy: ethernet-phy at 2 {
> 			compatible = "ethernet-phy-ieee802.3-c22";
> 			reg = <2>;
>
> 			reset-gpios = <&gpio3 10 0>;
> 			reset-duration-ms = <200>;
> 		};
> 	};
>
> And with this we could defer probe of &myfirstphy if &gpio2 isn't
> available yet.
>
> Does this sound sensible? Does something like that already exist which I
> missed? Any further ideas/comments?

http://patchwork.ozlabs.org/patch/616495/

    I'll post a new version RSN.

> Best regards
> Uwe

MBR, Sergei
