From: jhovold@gmail.com (Johan Hovold)
Date: Sun, 7 Apr 2013 17:09:38 +0200
Subject: [PATCH] rtc: rtc-at91sam9.c add DT support
In-Reply-To: <515D8944.2060308@atmel.com>
References: <515CF985.6050009@interlog.com> <515D35C2.7050405@atmel.com>
 <515D7F56.90702@interlog.com> <515D8944.2060308@atmel.com>
Message-ID: <20130407150938.GA25605@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 04:08:04PM +0200, Nicolas Ferre wrote:
> On 04/04/2013 03:25 PM, Douglas Gilbert :
> > On 13-04-04 04:11 AM, Nicolas Ferre wrote:
> >> On 04/04/2013 05:54 AM, Douglas Gilbert :
> >>> Some members of the at91 SoCs use the Real Time Timer (RTT)
> >>> and the General Purpose Backup Registers (GPBR) to implement
> >>> a real time clock (RTC). The AT91SAM9G20 is one example.
> >>>
> >>> Attached is a patch to add DT support to rtc-at91sam9.c .
> >>> The patch is against lk 3.9.0-rc5 .
> >>>
> >>> Below is a snippet of DT code for the 'G20 that was observed
> >>> to work with this patch:
> >>>
> >>> ahb {
> >>>      apb {
> >>>
> >>>          rtc {
> >>>              compatible = "atmel,at91sam9-rtc";
> >>
> >> The compatible string has to be formed by the name of the first SoC
> >> compatible with this IP. It turns to be the at91sam9260.
> >> The second part of the string should be a name that reflects the nature
> >> of the peripheral. For this binding, I would like to mention the "RTT"
> >> in the compatibility string (because other drivers can use other RTT
> >> with other uses).
> >>
> >> What do you think about:
> >> "atmel,at91sam9260-rtt-as-rtc"? or something shorter?
> > 
> > Hi Nicolas,
> > Johan Hovold suggested:
> >    atmel,at91sam9260-rtt
> 
> Yes, but I fear this could bring confusion if someone is building a RTT
> driver that is not targeted at acting as a RTC...

But isn't the compatible property supposed to describe the peripheral in
a completely platform-agnostic way?

In fact, it seems it should be on the form

	compatible = "atmel,at91sam9g45-rtt", "atmel,at91sam9260-rtt";

where an exact description (the actual SoC-IP) is followed by a more
generic compatible description (e.g. the first SoC that introduced the
IP that is still compatible) (see [1]). This policy seems not have been
followed for at91 though, as only the second (first compatible SoC)
string is generally used. 

Either way, this still leaves open the question of which driver gets
bound to a device if there are more than one driver that matches the
compatible property. I guess this could be solved with a property set
or overridden by the board description. For example:

at91sam9g45.dtsi:

	rtt at fffffd20 {
		compatible = "atmel,at91sam9g45-rtt", "atmel,at91sam9260-rtt";
		reg = <0xfffffd20 0x10>;
		interrupts = <1 4 7>;
		status = "disabled";
	};

at91sam9m10g45ek.dts:

	rtt at fffffd20 {
		atmel,at91-rtt-as-rtc;
		status = "okay";
	};

If the device-specific property atmel,at91-rtt-as-rtc is missing,
the rtc-at91sam9 driver probe should fail so that any other matching
driver is probed. Of course, this will only work if the other matching
rtt-drivers also add device-specific properties so that they can be
disabled as well (should the probe order be reversed), for instance:

	atmel,at91-rtt-as-<xxx>;

> >>>                           /* RTTC followed by GPBR (backup registers) */
> >>>                           reg = <0xfffffd20 0x10>, <0xfffffd50 0x10>;
> >>>                           interrupts = <1 4 7>;
> >>>                           status = "okay";

Which backup register (GPBR) the RTC-time base should be stored in is
currently configurable using CONFIG_RTC_DRV_AT91SAM9_GPBR (and the
address arguably not even a property of the rtt) so the register address
should in any case not be set in the rtt-node of the dtsi.

Instead I think we need the arch code to map the backup-registers and
thus to add a new gpbr-node:

	gpbr at fffffd60 {
		compatible = "atmel,at91sam9g45-gpbr", "atmel,at91sam9260-gpbr";
		reg = <0xfffffd60 0x10>;
	};

We could then use CONFIG_RTC_DRV_AT91SAM9_GPBR for non-DT as before, and
add a new property (or simply replace the boolean) to the rtt-nodes in
the board descriptions:

	rtt at fffffd20 {
		atmel,at91-rtt-as-rtc;
		atmel,at91-rtt-as-rtc-gpbr = <n>;
		status = "okay";
	};

to select which of the four (sam9263 has 20) backup registers to use.

I'm responding to this mail with an RFC-implementing the GPBR and
RTT-as-RTC DT support as outlined above.

Finally, for the record: There are currently no other rtt-drivers, but I
have posted a patch series a while ago to fix hanged boot due to early
spurious RTT (or RTC) interrupts (see [2]). The series uses
"atmel,at91sam9260-rtt" to detect the SoCs that are affected by the
problem, and I guess that is an example of why the compatible string
should merely describe the peripheral (and not its use).

Thanks,
Johan

[1] http://www.devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
[2] http://marc.info/?l=linux-arm-kernel&m=136302554825979&w=2
