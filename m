From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 18:30:42 +0200
Subject: [PATCH 9/9] Doc/DT: Add DT binding documentation for tpd12s015
 encoder
In-Reply-To: <20140228161343.GS21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-10-git-send-email-tomi.valkeinen@ti.com>
 <20140228161343.GS21483@n2100.arm.linux.org.uk>
Message-ID: <5310B9B2.6030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 18:13, Russell King - ARM Linux wrote:
> On Fri, Feb 28, 2014 at 02:20:16PM +0200, Tomi Valkeinen wrote:
>> Add DT binding documentation for tpd12s015 encoder
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Archit Taneja <archit@ti.com>
>> ---
>>  .../devicetree/bindings/video/ti,tpd12s015.txt     | 44 ++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/ti,tpd12s015.txt b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
>> new file mode 100644
>> index 000000000000..26e6d32e3f20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
>> @@ -0,0 +1,44 @@
>> +TPD12S015 HDMI level shifter and ESD protection chip
>> +====================================================
>> +
>> +Required properties:
>> +- compatible: "ti,tpd12s015"
>> +
>> +Optional properties:
>> +- gpios: CT CP HPD, LS OE and HPD gpios
> 
> If this is supposed to give people a clue about what these GPIOs are,
> it completely fails to do this.  CT CP?  HPD is obviously the hotplug
> detect signal, but why are there two - HDMI only has a single detect
> pin on the connector.

No, it's not supposed to give a clue. But if you have a TPD chip on your
board, and you use it and write a dts file, you need to know what those
GPIOs are and where they are connected. They're described in the TPD
spec and should be visible on your boards schematics.

I did stop a few times when writing the binding docs, trying to decide
when I should go to details and when not. I usually decided that if the
particular information is 100% if you have the component spec sheet, I'm
not describing it here.

I don't even know what "CT CP" is short for, and I don't remember the
spec telling it... It does tell how to use it, though.

> While it makes sense to stick all three into one property, is it
> possible that not all of these may be routed to a GPIO?  If so, how
> do you specify that one (or more) of these does not exist?

The normal way, leave it out. From
Documentation/devicetree/bindings/gpio/gpio.txt:

chipsel-gpios = <&gpio1 12 0>,
                <&gpio1 13 0>,
                <0>, /* holes are permitted, means no GPIO 2 */
                <&gpio2 2>;

> Another issue here is that other HDMI encoders are available - should
> every encoder define its own set of bindings, or should there be a
> base set of bindings which all encoders should conform to - such as
> always having a HDMI output port?

The TPD is not an actual HDMI encoder, it's a level shifter, ESD
protection companion chip for the actual HDMI encoder.

But as for your question... I don't know. I don't know how much common
things there are. An HDMI encoder could have, say, two output ports. And
the encoder could have various number of input ports, so you can't say
either that the second port is always an output port.

If I had to make a guess right now, I'd guess that there are not enough
common things to justify defining common parts for all HDMI encoders.
But I have only dealt with the OMAP HDMI encoders, and a few one's from
Toshiba (DPI to HDMI and DSI to HDMI).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/b1bedf67/attachment.sig>
