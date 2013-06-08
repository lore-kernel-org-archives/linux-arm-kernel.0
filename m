From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Jun 2013 10:54:43 -0400
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <alpine.LFD.2.03.1306072310450.18597@syhkavp.arg>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
 <20130607112101.2cedbc5f@skate>
 <20130607143249.GR23859@titan.lakedaemon.net>
 <20130607191651.0baa1c7d@skate>
 <alpine.LFD.2.03.1306072310450.18597@syhkavp.arg>
Message-ID: <20130608145443.GA23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Sat, Jun 08, 2013 at 12:50:12AM -0400, Nicolas Pitre wrote:
> On Fri, 7 Jun 2013, Thomas Petazzoni wrote:
> > On Thu, 6 Jun 2013 13:27:38 -0400 (EDT), Nicolas Pitre wrote:
...
> On Fri, 7 Jun 2013, Jason Cooper wrote:
> 
> > We could add Arnd's suggestion of a time bomb on the common code in
> > atags_to_fdt.c to prevent mis-use.
> 
> That don't work.  People simply don't take that hint any more seriously 
> either.  It is just too easy to postpone the trigger instead.

Ok, just thought I'd mention it.

> > I'm not 100% convinced of this, and I actually tend to agree with Nico
> > here, but I'd also like to find a workable solution.

Thanks for confirming my uneasiness with the idea.

> On Fri, 7 Jun 2013, Thomas Petazzoni wrote:
> 
> > I perfectly understand Nico and Russell concerns, for sure. But I'd
> > also like to find a workable solution:
...
> >  * Parsing the U-Boot environment is really not easy. How does the
> >    kernel know where this environment is located? What if another
> >    bootloader than U-Boot is used? Reading the U-Boot environment from
> >    the kernel sounds clunky.
> 
> It certainly is, no doubt about that.
> 
> So let me repeat my other suggestion again.

I somehow missed this the first time around, sorry about that.

> What you need is a third stage bootloader.  And "bootloader" is probably 
> too strong a word for what this piece of code needs to be.  So let's 
> call it the impedance matcher.

Large shim?  :-P

> The impedance matcher only has to:
> 
> - Be loaded into memory by the bootloader in addition to the kernel 
>   image and ramdisk if you have one.
> 
> - Be executed instead of the kernel by the bootloader when booting.  It 
>   may even pretend to be a kernel image itself, albeit a very small one, 
>   to fool the bootloader.
> 
> - Look at the DT image the bootloader might have loaded into memory 
>   along with the other images even if the bootloader itself didn't know 
>   how to deal with it, and...
> 
> - Convert the bootloader provided ATAGs into DT nodes, including 
>   whatever proprietary ATAGs you might have created and which you might 
>   not want to tell the world about.
> 
> - Transfer execution to the kernel zImage loaded elsewhere previously by 
>   the bootloader, passing along the address of the DTB that was just 
>   updated.
> 
> Does it look like ARM_ATAG_DTB_COMPAT to you?  Because it certainly 
> does.  You could even copy code from the kernel to implement this if you 
> wish.  The libfdt code is certainly a must, and it is highly portable to 
> a simplistic runtime environment.

barebox might be a good starting point, it's designed to be executed
from itself.

> But this does _not_ have to be tied to the kernel.  And with the loading 
> of a DTB separately you even don't need ARM_APPENDED_DTB in your kernel 
> anymore !

That would be great.

> So you write this code once, compile it once, and install it everywhere, 
> and forget about it just like the bootloader itself.  Users won't need 
> to think about concatenating a DTB to their zImage.  They'll be able to 
> use latests mainline kernels in their pure form.
> 
> Example U-Bot operations to be scripted:
> 
> - Load initrd at 0x04000000 (nothing different here)
> 
> - Load device tree blob at 0x03000000 (just a plain binary load)
> 
> - Load zImage/uImage at 0x02000000 (zImage can be executed at any 
>   address)
> 
> - Load the impedance matcher at 0x00100000 (just like a regular kernel 
>   image)
> 
> - Boot the kernel (actually the impedance matcher) with the bootm 
>   command.
> 
> And because the impedance matcher does not have to be generic to many 
> platforms, just like the compiled bootloader is not, you may simply 
> hardcode some addresses in it that only the U-Boot script needs to know 
> about, such as the address of the loaded DTB and final kernel image.

This could possibly be a separate board in barebox...  Call it
atags_to_fdt? :)

thx,

Jason.
