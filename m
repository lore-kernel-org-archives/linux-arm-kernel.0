From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Tue, 30 May 2017 23:23:14 +0200
Subject: [PATCH] ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes
In-Reply-To: <8c7aee6cf7184c1cb914c1eef530e2de@rwthex-w1-a.rwth-ad.de>
References: <1a13681b84564bc18937eb54b8345957@rwthex-s1-b.rwth-ad.de>
 <8c7aee6cf7184c1cb914c1eef530e2de@rwthex-w1-a.rwth-ad.de>
Message-ID: <6832964fb0644ed7a89391dc4423865f@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

thanks for the fast reply.

On 05/30/2017 10:40 PM, Fabio Estevam wrote:
> Hi Christopher,
> 
> On Tue, May 30, 2017 at 5:16 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
> 
>> +       awnh387_pwrseq: pwrseq {
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_pwrseq>;
>> +               compatible = "mmc-pwrseq-sd8787";
>> +               powerdown-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
>> +               reset-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
> 
> At least in the AW-NH387 datasheet I found it says:
> 
> RESETn: Reset(active low at least 10ns)

The BSP device tree uses an active-low regulator called nreset, too, but 
strangly it has a startup delay of 10ms while the powerdown-regulator 
"starts up" immediately.

(btw: the "regulator setup" is not able to handle resets correctly.)

It seems to me that the pwrseq-sd8787 uses inverted logic: it first sets 
the -- in our case -- active-high gpio to high, waits, and then enables 
the powerdown-gpio.

This coincides with the gpio being called "reset" in the pwrseq binding, 
neither "nreset" nor "RESETn" (beware the missing *n*ot).

> Please double check the polarity in device tree.
> 

I just double checked: high/high for powerdown/reset gpios is the only 
of the four possible combinations that works.

So, all in all, I think the polarity is correct (or either the pwrseq 
driver or hardware invertes the polarity for some reason).

Cheers,
Christopher
