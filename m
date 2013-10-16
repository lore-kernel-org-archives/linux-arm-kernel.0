From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 17 Oct 2013 07:54:35 +1100
Subject: [PATCH v2] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <Pine.LNX.4.44L0.1310161040490.1264-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1310161040490.1264-100000@iolanthe.rowland.org>
Message-ID: <525EFD0B.2020607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/13 01:43, Alan Stern wrote:

> On Wed, 16 Oct 2013, Hartley Sweeten wrote:
> 
>> On Tuesday, October 15, 2013 5:57 PM, Ryan Mallon wrote:
> 
>>> Gah, defconfig changes are a pest. I assume the other removed options
>>> are implicitly selected, and their removal is the result of
>>> re-minimising the defconfig? Can you put a note about this is the
>>> changelog please.
>>
>> Yah... It's a mess.
>>
>> All I did was:
>> make ARCH=arm ep93xx_defconfig
>> make ARCH=arm menuconfig		# enable USB_OHCI_HCD_PLATFORM
>> make ARCH=arm savedefconfig
>> mv defconfig arch/arm/configs/ep93xx_defconfig
>>
>> Looks like the last time the ep93xx_defconfig was refreshed was:
>>
>> commit 07a8c03f3e06129e847acd068b8b89c13357ee64
>> Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> Date:   Thu Jun 10 07:12:18 2010 +0200
>>
>>     ARM: reduce defconfigs
>>
>> Hence the ugly changes.
> 
> It's awfully hard to believe that enabling USB_OHCI_HCD_PLATFORM is 
> responsible for all those other changes.


The 'make savedefconfig' step minimises the defconfig by removing any
options that are implicitly selected or options that no longer exist.
E.g: 4d42942c: 'mtd: make MTD_CONCAT support mandatory' is responsible
for CONFIG_MTD_CONCAT disappearing from the defconfig. Looks the other
MTD options have also been removed.

CONFIG_NFS_V3, for example, got removed because it is implicit as of:
981f9fac: 'NFS: Turn v3 on by default'.

'make savedefconfig' also has an annoying tendency to shuffle items
around, presumably because the Kconfig files have changed. This is
why, for example, the:

  # CONFIG_LEGACY_PTYS is not set

line got moved in the diff.

Interestingly CONFIG_INOTIFY got removed because that option doesn't
exist anymore. I can't find the exact commit, but things have been
moved around and the option is now called CONFIG_INOTIFY_USER (so
whoever made the change probably didn't scan through all the 
defconfigs). It does mean that ep93xx lost support for inotify at
some point. Since nobody has complained, I don't think it is a huge
loss.

In short, yes the 'make savedefconfig' step is annoying because it
creates weird diffs. However, the diffs are correct (cleaning up
unused options, etc). The diffs should be inspected to catch things
like the inotify case, but otherwise there should be no functional
changes.

> 
> Maybe this should be done in two stages.  First create a patch that
> describes the differences resulting from:
> 
> make ARCH=arm ep93xx_defconfig
> make ARCH=arm savedefconfig
> mv defconfig arch/arm/configs/ep93xx_defconfig

>
> Then do this patch on top of that one.
> 

Yeah, I think a pre-patch for "ep93xx: make savedefconfig" would be
best.

Are you happy to collect all these patches once they are done? I
could take the ep93xx parts, but my tree typically only has a 
small handful of patches each merge window, so it is probably easier
if you grab them all.

Thanks,
~Ryan
