From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Mar 2016 20:13:00 -0600
Subject: RPi3 arm64 port status
In-Reply-To: <87lh58k5ge.fsf@eliezer.anholt.net>
References: <87lh58k5ge.fsf@eliezer.anholt.net>
Message-ID: <56F34D2C.9070609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 07:52 PM, Eric Anholt wrote:
> I spent today working on getting aarch64 working on the Raspberry Pi 3.
> Here's what I've got so far:
>
> U-Boot branch mostly based on srwarren's work:
> https://github.com/anholt/u-boot/tree/rpi_dev
>
> (Check the commit messages there for necessary config.txt contents)
>
> My linux tree:
> https://github.com/anholt/linux/tree/bcm2837-64
>
> Linux is booting to the point of initializing MMC.  As of recently, I'm
> seeing MMC hangs at boot, and I haven't tracked down what's changed.
>
> I haven't implemented SMP yet.  Just like the 2836, the firmware has the
> secondaries spinlooping in a little bit of firmware memory, watching a
> channel of the the inter-processor mailboxes.  When the secondary sees
> the channel get a value, it jumps to it.  This is the same on the new
> 64-bit chips, even though the register we're communicating through is
> only 32 bits.

Are you sure about that? I was under the impression that on the RPi 2, 
the secondary CPU spin loop was implemented in a short stub that the VC 
firmware placed into RAM at address 0 (the default ARM CPU reset 
vector), but that that for the RPi 3 in AArch64 mode, there was no such 
stub available yet.

As such I made U-Boot link to address 0, relied on setting kernel_old=1 
in config.txt (which causes U-Boot to be loaded at address 0) and 
enabled a similar secondary CPU spin loop in U-Boot by enabling 
CONFIG_ARMV8_MULTIENTRY=y. The U-Boot code waits for a write to a memory 
location (currently hard-coded to a somewhat randomly chosen 0x0FFFFFF0) 
rather than for a message to appear in the HW mailbox.
