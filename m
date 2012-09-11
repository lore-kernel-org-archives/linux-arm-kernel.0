From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 11 Sep 2012 13:42:01 +0300
Subject: [PATCH v6 1/3] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120904141050.GB19897@richard-laptop>
References: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
 <1346137109-32247-2-git-send-email-richard.zhao@freescale.com>
 <871uiqkuhb.fsf@ashishki-desk.ger.corp.intel.com>
 <20120829081020.GX26594@pengutronix.de>
 <87ehmqj925.fsf@ashishki-desk.ger.corp.intel.com>
 <20120829110137.GA26594@pengutronix.de> <503E74E0.6040503@pengutronix.de>
 <20120904141050.GB19897@richard-laptop>
Message-ID: <87fw6orgcm.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <linuxzsc@gmail.com> writes:

> On Wed, Aug 29, 2012 at 10:00:32PM +0200, Marc Kleine-Budde wrote:
>> On 08/29/2012 01:01 PM, Sascha Hauer wrote:
>> > On Wed, Aug 29, 2012 at 01:18:10PM +0300, Alexander Shishkin wrote:
>> >> Sascha Hauer <s.hauer@pengutronix.de> writes:
>> >>
>> >>> On Wed, Aug 29, 2012 at 10:50:08AM +0300, Alexander Shishkin wrote:
>> >>>> Richard Zhao <richard.zhao@freescale.com> writes:
>> >>>>
>> >>>>> i.MX usb controllers shares non-core registers, which may include
>> >>>>> SoC specific controls. We take it as a usbmisc device and usbmisc
>> >>>>> driver set operations needed by ci13xxx_imx driver.
>> >>>>>
>> >>>>> For example, Sabrelite board has bad over-current design, we can
>> >>>>> usbmisc to disable over-current detect.
>> >>>>
>> >>>> Why does this have to be part of the usb driver instead of SoC specific
>> >>>> code? It looks like you've created a whole new device/driver
>> >>>> infrastructure just to disable overcurrent for a specific board.
>> >>>
>> >>> Richards code indeed only handles overcurrent for a specific board, but
>> >>> there are more bits to configure in the longer run: power pin
>> >>> polarities, ULPI/serial mode select and some more.
>> 
>> We already have a patch adding a usbmisc_imx53_init() function to that
>> driver.
>> 
>> >> Sounds to me like these things that should be taken care of by the phy
>> >> driver, which will likely be simpler from both driver's and devicetree's
>> >> perspective.
>> > 
>> > Most i.MX SoCs have three instances of the chipidea core. These cores
>> > share a single register space for controlling the mentioned bits (the
>> > usbmisc register space). The usbmisc looks different on the different
>> > SoCs.
>> > Indeed they control some phy specific aspects, but the phy itself may
>> > also be an external ULPI or UTMI phy with a separate driver. So if we
>> > integrate the usbmisc into the phy wouldn't that mean that it has to
>> > be integrated into all possible phy drivers?
>> > 
>> > From a devicetrees perspective it makes sense to integrate the flags
>> > into the chipidea nodes, because there is one node per chipidea core,
>> > but only one usbmisc unit for all ports on the SoC. So we can do a:
>> > 
>> > 	chipidea at ofs {
>> > 		disable-overcurrent = <1>;
>> > 	};
>> > 
>> > instead of
>> > 
>> > 	usbmisc at ofs {
>> > 		disable-overcurrent-port0 = <1>;
>> > 		disable-overcurrent-port1 = <0>;
>> > 		...
>> > 	};
>> 
>> +1
>> 
>> IMHO looks much cleaner.
> So, Marc agree on the patch too. Maybe you can give a reviewed-by? :)
>
> Hi Alex,
>
> What do you think?

Weeell, as long as this is contained in platform specific code and arm
bits, I can tolerate it.

What about the other two patches? I guess they can go through arm tree
so we don't have to send it through Greg, right?

Regards,
--
Alex
