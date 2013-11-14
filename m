From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 14 Nov 2013 16:12:14 -0600
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <528542AC.4080405@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net>
 <52828C77.20001@wwwdotorg.org>
 <20131114162859.GX10335@titan.lakedaemon.net>
 <52851DC8.203@wwwdotorg.org>
 <20131114191622.GC21549@obsidianresearch.com>
 <528542AC.4080405@wwwdotorg.org>
Message-ID: <CAHCPf3tbX383j6j+fOnpjzNdJPZsqwm0qzOi9zA+f0T=UPRL7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 3:37 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/14/2013 12:16 PM, Jason Gunthorpe wrote:
>> On Thu, Nov 14, 2013 at 12:00:24PM -0700, Stephen Warren wrote:
>>
>>> I don't think a distro should need to know the DTB filename at all.
>>> Rather, the/a bootloader should know which platform it's running on, and
>>> provide a variable/... to the boot script/... that defines the DTB
>>> filename. That would completely remove all the knowledge of DTB
>>> filenames from distros.
>>
>> At some point the distro has to install a dtb into some cannonical
>> place so the bootloader can find it..

Right, and this place can be *anywhere* with *any name* in the scripted case.

In a non-scripted case, it just needs to match the bootloader name and
where it differs from the one in the kernel right now, this would be
hellish. To use GlobalScale as an example, since the patch did - if
Marvell or GlobalScale ship a U-Boot that boots the board, that has a
fixed name and *then* rename their tree in the kernel source, they
should be shot. The kernel community should be careful about it if
they're not Marvell or GlobalScale and didn't check with the
bootloader situation.. but when it happens, this is *entirely* a
packaging problem for your package maintainers. *ENTIRELY*.

In the case where it gets flashed into the board rather than left on a
filesystem, then it doesn't matter one jot what the filename is as
long as it goes to the right offset - which is going to end up
hardcoded in your distro, right? So stop hardcoding it (flash-kernel
does a particularly crappy, but eventually usable job of this under
Debian/Ubuntu right now already so they're safe).

>> Are you thinking that distros will have to ship a /boot/dtbs/*.dtb
>> with every dtb from the kernel build?
>
> Yes. How else would the distro support booting the install on arbitrary
> boards?

There are LOTS of ways. Mark and Russell insist on me being more
concise, so I'll simply say the distros have to do more work and
there's not really any way around it. Specifying "requirements for a
distro boot" means making everything comply with that, which is a lot
of work for distros anyway. May as well make your distro work around
the problems where they actually have some control - distro scripting,
distro board support, and not esoteric kernel build behaviors, or
having distro teams work on fixing non-compliant bootloaders.

Ta,
Matt Sealey <neko@bakuhatsu.net>
