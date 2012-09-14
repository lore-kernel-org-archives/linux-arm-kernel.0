From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 08:09:30 +0000
Subject: Implement devicetree support for AB8500 Btemp
In-Reply-To: <20120914020427.GA30729@lizard>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
 <201209131437.38666.arnd@arndb.de> <20120914020427.GA30729@lizard>
Message-ID: <201209140809.31045.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Anton Vorontsov wrote:
> Power supply subsystem's supplied_to describes not just how driver
> should notify other devices, supplied_to is more generic stuff, in terms
> that it describes power supply hierarchy. It's like a directed graph,
> e.g.:
> 
>       <AC power> supplied_to <main battery> and <backup battery>
>      <USB power> supplied_to <main battery> and <backup battery>
>   <main battery> supplied_to <system>
> <backup battery> supplied_to <system>
>   <cmos battery> supplied_to <southbridge pci device>
>   <mice battery> supplied_to <mice wireless hid>
> 
> How things interact in linux are just implementations details.
> So, device tree is surely a perfect place to describe these things.
> 
> Although, in current bindings I see this:
> 
> +       ab8500-fg {
> +               /* Other enery management module */
> +               supplied_to = "ab8500_chargalg", "ab8500_usb";
> +               num_supplicants = <2>;
> +       };
> 
> Instead of addressing supplicants by name, it's better to address
> via phandles. And, of course, num_supplicants is not needed, it can
> be derived.

Right. that's what I thought. The other comment I made initially is
that it would be more in the spirit of the existing bindings to have
the supply property in the opposite directory, if we need it, like
(picking up your above example):


/ {
	/* power supply property in the root node is used by default */
	power-supply = <&main-battery>, <&backup-battery>;

	ac-power: power at ... {
		...
	};

	usb-power: power at ... {
		...
	};

	main-battery: battery at ... {
		power-supply = <&ac-power>, <&usb-power};
	;

	...
};

It's the same information and absolutely equivalent as far as I can tell,
but it feel more logical in the way we tend to describe things.

	Arnd
