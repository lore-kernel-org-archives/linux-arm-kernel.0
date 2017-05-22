From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 May 2017 20:21:19 +0200
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <076f6258-f0b4-6ba5-9670-e2c0582a92b5@cogentembedded.com>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
 <a74ee28c1c62fee5a5e75dda70a02990@agner.ch>
 <076f6258-f0b4-6ba5-9670-e2c0582a92b5@cogentembedded.com>
Message-ID: <20170522182119.GN29447@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 07:29:14PM +0300, Nikita Yushchenko wrote:
> >> +	hi8435 at 1 {
> >> +		compatible = "holt,hi8435";
> >> +		reg = <1>;
> >> +		spi-max-frequency = <20000000>;
> >> +		gpios = <&gpio5 3 0>;
> > 
> > Nit: GPIO_ACTIVE_HIGH instead of 0?
> 
> Gray area here.
> 
> Chip's reset input is active LOW.

Nikita

There second issue here is that you are going to be getting newbies
looking at .dts files and submitting patches to replace the 0 with
GPIO_ACTIVE_HIGH in all files, just like they submit patches fixing
checkpatch warnings. 

> However, hi8435 driver historically was coded using inverted values
> passed to gpiolib calls.  And there are setups in the wild with device
> trees containing GPIO_ACTIVE_HIGH that I'd prefer not breaking.
> 
> To solve, I submitted a patch on hi8435 driver that changes to _raw()
> gpio calls (thus making it independent of what is written in device
> tree), and want [future] device trees not to contain explicitly written
> gpio polarity.

So maybe add another #define, GPIO_ACTIVE_IGNORED, to make it clear
that it does not matter what value you put there, it is ignored.

     Andrew
