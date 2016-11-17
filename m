From: joel@jms.id.au (Joel Stanley)
Date: Thu, 17 Nov 2016 20:52:43 +1030
Subject: [RFC PATCH] mfd: dt: Add Aspeed LPC binding
In-Reply-To: <CACRpkdazPEbU2gmDyke=GTYtjVp8aeauS+PVkp-zuiVoVz7kbw@mail.gmail.com>
References: <20161117060633.3837-1-andrew@aj.id.au>
 <CACRpkdazPEbU2gmDyke=GTYtjVp8aeauS+PVkp-zuiVoVz7kbw@mail.gmail.com>
Message-ID: <CACPK8XfuKQErSpncXmY04h10PNj5KDhhNGXqa6ZmfPhZj7p8bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Linus,

On Thu, Nov 17, 2016 at 8:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Nov 17, 2016 at 7:06 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>> +* Device tree bindings for the Aspeed LPC Controller
>
> We are going overboard with the lingo sometimes, to the point that we do not
> understand how terse things become.
>
> LPC = Low Pin Count, right?
> Explain that right here: it is a slow external bus, right?

Yep. 33MHz bus that generally connects a host CPU to other devices on
the same motherboard, such as management controllers.

https://en.wikipedia.org/wiki/Low_Pin_Count

Systems with Aspeed BMCs use the LPC to load the firmware from the BMC
into the host at boot, and send IPMI messages between the host and the
BMC.

BMC stands for Baseboard Management Controller. Back in the day it was
simple keyboard controller microcontroller, these days we use a 800MHz
ARM11 with half a gigabyte of RAM. It provides access to the boot
firmware for the host CPU, monitors the health of the system (fans,
temperature, error logging), and provides remote access for power
cycling and installation.

https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller

Andrew and I work on an open source project that is creating a new BMC
software stack called OpenBMC. You've been merging the wonderful
Aspeed pinmux patches that Andrew wrote recently, which was a major
bit of kernel work required for that project.

>> +The Aspeed LPC controller contains registers for a variety of functions. Not
>> +all registers for a function are contiguous, and some registers are referenced
>> +by functions outside the LPC controller.
>> +
>> +Note that this is separate from the H8S/2168 compatible register set occupying
>> +the start of the LPC controller address space.
>> +
>> +Some significant functions in the LPC controller:
>> +
>> +* LPC Host Controller
>> +* Host Interface Controller
>
> Host interface to what?

Host in this case is the CPU on the motherboard to do the heavy
lifting. x86, ARM64, PowerPC. So this is the BMC's interface to the
host.

>
>> +* iBT Controller
>
> What is iBT?

IPMI Byte Transfer? Something like that. It's the transport that the
host uses to send IPMI messages to the BMC and back.

The host side has been upstream for a while. The BMC side has a driver
staged for v4.10:

https://patchwork.ozlabs.org/patch/674973/

If you're really bored you can read up on IPMI from the specificaiton:

 http://www.intel.com/content/www/us/en/servers/ipmi/ipmi-second-gen-interface-spec-v2-rev1-1.html

tl;dr is it's a protocol for communication to the BMC. There is
in-band IPMI, which is between the host and the BMC over the eg. the
BT interface. Or out of band IPMI, which is where you use ipmitool
from your laptop to talk to the BMC over the network.

>
>> +* SuperIO Scratch registers
>
> Again more context please.

The SuperIO name is legacy x86 terminology. These are a few bytes
worth of data that can be set from one side and read by the other in
order to convey firmware-specific information. In OpenPower systems,
we use them to tell the host where to send it's console output when it
is booting.

> With standards documents, either explain everything or provide
> pointers for the information.

If only we could give you the pleasure of reading the Aspeed reference
manual. It's only available from Aspeed under NDA at this point in
time though. If you want further details on anything else then Andrew,
Ben or myself can explain.

Cheers,

Joel
