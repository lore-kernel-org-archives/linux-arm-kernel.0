From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 May 2013 16:36:49 +0200
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <518B77C1.70107@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305082148.10933.arnd@arndb.de> <518B77C1.70107@st.com>
Message-ID: <201305171636.49627.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 May 2013, Srinivas KANDAGATLA wrote:
> On 08/05/13 20:48, Arnd Bergmann wrote:
> I agree, my initial approach was having a dedicated driver specific to
> ST syscon, however syscon seems to do things very much similar to what
> we want, so I have integrated those 3 functions in syscon.
> Am happy to go back with my first approach of adding ST specific syscon
> driver if no one is actually going to benefit with such a change to
> syscon driver.

That would at least be less controversial.

> > Can you describe how your syscon registers are laid out?
> On STiH416 SOC we have 9 SYSCONF(aka System Configuration
> Registers)named banks/groups, each bank has its own memory map.
> Each sysconf bank has number of 32 bit registers which vary from bank to
> bank, like sysconf bank "sbc" has range from SYSTEM_CONFIG0 to
> SYSTEM_CONFIG999 where as  sysconf bank "front" has range of
> SYSTEM_CONFIG1000 to SYSTEM_CONFIG1999 and so on.
> 
> Each register is assigned with a unique SYCONF number, example:
> SYSTEM_CONFIG100, SYSTEM_CONFIG101 , .. and so on.
> Each sysconf contains bits of the IP configurations wired-up to the
> sysconf register bits.

Ok.

> As example:
> 
> - Each pinctrl entry for set of 8 pins uses around 8-10 sysconfig
> register to control pinconf and pin functions.
> - IPs like Ethernet have few bit like Ethernet-Mode selection external
> or internal phyclk wired up to bits in sysconf registers,
> - Few clocks are controlled by sysconf registers.
> - Reset to IPs are wired up to bits of sysconf same registers.
> - ARM core soft reset is wired up to the sysconf registers...
> And most of the IPs have similar requirements ......
> 
> Total layout of the sysconf changes per SOC, and the bit arrangements
> aswell, however the core IP(pinctrl, etherenet ...) and logic to drive
> those bits remains exactly same.

It sounds like you really need a driver with high-level interfaces
for the bits that change by each core and are needed by otherwise
identical drivers, like the Ethernet driver you mention.

I would not go as far as you did describing the individual bits in
the device node using these however. That driver can be layered on
top of the existing syscon driver, but hardcode the bits for each
SoC it knows of.

For drivers that are essentially just wrappers around sysconf,
I would make them one driver per SoC and use a low-level interface
but still hardcode the offsets in the driver instead of using DT
to find the registers.

The pinctrl and reset drivers are examples of this.

> In general the requirements of the sysconf support to the SOC/driver
> support is.
> 1> It should be able to read/write a sysconf register bits without
> having to "if" each SOC in the code. So that code is totally abstracted.
> Which is currently achieved by passing the information from the device
> trees and the driver just uses the property to get it.

The goal sounds fine, just the method is a bit more complex than necessary
here I think.

> 2> The infrastructure should protect the claimed registers from
> over-writing by other drivers. We do this by claim-read/write-release
> style API.

I don't understand this part. Is it about atomicity of accesses to
32-bit registers when you only want to change a bit? That is something
the regmap interface handles already.

If this is about drivers touching registers they should not touch
in the first place, I think it should not be needed at all, because
that would be a driver bug, and you can't really protect yourself
from broken drivers anyway.

> 3> The driver should be able to set a group of sysconf registers bits to
> a particular values before initialises the IP. I was thinking of doing
> this in a same way as pinctrl state.

That does not fit well with the model we use for other subsystems. If possible,
try to use the existing abstractions for clock, regulator, pinctrl, reset,
etc. and call generic interfaces from the driver. When that does not work,
create a high-level function call from your sysconf driver to do a particular
thing (e.g. stih_sysconf_ethernet_set_phy_mode()) rather than set up random
bits from the driver.

	Arnd
