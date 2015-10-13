From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 13 Oct 2015 18:51:24 +0300
Subject: [PATCH 2/5] arm: dts: lpc32xx: fix improper usage of ranges
 property
In-Reply-To: <7277011.vmOGiecsKn@wuerfel>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <1444694045-22000-3-git-send-email-vz@mleia.com> <7277011.vmOGiecsKn@wuerfel>
Message-ID: <561D287C.9010400@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 13.10.2015 15:44, Arnd Bergmann wrote:
> On Tuesday 13 October 2015 02:54:02 Vladimir Zapolskiy wrote:
>> The change corrects invalid custom translations to 1:1 translations,
>> otherwise during initialization there are too many failed attempts to
>> translate addresses from subnodes, which anyway result in fallback 1:1
>> translations, also it is found that due to this problem proper usage
>> of ranges property in subnodes (e.g. for defining flash partitions)
>> can not be done.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>
> 

adding Joachim to Cc list as the author of PL172 memory controller
driver and related DT bindings, may be he has something to add.

> I don't get it. What kind of errors do you see? The existing
> version looks cleaner than the new one, as it only translates
> the MMIO areas that are actually used.
> 

The problem is found when I add PL175 device node to lpc32xx.dtsi and
expand the node in my board file. The external memory controller manages
up to 4 memory devices, which by means of the controller are mapped into
physical memory starting from address 0xe0000000.

Below are my declarations, similar to one found in lpc18xx.dtsi.

lpc32xx.dtsi change common for all LPC32xx boards:

emc: emc at 31080000 {
	compatible = "arm,pl175", "arm,primecell";
	reg = <0x31080000 0x1000>;
	clocks = <&scf LPC32XX_CLK_DDRAM>;
	clock-names = "mpmcclk";

	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0xe0000000 0x01000000>,
		 <1 0xe1000000 0x01000000>,
		 <2 0xe2000000 0x01000000>,
		 <3 0xe3000000 0x01000000>;
	status = "disabled";
};

myboard.dts declaration:

&emc {
	status = "okay";

	cs at 0 {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		mpmc,cs = <0>;
		mpmc,memory-width = <16>;
		mpmc,byte-lane-low;

		mpmc,write-enable-delay = <0>;
		mpmc,output-enable-delay = <0>;
		mpmc,read-access-delay = <55>;
		mpmc,page-mode-read-delay = <55>;
		mpmc,write-access-delay = <22>;
		mpmc,turn-round-delay = <8>;

		nor at 0 {
			#address-cells = <1>;
			#size-cells = <1>;

			compatible = "spansion,s29gl032a", "cfi-flash";
			reg = <0 0x00400000>;
			bank-width = <2>;
		};
	};
};

The problem with non-empty ranges is that NOR device is not mapped to
0xe0000000, because da > (cp + s):

	OF: ** translation for device /ahb/emc at 31080000/cs at 0/nor at 0 **
	OF: bus is default (na=1, ns=1) on /ahb/emc at 31080000/cs at 0
	OF: translating address: 00000000
	OF: parent bus is default (na=1, ns=1) on /ahb/emc at 31080000
	OF: empty ranges; 1:1 translation
	OF: parent translation for: 00000000
	OF: with offset: 0
	OF: one level translation: 00000000
	OF: parent bus is default (na=1, ns=1) on /ahb
	OF: walking ranges...
	OF: default map, cp=0, s=1000000, da=0
	OF: parent translation for: e0000000
	OF: with offset: 0
	OF: one level translation: e0000000
	OF: parent bus is default (na=1, ns=1) on /
	OF: walking ranges...
	OF: default map, cp=20000000, s=30000000, da=e0000000
	OF: not found !

This proposed 2/5 change fixes the problem for me:

	OF: ** translation for device /ahb/emc at 31080000/cs at 0/nor at 0 **
	OF: bus is default (na=1, ns=1) on /ahb/emc at 31080000/cs at 0
	OF: translating address: 00000000
	OF: parent bus is default (na=1, ns=1) on /ahb/emc at 31080000
	OF: empty ranges; 1:1 translation
	OF: parent translation for: 00000000
	OF: with offset: 0
	OF: one level translation: 00000000
	OF: parent bus is default (na=1, ns=1) on /ahb
	OF: walking ranges...
	OF: default map, cp=0, s=1000000, da=0
	OF: parent translation for: e0000000
	OF: with offset: 0
	OF: one level translation: e0000000
	OF: parent bus is default (na=1, ns=1) on /
	OF: empty ranges; 1:1 translation
	OF: parent translation for: 00000000
	OF: with offset: e0000000
	OF: one level translation: e0000000
	OF: reached root node
	e0000000.nor: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer
ID 0x000001 Chip ID 0x001a00

Also note that the change does not break any other translations,
moreover boot time delay is slightly faster.

Original address translation for a device:

[    0.259969] OF: ** translation for device /ahb/fab/watchdog at 4003C000 **
[    0.260050] OF: bus is default (na=1, ns=1) on /ahb/fab
[    0.260084] OF: translating address: 4003c000
[    0.260156] OF: parent bus is default (na=1, ns=1) on /ahb
[    0.260196] OF: walking ranges...
[    0.260248] OF: default map, cp=20000000, s=30000000, da=4003c000
[    0.260282] OF: parent translation for: 20000000
[    0.260333] OF: with offset: 2003c000
[    0.260364] OF: one level translation: 4003c000
[    0.260431] OF: parent bus is default (na=1, ns=1) on /
[    0.260468] OF: walking ranges...
[    0.260518] OF: default map, cp=20000000, s=30000000, da=4003c000
[    0.260550] OF: parent translation for: 20000000
[    0.260600] OF: with offset: 2003c000
[    0.260630] OF: one level translation: 4003c000
[    0.260676] OF: reached root node

With this proposed change applied address translation looks simpler:

[    0.253194] OF: ** translation for device /ahb/fab/watchdog at 4003C000 **
[    0.253281] OF: bus is default (na=1, ns=1) on /ahb/fab
[    0.253314] OF: translating address: 4003c000
[    0.253386] OF: parent bus is default (na=1, ns=1) on /ahb
[    0.253426] OF: empty ranges; 1:1 translation
[    0.253457] OF: parent translation for: 00000000
[    0.253506] OF: with offset: 4003c000
[    0.253537] OF: one level translation: 4003c000
[    0.253601] OF: parent bus is default (na=1, ns=1) on /
[    0.253639] OF: empty ranges; 1:1 translation
[    0.253669] OF: parent translation for: 00000000
[    0.253717] OF: with offset: 4003c000
[    0.253747] OF: one level translation: 4003c000
[    0.253793] OF: reached root node

Support of EMC device node will be added to lpc32xx.dtsi, when this kind
of problem is fixed.

--
With best wishes,
Vladimir
