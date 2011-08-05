From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 5 Aug 2011 16:29:53 -0500
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110805203629.GB6991@huya.qualcomm.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<4E3C51F5.50707@freescale.com>
	<20110805203629.GB6991@huya.qualcomm.com>
Message-ID: <CAKGA1b=CFVwjHT7eobd1-UMrSBNsQ2N+96OuCu1QbjGgo9RScQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2011 at 3:36 PM, David Brown <davidb@codeaurora.org> wrote:
> On Fri, Aug 05, 2011 at 03:26:29PM -0500, Scott Wood wrote:
>
>> > Yes, it puts the onus of the work on the firmware guys, but they're
>> > the ones writing the device trees for their hardware anyway.
>>
>> Sometimes.
>
> I'm not even sure that is going to be common. ?At least our setup is
> going to have the device tree living in flash somewhere. ?The
> bootloader only knows enough about the FDT to insert arguments and
> memory information into it. ?They certainly aren't the appropriate
> team to be defining the device tree.
>
> David

In any company through some kind of collaborative process of firmware
and Linux development, someone sits down and defines this device tree.
They will have an intimate knowledge of the hardware.. if you have to
flash the device tree to NOR or NAND or EEPROM or something anyway,
then flashing a new firmware binary at the same time is not really any
more complex.

At some point someone will have to write the information down to
configure each of the pins the way you want it, either in tree form or
in procedures in the firmware code itself. You have to figure out who
that is yourself: but putting it in tree form just shifts the blame
from outside Linux in the firmware, to outside Linux in the tree.
Someone is going to have to make the decision which pins they set up
in firmware (required for boot, or just good policy to make sure SoC
inputs are hooked to device outputs, and device inputs hooked SoC
outputs..) and which are put in the tree. USB might not be required
for boot, so it might not be touched in firmware, and left for Linux..
but the NAND controller for example, it makes no sense to configure it
in firmware to read Linux for boot, and then list it in the tree for
later reconfiguration. So some things are going to be in one list and
not in the other.

So why not take the complexity and choice out of it, and do it in the
firmware,, one list, all configured at boot time, before Linux is even
in the picture, and make sure this is a requirement for booting Linux
that these pins are set up already?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
