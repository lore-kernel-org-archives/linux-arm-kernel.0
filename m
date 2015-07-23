From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jul 2015 10:13:11 +0100
Subject: [PATCH v6 2/2] mfd: atmel-flexcom: add a driver for Atmel
 Flexible Serial Communication Unit
In-Reply-To: <20150723100101.7290242b@bbrezillon>
References: <cover.1437558598.git.cyrille.pitchen@atmel.com>
 <7639e02fc2b16dc20b19fbe3bbbb986b0f3b9887.1437558598.git.cyrille.pitchen@atmel.com>
 <20150723073217.GT3061@x1> <20150723100101.7290242b@bbrezillon>
Message-ID: <20150723091311.GX3061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jul 2015, Boris Brezillon wrote:

> Hi Lee,
> 
> On Thu, 23 Jul 2015 08:32:17 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Wed, 22 Jul 2015, Cyrille Pitchen wrote:
> > > +	for_each_child_of_node(np, child) {
> > > +		const char *compatible;
> > > +		int cplen;
> > > +
> > > +		if (!of_device_is_available(child))
> > > +			continue;
> > > +
> > > +		compatible = of_get_property(child, "compatible", &cplen);
> > > +		if (!compatible || strlen(compatible) > cplen)
> > > +			continue;
> > > +
> > > +		if (strstr(compatible, "-usart")) {
> > > +			opmode = FLEX_MR_OPMODE_USART;
> > > +			break;
> > > +		}
> > > +
> > > +		if (strstr(compatible, "-spi")) {
> > > +			opmode = FLEX_MR_OPMODE_SPI;
> > > +			break;
> > > +		}
> > > +
> > > +		if (strstr(compatible, "-i2c")) {
> > > +			opmode = FLEX_MR_OPMODE_TWI;
> > > +			break;
> > > +		}
> > > +	}
> > 
> > From what I understand Flexcom is a wrapper which can sit above any
> > number of SPI, I2C and/or UART devices.  Devices which you don't
> > really have any control over (source code wise).  So wouldn't it be
> > better to match on the details you do have control over i.e. the node
> > name, rather than the compatible string?
> > 
> > I would personally match on of_find_node_by_name() to future-proof
> > your implementation.
> 
> Actually, I think using compatible strings is more future-proof than
> using the node names, because nothing in the DT bindings doc enforce the
> node name, and usually what we use to attach a node to a specific
> driver is the compatible string (this one is specified in the bindings
> doc).

I know what you're saying, but what if someone uses the Flexcom driver
to wrap a different type of SPI driver where (for instance) the
compatible string used is "<name>-<newtype>".  Then we'd have to keep
adding more lines here to accommodate.

Whereas if we used the child node name which only pertains to _this_
driver, we would then have full control and know that (unless it
Flexcom is used for a completely different type of serial controller)
we wouldn't have to keep expanding the code to accommodate.

> Regarding the implementation itself, I would match the child node with
> an of_device_id table rather than trying to find a specific substring
> in the compatible string, but I think that's only a matter of taste.

You mean duplicate each of the supported device's compatible strings
in this driver, then fetch the attributed of_match_device()->data
value?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
