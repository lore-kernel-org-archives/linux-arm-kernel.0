From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 23 Oct 2015 07:31:25 +0200
Subject: [PATCH] pinctrl-zynq: Initialize early
In-Reply-To: <20151022160733.GH5257@xsjsorenbubuntu>
References: <1445513420-23527-1-git-send-email-mike.looijmans@topic.nl>
 <20151022160733.GH5257@xsjsorenbubuntu>
Message-ID: <5629C62D.8030804@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 22-10-15 18:07, S?ren Brinkmann wrote:
> Hi Mike,
>
> On Thu, 2015-10-22 at 01:30PM +0200, Mike Looijmans wrote:
>> Supplying pinmux configuration for e.g. gpio pins leads to deferred
>> probes because the pinctrl device is probed much later than gpio.
>> Move the init call to a much earlier stage so it probes before the
>> devices that may need it.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>
> in general, the change should be OK, but neither on zc702 nor zc706 do I
> see a difference in respect to deferred probes. With and without the
> patch I see:
>      root at zynq:~# dmesg | grep -i defer
>      [    0.097021] zynq-gpio e000a000.gpio: could not find pctldev for node /amba/slcr at f8000000/pinctrl at 700/gpio0-default, deferring probe
>      root at zynq:~#
>
> If you have a case this patch improves things though, feel free to add my
> Tested-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>

On the Florida boards there are i2c controlled clocks, power supplies and 
reset signals. Replacing the Cadence I2C controller with a GPIO-bitbang 
controller solved the I2C problems but caused a storm of dozens of deferred 
probes because of the pinmux driver arriving even after the first probe 
attempt of the i2c bus driver. Moving the pinmux driver to an earlier stage 
solved that problem neatly, now the "zynq-pinctrl 700.pinctrl: zynq pinctrl 
initialized" message appears after the OCM driver.
Judging from your comment the GPIO driver still probes earlier (I don't have 
any GPIO-only pinmuxes yet), so maybe we should amend the patch to probe even 
earlier. The pinmux driver doesn't depend on anything, so it can potentially 
probe very early. What do you think?

Mike.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

Visit us at : Aerospace Electrical Systems Expo Europe which will be held from 17.11.2015 till 19.11.2015, Findorffstrasse 101 Bremen, Germany, Hall 5, stand number C65
http://www.aesexpo.eu
