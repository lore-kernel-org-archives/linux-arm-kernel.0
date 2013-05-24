From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 May 2013 12:57:34 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130524100754.6b2d1bc9@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130524074616.GV18614@n2100.arm.linux.org.uk>
 <20130524100754.6b2d1bc9@skate>
Message-ID: <201305241257.34468.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 May 2013, Thomas Petazzoni wrote:
> On Fri, 24 May 2013 08:46:16 +0100, Russell King - ARM Linux wrote:
> 
> > Wrong, again.  Thomas has already said there are boot loaders shipping
> > on boards which have the registers programmed to be at 0xf1xxxxxx and
> > there's boards with boot loaders programmed for 0xd0xxxxxx.
> > 
> > The problem is here TODAY.

The problem so far only concerns the development boards if I understood
Thomas correctly, not the Mirabox/OpenBlocks systems that this thread was
about, if you read up how we got here.
 
> Right. And again, don't expect something like:
> 
>  * Board A = 0xd0xxxxxx
>  * Board B = 0xf1xxxxxx
> 
> Depending on which bootloader, and which version of the bootloader you
> run, on a given board, the kernel may be booted with 0xd0 or 0xf1.

This is fine, the only thing we have to ensure is that the device tree
correctly describes what the boot loader has set up:

* For development boards and any future products you said we can ignore
  the old boot loaders and happily put the new address in the device
  tree. This seems reasonable.
* For Mirabox/OpenBlocks, it's too late to change it now, as you say,
  so they should stay at 0xd0.
* If someone wants to update their OpenBlocks to a new boot loader that
  uses the 0xf1 address, that's also fine, as long as they ensure they
  have a matching device tree. This is possible because there are no
  boot loaders for those devices yet using the new address. If the
  device tree gets loaded by u-boot, it can update the address in both
  DT and in hardware. If it uses ATAGS, it has to assume it is booting
  an older kernel so it cannot reprogram the hardware.
* If they screw up and change the address without updating the DT in
  memory, the only reasonable option left is to have a different DT
  blob for the new u-boot version. Hopefully we can avoid that case.

> And again, again. This 0xd0 was a mistake. We don't want to support
> moving forward. The only thing we want to support is 0xf1, nothing else.
>
> All the proposal is about a temporary workaround, just to make the
> transition smoother.

The 0xd0 wasn't the only mistake, it was just one in a series of
mistakes, each trying to fix the previous one but making things
worse in the process. Changing the boot loader from one address to
another is a much more serious mistake and we should not encourage
that from spreading to other boards.

	Arnd
