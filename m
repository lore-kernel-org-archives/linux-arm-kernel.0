From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 22 Jun 2011 09:52:11 -0600
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <20110622153353.GA25799@S2100-06.ap.freescale.net>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<BANLkTim4vunTm1176MRw3pqRZnunu4=9jg@mail.gmail.com>
	<20110622153353.GA25799@S2100-06.ap.freescale.net>
Message-ID: <BANLkTimsk2eWKPi2hnHbaAn-vSMKmdYsGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 9:33 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Tue, Jun 21, 2011 at 01:13:50PM -0600, Grant Likely wrote:
>> On Tue, Jun 21, 2011 at 7:55 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
>> > Hi Grant,
>> >
>> > I just gave a try to use aliases node for identify the device index.
>> > Please take a look and let me know if it's what you expect.
>>
>> Thanks Shawn. ?This is definitely on track. ?Comments below...
>>
>> >
>> > On Sun, Jun 19, 2011 at 03:30:02PM +0800, Shawn Guo wrote:
>> > [...]
>> >> > >
>> >> > > +#ifdef CONFIG_OF
>> >> > > +static int serial_imx_probe_dt(struct imx_port *sport,
>> >> > > + ? ? ? ? struct platform_device *pdev)
>> >> > > +{
>> >> > > + struct device_node *node = pdev->dev.of_node;
>> >> > > + const __be32 *line;
>> >> > > +
>> >> > > + if (!node)
>> >> > > + ? ? ? ? return -ENODEV;
>> >> > > +
>> >> > > + line = of_get_property(node, "id", NULL);
>> >> > > + if (!line)
>> >> > > + ? ? ? ? return -ENODEV;
>> >> > > +
>> >> > > + sport->port.line = be32_to_cpup(line) - 1;
>> >> >
>> >> > Hmmm, I really would like to be rid of this. ?Instead, if uarts must
>> >> > be enumerated, the driver should look for a /aliases/uart* property
>> >> > that matches the of_node. ?Doing it that way is already established in
>> >> > the OpenFirmware documentation, and it ensures there are no overlaps
>> >> > in the global namespace.
>> >> >
>> >>
>> >> I just gave one more try to avoid using 'aliases', and you gave a
>> >> 'no' again. ?Now, I know how hard you are on this. ?Okay, I start
>> >> thinking about your suggestion seriously :)
>> >>
>> >> > We do need some infrastructure to make that easier though. ?Would you
>> >> > have time to help put that together?
>> >> >
>> >> Ok, I will give it a try.
>> >>
>> >
>> > diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
>> > index da0381a..f4a5c3c 100644
>> > --- a/arch/arm/boot/dts/imx51-babbage.dts
>> > +++ b/arch/arm/boot/dts/imx51-babbage.dts
>> > @@ -18,6 +18,12 @@
>> > ? ? ? ?compatible = "fsl,imx51-babbage", "fsl,imx51";
>> > ? ? ? ?interrupt-parent = <&tzic>;
>> >
>> > + ? ? ? aliases {
>> > + ? ? ? ? ? ? ? serial0 = &uart0;
>> > + ? ? ? ? ? ? ? serial1 = &uart1;
>> > + ? ? ? ? ? ? ? serial2 = &uart2;
>> > + ? ? ? };
>> > +
>>
>> Hmmm. ?David Gibson had tossed out an idea of automatically generating
>> aliases from labels. ?It may be time to revisit that idea.
>>
>> David, perhaps using this format for a label should turn it into an
>> alias (prefix label with an asterisk):
>>
>> ? ? ? ? *thealias: i2c at 12340000 { /*...*/ };
>>
>> .... although that approach gets *really* hairy when considering that
>> different boards will want different enumeration. ?How would one
>> override an automatic alias defined by an included .dts file?
>>
> Another dependency the patch has to wait for? ?Or we can go ahead and
> utilize the facility later when it gets ready?

No, this isn't something you need to wait for.  Just musing on future
enhancements.

>> Also, when obtaining an enumeration for a device, you'll need to be
>> careful about what number gets returned. ?If the node doesn't match a
>> given alias, but aliases do exist for other devices of like type, then
>> you need to be careful not to assign a number already assigned to
>> another device via an alias (this of course assumes the driver
>> supports dynamics enumeration, which many drivers will). ?It would be
>>
> Some words not finished?

heh, that happens sometimes.  I tend to be a bit scattered when
replying to email.  Just ignore the last sentence fragment.

>> > - ? ? ? line = of_get_property(node, "id", NULL);
>> > - ? ? ? if (!line)
>> > + ? ? ? line = of_get_device_index(node, "serial");
>> > + ? ? ? if (IS_ERR_VALUE(line))
>> > ? ? ? ? ? ? ? ?return -ENODEV;
>>
>> Personally, it an alias isn't present, then I'd dynamically assign a port id.
>>
> We probably can not. ?The driver works with being told the correct
> port id which is defined by soc. ?Instead of dynamically assigning
> a port id, we have to tell the driver the exact hardware port id of
> the device that is being probed.

Are you sure?  It doesn't look like the driver behaviour uses id for
anything other than an index into the statically allocated serial port
instance table.  I don't see any change of behaviour based on the port
number anywhere.

g.
