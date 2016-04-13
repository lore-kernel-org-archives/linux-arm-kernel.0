From: sr@denx.de (Stefan Roese)
Date: Wed, 13 Apr 2016 13:40:00 +0200
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <20160413055946.GH14664@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk> <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk> <570DD967.8010703@denx.de>
 <20160413055946.GH14664@sirena.org.uk>
Message-ID: <570E3010.10309@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.04.2016 07:59, Mark Brown wrote:
> On Wed, Apr 13, 2016 at 07:30:15AM +0200, Stefan Roese wrote:
>> On 12.04.2016 21:27, Mark Brown wrote:
> 
>>> Writing something in the DT won't magically configure anything in the
>>> hardware which is (as I said) the bit I'm missing.
> 
>> The MBus driver (drivers/bus/mvebu-mbus.c) takes care of the MBus
>> window mapping. This is done, if the board dts files has one (or
>> multiple) entries for the SPI device(s) added to the 'ranges'
>> property of the 'soc' node.
> 
> I'm still unclear how mapping the windows in results in connecting the
> windows to the SPI block.

This is a hardware (SoC) specific mapping. For example the
Armada XP lists in "Table 6: CPU Interface Mbus Decoding Units IDs
and Attributes" of its Functional Specification Manual, that the
SPI controller has the "Target Unit ID" 0x1. And that "Attributes[7:0]"
need to get configured to these values for the SPI controller
SPI chip-selects:

0x5E = SPI0 CS1 request
0x9E = SPI0 CS2 request
0xDE = SPI0 CS3 request
0x1F = SPI0 CS4 request
0x5F = SPI0 CS5 request
0x9F = SPI0 CS6 request
0xDF = SPI0 CS7 request
0x1A = SPI1 CS0 request
0x5A = SPI1 CS1 request
0x9A = SPI1 CS2 request
0xDA = SPI1 CS3 request
0x1B = SPI1 CS4 request
0x5B = SPI1 CS5 request
0x9B = SPI1 CS6 request
0xDB = SPI1 CS7 request

Because of this, I've added these values to the Armada XP-370
dtsi file:

 		spi0: spi at 10600 {
-			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>;
+			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28	/* control */
+			       MBUS_ID(0x01, 0x1e) 0 0x100000	/* CS0 */
+			       MBUS_ID(0x01, 0x5e) 0 0x100000	/* CS1 */
+			       MBUS_ID(0x01, 0x9e) 0 0x100000	/* CS2 */
+			       MBUS_ID(0x01, 0xde) 0 0x100000	/* CS3 */
+			       MBUS_ID(0x01, 0x1f) 0 0x100000	/* CS4 */
+			       MBUS_ID(0x01, 0x5f) 0 0x100000	/* CS5 */
+			       MBUS_ID(0x01, 0x9f) 0 0x100000	/* CS6 */
+			       MBUS_ID(0x01, 0xdf) 0 0x100000>;	/* CS7 */

...

 		spi1: spi at 10680 {
-			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28>;
+			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28	/* control */
+			       MBUS_ID(0x01, 0x1a) 0 0x100000	/* CS0 */
+			       MBUS_ID(0x01, 0x5a) 0 0x100000	/* CS1 */
+			       MBUS_ID(0x01, 0x9a) 0 0x100000	/* CS2 */
+			       MBUS_ID(0x01, 0xda) 0 0x100000	/* CS3 */
+			       MBUS_ID(0x01, 0x1b) 0 0x100000	/* CS4 */
+			       MBUS_ID(0x01, 0x5b) 0 0x100000	/* CS5 */
+			       MBUS_ID(0x01, 0x9b) 0 0x100000	/* CS6 */
+			       MBUS_ID(0x01, 0xdb) 0 0x100000>;	/* CS7 */

The first value of the MBUS_ID macro representing the
'target' from the manual and the 2nd one the 'attribute'.
These 'target' and 'attribute' values may vary between
different Marvell SoCs.

Please take a look at
Documentation/devicetree/bindings/bus/mvebu-mbus.txt
as this describes the mbus driver and its bindings and
usage quite good.

>  It also seems like we need to document what
> the meaning of the reg properties of the device is, it's all very well
> saying that there's a generic MBus binding but we still need to say how
> the device will interpret the MBus windows that it has (assuming they
> are configured to specific hardware functions transparently).

Should I add something to the bindings documentation of
the orion-spi driver? With an example of how this direct mode
can is enabled on a specific board for e.g. SPI0-DEV1? Or what do
you think is missing in the mbus bindings documentation I
mentioned above?

Thanks,
Stefan
