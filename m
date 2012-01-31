From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 31 Jan 2012 12:07:12 +0100
Subject: [PATCH 1/3] of_spi: add generic binding support to specify ncs
 gpio in the slave
In-Reply-To: <20120130185458.GO28397@ponder.secretlab.ca>
References: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
 <20120130185458.GO28397@ponder.secretlab.ca>
Message-ID: <20120131110712.GI705@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:54 Mon 30 Jan     , Grant Likely wrote:
> On Mon, Jan 30, 2012 at 04:27:49PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > This will allow to use gpio for chip select with no modification in the
> > driver binding
> > 
> > When use the ncs-gpio, the gpio number will be passed via the controller_data
> > and the number of chip select will automatically increased.
> > 
> > When a spi master have only gpio chip select and is probe via dt check the
> > number of chip select only when adding slave.
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Cc: spi-devel-general at lists.sourceforge.net
> > ---
> >  Documentation/devicetree/bindings/spi/spi-bus.txt |    9 ++++++-
> >  drivers/of/of_spi.c                               |   27 ++++++++++++++------
> >  drivers/spi/spi.c                                 |    2 +-
> >  3 files changed, 28 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > index e782add..1dccf35 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > @@ -21,9 +21,16 @@ assumption that board specific platform code will be used to manage
> >  chip selects.  Individual drivers can define additional properties to
> >  support describing the chip select layout.
> >  
> > +If a gpio a specified to the SPI slave and no hardware chip select is present
> > +the reg property #address-cells and #size-cells are not needed.
> > +
> > +When use the ncs-gpio the gpio number will be passed via the controller_data
> > +and the number of chip select will automatically increased.
> > +
> >  SPI slave nodes must be children of the SPI master node and can
> >  contain the following properties.
> > -- reg             - (required) chip select address of device.
> > +- reg             - (required if no ncs-gpio) chip select address of device.
> > +- ncs-gpio        - (required if no reg) chip select gpio of device.
> 
> There is already precedence for using gpios for chip selects.  The slave device
> nodes remain as they are and it is the responsibility of the spi bus node
> to have a gpios property with a list of SS gpios.  The order of the gpios
> property should match the 'reg' address numbering of the child node.
> 
> I don't like the idea of having multiple bindings for the slave address of
> the spi device (reg or ncs-gpio)
> 
> What I want to see is generic SS helper code that spi bus drivers
> default to and correctly implement parsing of chip select gpios.
> 
> I'm not going to apply this patch.
I do not want to see any of managment in the driver, I want a generic way to
specify only gpio cs and hw and gpio cs

spi1: spi at fffcc000 {
	ncs-gpios = <&pioB 3 0>;
	status = "okay";
	mmc-slot at 0 {
		reg = <0>;
		compatible = "mmc-spi-slot";
		gpios = <&pioC 4 0   /* CD */
			>;
		voltage-ranges = <3200 3400>;
		spi-max-frequency = <20000000>;
	};
};

as on atmel spi we have no HW spi the cs is 0
if there is 3 hw cs the reg will be 3

we have 4 hw chipselect 3 enabled and one gpio chipselect

spi1: spi at fffcc000 {
	ncs-hw = < 0 1 1 1>;
	ncs-gpios = <&pioB 3 0>;
	status = "okay";
	mmc-slot at 0 {
		reg = <3>;
		compatible = "mmc-spi-slot";
		gpios = <&pioC 4 0   /* CD */
			>;
		voltage-ranges = <3200 3400>;
		spi-max-frequency = <20000000>;
	};
};

the idea is to pass the ncs_pin in the spi_device so the driver just have
to check if the chipselect is hw or gpio and then use it the right way

Best Regards,
J.
