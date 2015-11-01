From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 1 Nov 2015 17:48:46 +0900
Subject: [PATCH v4 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <00d401d112ff$c426e9a0$4c74bce0$@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
 <f1fbd1a7877090f4318705f0fccbf4d96c0ebc9c.1446122247.git.p.fedin@samsung.com>
 <56330E6E.50003@samsung.com> <00d401d112ff$c426e9a0$4c74bce0$@samsung.com>
Message-ID: <5635D1EE.5010604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 30.10.2015 o 19:43, Pavel Fedin pisze:
>  Hello!
> 
>> Please, carefully look at:
>> Documentation/devicetree/bindings/net/gpmc-eth.txt
>> Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>
>> 1. Try to re-use existing bindings. Although I see existing bank-width
>> and gpmc,device-width but yours samsung,srom-data-width seems better.
>> Maybe there are other to re-use?
> 
>  I've done this and this is what i currently came up with. I'd like to discuss this before respin because nobody needs this
> back-and-forth bouncing.
> --- cut exynos5410.dtsi ---
> 		sromc: sromc at 12250000 {
> 			#address-cells = <2>;
> 			#size-cells = <1>;
> 			ranges = <0 0 0x04000000 0x20000
> 				  1 0 0x05000000 0x20000
> 				  2 0 0x06000000 0x20000
> 				  3 0 0x07000000 0x20000>;

Do you have to use 2 cells for address? Cannot it be:
 			ranges = <0 0x04000000 0x20000
 				  1 0x05000000 0x20000
 				  2 0x06000000 0x20000
 				  3 0x07000000 0x20000>;

> 
> 			compatible = "samsung,exynos-srom";
> 			reg = <0x12250000 0x14>;

Put compatible and reg at beginning.

> 		};
> --- cut exynos5410.dtsi ---
> --- cut exynos5410-smdk5410.dts ---
> &sromc {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&srom_ctl>, <&srom_ebi>;
> 
> 	ethernet at 3 {
> 		compatible = "smsc,lan9115";
> 		reg = <3 0 0x10000>;
> 		phy-mode = "mii";
> 		interrupt-parent = <&gpx0>;
> 		interrupts = <5 8>;
> 		reg-io-width = <2>;
> 		smsc,irq-push-pull;
> 		smsc,force-internal-phy;
> 
> 		samsung,srom-config = <1 9 12 1 9 1 1>;
> 	};
> };
> --- cut exynos5410-smdk5410.dts ---
> 
>  1. After writing proper ranges i was able to get rid of dedicated bank number property, because now it is the first value in
> device's "reg".

Good, I like your approach.

>  2. I noticed that smsc binding already uses reg-io-width property. I searched for it, and it appears to be reused by many devices.
> So, i decided to use it to specify bank width, since it's already there. ti-gpmc uses bank-width because it supports configurations
> like reg-io-width = 4 && bank-width = 2. I don't know if it's possible to do the same with SROMc, Exynos doc doesn't tell anything
> about 32-bit accesses. But, if you want to support it too, i would suggest the following algorithm:
>     if (have bank-width)
>         width = bank-width
>     else if (have reg-io-width)
>         width = reg-io-width
>     else
>         width = 1 /* default */

Re-using reg-io-width seems fine. In future, if needed, this can be
extended by introducing bank-width but now there is no sense in it.

>  3. About samsung,srom-config array. I have the following reasons to keep if this way:
>     - listing every property under own name is just too much typing
>     - these values really do not make sense without each other, or partialy. I would say that in array form they are even better
> readable, because it is the same order in which they go into the register.

For timings - OK. PMC is separate. This is not a timing.

> However, it is still a nice idea do document them, but...
> my PDF has "confidential" watermark on it, and this would mean that i essentially copy some information from it into Linux doc. Is
> it okay to do this?

You need to document them. We are not gonna put some data looking like a
vendor blob into the binding. I understand that document has
confidential mark... all of Samsung datasheets I've seen had it. I don't
find it as problem but of course I am not the one to judge here. If you
do not feel comfortable publishing such data, get an approval from your
manager. You can also try to search for this in vendor code
(opensource.samsung.com). If it is published there, then this won't be a
disclosure.

>  If you still dislike the array, i'll redo is a set of properties like samsung,srom-tacs, samsung,srom-tcos, etc.
> 

Ok, array for timings, but PMC IMHO is different.

BTW, your email client is weird. You are sending non-wrapped emails
without format=flowed in Content-Type. Please stick to mailing list
convention of wrapping at 72-char. It is really difficult to read your
replies.

Best regards,
Krzysztof
