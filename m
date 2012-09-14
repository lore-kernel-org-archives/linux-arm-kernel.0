From: rajanikanth.hv@stericsson.com (Rajanikanth HV)
Date: Fri, 14 Sep 2012 15:04:38 +0530
Subject: Implement devicetree support for AB8500 Btemp
In-Reply-To: <201209140809.31045.arnd@arndb.de>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
 <201209131437.38666.arnd@arndb.de> <20120914020427.GA30729@lizard>
 <201209140809.31045.arnd@arndb.de>
Message-ID: <5052FA2E.20406@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Friday 14 September 2012 01:39 PM, Arnd Bergmann wrote:
> On Friday 14 September 2012, Anton Vorontsov wrote:
>> Power supply subsystem's supplied_to describes not just how driver
>> should notify other devices, supplied_to is more generic stuff, in terms
>> that it describes power supply hierarchy. It's like a directed graph,
>> e.g.:
>>
>>       <AC power> supplied_to <main battery> and <backup battery>
>>      <USB power> supplied_to <main battery> and <backup battery>
>>   <main battery> supplied_to <system>
>> <backup battery> supplied_to <system>
>>   <cmos battery> supplied_to <southbridge pci device>
>>   <mice battery> supplied_to <mice wireless hid>
>>
>> How things interact in linux are just implementations details.
>> So, device tree is surely a perfect place to describe these things.
>>
>> Although, in current bindings I see this:
>>
>> +       ab8500-fg {
>> +               /* Other enery management module */
>> +               supplied_to = "ab8500_chargalg", "ab8500_usb";
>> +               num_supplicants = <2>;
>> +       };
>>
>> Instead of addressing supplicants by name, it's better to address
>> via phandles. And, of course, num_supplicants is not needed, it can
>> be derived.
> 
> Right. that's what I thought. The other comment I made initially is
> that it would be more in the spirit of the existing bindings to have
> the supply property in the opposite directory, if we need it, like
> (picking up your above example):
> 
> 
> / {
> 	/* power supply property in the root node is used by default */
> 	power-supply = <&main-battery>, <&backup-battery>;
> 
> 	ac-power: power at ... {
> 		...
> 	};
> 
> 	usb-power: power at ... {
> 		...
> 	};
> 
> 	main-battery: battery at ... {
> 		power-supply = <&ac-power>, <&usb-power};
> 	;
> 
> 	...
> };
> 
> It's the same information and absolutely equivalent as far as I can tell,
> but it feel more logical in the way we tend to describe things.
> 
> 	Arnd
> 
phandle'd supplied-to will looks like:

usb: ab8500-usb {

};

battery : ab8500-bat-type {
    battery-name = "unknown|NiMH|LION|LIPO|LiFe|NiCd|LiMn";
    thermistor_on_batctrl = <1>;
};

chargalg: ab8500-chargalg {
    compatible = "stericsson,ab8500-chargalg";
    interface-name = "ab8500_chargalg";
    battery-info = <&ab8500-bat-type>
    supplied-to = <&ab8500_fg>;
	...
};

fuelguage: ab8500-fg {
    compatible = "stericsson,ab8500-fg";
    interface-name = "ab8500_fg";
    battery-info = <&ab8500-bat-type>
    supplied-to = <&ab8500_chargalg &ab8500_usb>;
	...
};
btemp: ab8500-btemp {
    compatible = "stericsson,ab8500-fg";
    interface-name = "ab8500_btemp";
    battery-info = <&ab8500-bat-type>
    supplied-to = <&ab8500_chargalg &ab8500_fg>;
	...
};

charger: ab8500-charger {
    compatible = "stericsson,ab8500-charger";
    interface-name = "ab8500_charger";
    battery-info = <&ab8500-bat-type>
    supplied-to = <&ab8500_chargalg &ab8500_fg &ab8500_btemp>;
	...
};
