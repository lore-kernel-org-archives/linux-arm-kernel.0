From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 8 Jun 2013 00:50:12 -0400 (EDT)
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <20130607191651.0baa1c7d@skate>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
 <20130607112101.2cedbc5f@skate>
 <20130607143249.GR23859@titan.lakedaemon.net> <20130607191651.0baa1c7d@skate>
Message-ID: <alpine.LFD.2.03.1306072310450.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Thomas Petazzoni wrote:

> Dear Nicolas Pitre,
> 
> On Thu, 6 Jun 2013 13:27:38 -0400 (EDT), Nicolas Pitre wrote:
> 
> > > I'd be interested to hear your opinion about the below proposal, that
> > > allows platform-specific code to do its own parsing of ATAGS
> > > information, without cluttering the generic code.
> > 
> > Personally, I don't like it.
> > 
> > Not that the code itself is extremely ugly.  That is not the point.
> > 
> > This opens the door to laziness on the part of bootloader authors and 
> > system integrators which will simply (ab)use this mechanism as this 
> > allows them to sit on what they already have instead of making the extra 
> > mile to bring things into conformance.  And overtime this means 
> > maintenance nightmare for us.
> > 
> > I'm sorry but the only leverage we have to create some incentive for 
> > people to do the right thing is exactly to say no to such kind of 
> > accommodation.
> > 
> > If Marvell has done things improperly in the past, it is for them to pay 
> > the maintenance cost of their choices, not for mainline to carry them.
> 
> Well, I don't think what you say here is really fair. Before the DT was
> in place, unless I missed it, there was no standard way of letting the
> bootloader pass MAC addresses to the kernel. And Marvell's development
> on those Armada 370/XP platforms predates the introduction of the
> Device Tree in the Linux kernel (the code we have originally been give
> was a 2.6.3x), so it's really not their fault to not have a DT-capable
> bootloader at this point.

Well, fair enough.  In the end we don't care whose fault it is.  That's 
besides the point.

What we care about is for the upstream kernel maintenance to remain 
sane.  In that regard it is not acceptable to add new code into mainline 
in order to support some boot mechanisms that were never supported by 
the mainline kernel before, and which we know upfront are not desirable.

> The ARM_APPENDED_DTB and ARM_ATAG_DTB_COMPAT thing were added precisely
> for this situation: the hardware platform was designed at a time where
> the DT was not yet used/widespread on ARM, so the bootloaders for those
> hardware platforms is not DT-capable. 

That's different.  Those features were added, against my wish I must 
admit even if I ended up writing most of the code for them, in order not 
to break platforms that were _already_ supported into mainline while the 
kernel moved to DT.  For newly supported platforms in mainline I don't 
think we should also carry their odd ways of doing things.

> What I'm proposing here is a minimally intrusive extension of this 
> idea, in the exact same scenario.

And then someone else will come along asking for yet another minimally 
intrusive extension.  And because we would have said yes to you we'll 
have to accept that other one too.  I'm sure you can forsee the mess 
growing.

> Moving from the ATAG-based boot method to the DT-based method was a
> mainline decision, and pragmatically, we should give SoC vendors enough
> time to switch their entire boot infrastructure to this new boot
> protocol. This is why ARM_APPENDED_DTB was created in the first place.

Exact.  It was created to be pragmatic and give people a chance to 
transition from what infrastructure they had at that point.  It was not 
created to constantly be extended over time.  If anything, we should be 
thinking about phasing it out instead.

> So please don't put the entire fault on Marvell on this one :)

Please remember that I did work at Marvell for 2.5 years previously.  
So I know people over there and I know they're not evil individuals.

But Marvell's fault here is to not have taken the hint seriously enough.  
We've said more than 2 years ago that no new platforms which is not DT 
enabled will be accepted into mainline anymore.  I think that's plenty 
of time to adapt the boot infrastructure.

> Marvell will release a DT-capable U-Boot in some time, that will
> properly adjust the MAC addresses in the DTB before handing it over to
> the kernel. We are currently working with Marvell to define which
> actions the bootloader should do on the DTB before handing it over to
> the kernel. I believe this is a sufficient proof that there is no
> laziness from Marvell's side and that things are progressing towards a
> full DT based boot protocol.

Great!  Better late than never.

> But in the mean time, just like we have this ARM_APPENDED_DTB and
> ARM_ATAG_DTB_COMPAT workarounds, I thought we could do the same to
> allow platform-specific code to parse some platform-specific ATAGs.
> That would be so much better for the current users of Armada 370 and
> Armada XP platforms.

And then you asked me what I thought about it, so I told you.  

I even provided examples of ways to work around the issue _outside_ the 
kernel even without replacing currently installed bootloaders.


On Fri, 7 Jun 2013, Jason Cooper wrote:

> We could add Arnd's suggestion of a time bomb on the common code in
> atags_to_fdt.c to prevent mis-use.

That don't work.  People simply don't take that hint any more seriously 
either.  It is just too easy to postpone the trigger instead.

> I'm not 100% convinced of this, and I actually tend to agree with Nico
> here, but I'd also like to find a workable solution.


On Fri, 7 Jun 2013, Thomas Petazzoni wrote:

> I perfectly understand Nico and Russell concerns, for sure. But I'd
> also like to find a workable solution:
>  
>  * Passing the MAC address on the kernel command line is not something
>    that the network maintainer likes. See
>    http://lists.openwall.net/netdev/2011/11/17/82 and Dave Miller's
>    answer http://lists.openwall.net/netdev/2011/11/17/83.

I don't necessarily agree with Davem here but this is his prerogative.

>  * Parsing the U-Boot environment is really not easy. How does the
>    kernel know where this environment is located? What if another
>    bootloader than U-Boot is used? Reading the U-Boot environment from
>    the kernel sounds clunky.

It certainly is, no doubt about that.

So let me repeat my other suggestion again.

What you need is a third stage bootloader.  And "bootloader" is probably 
too strong a word for what this piece of code needs to be.  So let's 
call it the impedance matcher.

The impedance matcher only has to:

- Be loaded into memory by the bootloader in addition to the kernel 
  image and ramdisk if you have one.

- Be executed instead of the kernel by the bootloader when booting.  It 
  may even pretend to be a kernel image itself, albeit a very small one, 
  to fool the bootloader.

- Look at the DT image the bootloader might have loaded into memory 
  along with the other images even if the bootloader itself didn't know 
  how to deal with it, and...

- Convert the bootloader provided ATAGs into DT nodes, including 
  whatever proprietary ATAGs you might have created and which you might 
  not want to tell the world about.

- Transfer execution to the kernel zImage loaded elsewhere previously by 
  the bootloader, passing along the address of the DTB that was just 
  updated.

Does it look like ARM_ATAG_DTB_COMPAT to you?  Because it certainly 
does.  You could even copy code from the kernel to implement this if you 
wish.  The libfdt code is certainly a must, and it is highly portable to 
a simplistic runtime environment.

But this does _not_ have to be tied to the kernel.  And with the loading 
of a DTB separately you even don't need ARM_APPENDED_DTB in your kernel 
anymore !

So you write this code once, compile it once, and install it everywhere, 
and forget about it just like the bootloader itself.  Users won't need 
to think about concatenating a DTB to their zImage.  They'll be able to 
use latests mainline kernels in their pure form.

Example U-Bot operations to be scripted:

- Load initrd at 0x04000000 (nothing different here)

- Load device tree blob at 0x03000000 (just a plain binary load)

- Load zImage/uImage at 0x02000000 (zImage can be executed at any 
  address)

- Load the impedance matcher at 0x00100000 (just like a regular kernel 
  image)

- Boot the kernel (actually the impedance matcher) with the bootm 
  command.

And because the impedance matcher does not have to be generic to many 
platforms, just like the compiled bootloader is not, you may simply 
hardcode some addresses in it that only the U-Boot script needs to know 
about, such as the address of the loaded DTB and final kernel image.

That's it!  you've turned your legacy boot environment into a fully DT 
capable one without even replacing the factory bootloader.  And that 
shouldn't require a lot of extra coding besides the code you were 
already willing to add to the kernel with your suggestion.


Nicolas
