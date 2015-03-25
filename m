From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 09:40:42 -0700
Subject: [PATCH v3 5/9] eeprom: Add bindings for simple eeprom framework
In-Reply-To: <20150325071006.GC4946@pengutronix.de>
References: <1427236116-18531-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427236230-18751-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150325071006.GC4946@pengutronix.de>
Message-ID: <20150325164042.GK23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 08:10:06AM +0100, Sascha Hauer wrote:
> On Tue, Mar 24, 2015 at 10:30:30PM +0000, Srinivas Kandagatla wrote:
> > This patch adds bindings for simple eeprom framework which allows eeprom
> > consumers to talk to eeprom providers to get access to eeprom cell data.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > [Maxime Ripard: intial version of eeprom framework]
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  .../devicetree/bindings/eeprom/eeprom.txt          | 70 ++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/eeprom/eeprom.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> > new file mode 100644
> > index 0000000..8348d18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> > @@ -0,0 +1,70 @@
> > += EEPROM Data Device Tree Bindings =
> > +
> > +This binding is intended to represent the location of hardware
> > +configuration data stored in EEPROMs.
> > +
> > +On a significant proportion of boards, the manufacturer has stored
> > +some data on an EEPROM-like device, for the OS to be able to retrieve
> > +these information and act upon it. Obviously, the OS has to know
> > +about where to retrieve these data from, and where they are stored on
> > +the storage device.
> > +
> > +This document is here to document this.
> > +
> > += Data providers =
> > +Contains bindings specific to provider drivers and data cells as children
> > +to this node.
> > +
> > += Data cells =
> > +These are the child nodes of the provider which contain data cell
> > +information like offset and size in eeprom provider.
> > +
> > +Required properties:
> > +reg:	specifies the offset in byte within that storage device, and the length
> > +	in bytes of the data we care about.
> > +	There could be more then one offset-length pairs in this property.
> > +
> > +Optional properties:
> > +As required by specific data parsers/interpreters.
> > +
> > +For example:
> > +
> > +	/* Provider */
> > +	qfprom: qfprom at 00700000 {
> > +		compatible 	= "qcom,qfprom";
> > +		reg		= <0x00700000 0x1000>;
> > +		...
> > +
> > +		/* Data cells */
> > +		tsens_calibration: calib at 404 {
> > +			reg = <0x404 0x10>;
> > +		};
> > +
> > +		serial_number: sn {
> > +			reg = <0x104 0x4>, <0x204 0x4>, <0x30c 0x4>;
> > +
> > +		};
> > +		...
> > +	};
> > +
> > += Data consumers =
> > +Are device nodes which consume eeprom data cells.
> > +
> > +Required properties:
> > +
> > +eeproms: List of phandle and data cell the device might be interested in.
> > +
> > +Optional properties:
> > +
> > +eeprom-names: List of data cell name strings sorted in the same order
> > +	      as the eeproms property. Consumers drivers will use
> > +	      eeprom-names to differentiate between multiple cells,
> > +	      and hence being able to know what these cells are for.
> > +
> > +For example:
> > +
> > +	tsens {
> > +		...
> > +		eeproms = <&tsens_calibration>;
> > +		eeprom-names = "calibration";
> > +	};
> 
> This is somewhat complicated. Also having 'eeprom' in the binding is not
> nice since it could be FRAM or something else. How about:
> 
> 	tsens {
> 		calibration = <&tsens_calibration>;
> 	};

A similar property was suggested the first time we discussed it, and
it turned out eventually that the construct you commented about was
actually preferred.

I guess we can always change the property name to something more
generic though.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/31088079/attachment-0001.sig>
