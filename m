From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Wed, 15 Mar 2017 12:49:30 -0700
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20170315185214.GF21021@lunn.ch>
 <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
Message-ID: <7f5ddeba-6f79-9de5-2c67-a77e6bec0ef9@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2017 12:34 PM, Vivek Unune wrote:
> Andrew,
> 
> I'm not entirely sure. But here is what I observed.
> 
> Boot loader sets up both the switches. And I can use all 8 ports of the
> router when I boot Lede. Only the internal swich is detected and
> configurable via swconfig tool
> Internal switch is connected to CPU via port 5 same as Netgear R8000.
> The other bit here is that I looked through the GPL source and gpio pin
> 10 is labeled as EA9500_RST2LANSW_GPIO10_PIN/ResetSwitch. So when I
> performed a robo reset of the pin and 5 (labeled 1 thru 5 on the unit)
> of the 8 physical ports stopped working (no packets).
> 
> If the external switch were to be connect via dedicated ethernet
> interface it should have shown up during the probe. Is in't it?

Not necessarily, and probably not with LEDE which would treat the
external 53125 as a dumb switch and not even see it. With a mainline
kernel and the B53 DSA driver you would be able to represent both
switches in Device Tree and describe how they are cascading from each other.

The potential Device Tree changes could look like this (based on your
explanation, but I am not sure) for your platform, assuming the 53125 is
actually exposing the front panel ports and that we did introduce a
"mdio" node which would be required to expose the external BCM53125 switch.


/* There is no MDIO node, there should be one */
&mdio {
	status = "okay";

	switch at 30 {
		#address-cells = <1>;
		#size-cells = <0>;
		reset-gpios = <&gpio 10>;
		reset-names = "robo_reset";

		ports {
                	#address-cells = <1>;
	                #size-cells = <0>;

        	        port at 0 {
                	        reg = <0>;
                        	label = "lan1";
	                };

	                port at 1 {
        	                reg = <1>;
                	        label = "lan2";
                	};

	                port at 2 {
        	                reg = <2>;
                	        label = "lan3";
                	};

	                port at 3 {
        	                reg = <3>;
                	        label = "lan1";
                	};

	                port at 4 {
        	                reg = <4>;
                	        label = "wan";
                	};

 	               port at 5 {
        	                reg = <5>;
                	        label = "cpu";
                        	ethernet = <&sw0port8>;
				fixed-link {
					speed = <1000>;
					full-duplex;
				};
                	};
		};
	};
};

&srab {
        status = "okay";

	ports {
		#address-cells = <1>;
		#size-cells = <0>;

		port at 5 {
			reg = <5>;
			label = "cpu";
			ethernet = <&gmac0>;
			fixed-link {
				speed = <1000>;
				full-duplex;
			};
		};

		sw0port8: port at 8 {
			reg = <8>;
			label = "extswitch";

			fixed-link {
				speed = <1000>;
				full-duplex;
			};
		};
        };
};

> 
> Thanks,
> 
> Vivek
> 
> 
> On Wed, Mar 15, 2017 at 2:52 PM Andrew Lunn <andrew@lunn.ch
> <mailto:andrew@lunn.ch>> wrote:
> 
>     Hi Vivek
> 
>     > - It has two switches in order to support 8 lan ports. Internal
>     switch is
>     >   BCM53012. The external switch BCM53125 currently works as "dumb
>     switch"
> 
>     Do you know how the second switch is connected? Is it cascaded off the
>     internal switch? Or does it have a dedicated Ethernet interface?
> 
>     Thanks
>             Andrew
> 


-- 
Florian
