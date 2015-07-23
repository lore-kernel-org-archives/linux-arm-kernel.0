From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 23 Jul 2015 10:01:01 +0200
Subject: [PATCH v6 2/2] mfd: atmel-flexcom: add a driver for Atmel
 Flexible Serial Communication Unit
In-Reply-To: <20150723073217.GT3061@x1>
References: <cover.1437558598.git.cyrille.pitchen@atmel.com>
 <7639e02fc2b16dc20b19fbe3bbbb986b0f3b9887.1437558598.git.cyrille.pitchen@atmel.com>
 <20150723073217.GT3061@x1>
Message-ID: <20150723100101.7290242b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 23 Jul 2015 08:32:17 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Wed, 22 Jul 2015, Cyrille Pitchen wrote:
> > +	for_each_child_of_node(np, child) {
> > +		const char *compatible;
> > +		int cplen;
> > +
> > +		if (!of_device_is_available(child))
> > +			continue;
> > +
> > +		compatible = of_get_property(child, "compatible", &cplen);
> > +		if (!compatible || strlen(compatible) > cplen)
> > +			continue;
> > +
> > +		if (strstr(compatible, "-usart")) {
> > +			opmode = FLEX_MR_OPMODE_USART;
> > +			break;
> > +		}
> > +
> > +		if (strstr(compatible, "-spi")) {
> > +			opmode = FLEX_MR_OPMODE_SPI;
> > +			break;
> > +		}
> > +
> > +		if (strstr(compatible, "-i2c")) {
> > +			opmode = FLEX_MR_OPMODE_TWI;
> > +			break;
> > +		}
> > +	}
> 
> From what I understand Flexcom is a wrapper which can sit above any
> number of SPI, I2C and/or UART devices.  Devices which you don't
> really have any control over (source code wise).  So wouldn't it be
> better to match on the details you do have control over i.e. the node
> name, rather than the compatible string?
> 
> I would personally match on of_find_node_by_name() to future-proof
> your implementation.

Actually, I think using compatible strings is more future-proof than
using the node names, because nothing in the DT bindings doc enforce the
node name, and usually what we use to attach a node to a specific
driver is the compatible string (this one is specified in the bindings
doc).

Regarding the implementation itself, I would match the child node with
an of_device_id table rather than trying to find a specific substring
in the compatible string, but I think that's only a matter of taste.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
