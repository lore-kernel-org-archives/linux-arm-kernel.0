From: gioh.kim@lge.com (Gioh Kim)
Date: Wed, 12 Mar 2014 15:38:39 +0900
Subject: ARM: mm: Could I change module space size or place modules in
 vmalloc area?
In-Reply-To: <201401031423.55336.arnd@arndb.de>
References: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
 <201401031310.09930.arnd@arndb.de>
 <20140103122206.GK7383@n2100.arm.linux.org.uk>
 <201401031423.55336.arnd@arndb.de>
Message-ID: <000501cf3dbd$b49ac970$1dd05c50$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am sorry to read your mail so late.
My module had been a proprietary driver so that I requested to strip it and
got small size driver.

Thank you for attention.


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, January 03, 2014 10:24 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Russell King - ARM Linux; HyoJun Im; linux-mm at kvack.org; Gioh Kim
> Subject: Re: ARM: mm: Could I change module space size or place modules in
> vmalloc area?
> 
> On Friday 03 January 2014, Russell King - ARM Linux wrote:
> > On Fri, Jan 03, 2014 at 01:10:09PM +0100, Arnd Bergmann wrote:
> > > Aside from the good comments that Russell made, I would remark that
> > > the fact that you need multiple megabytes worth of modules indicates
> > > that you are doing something wrong. Can you point to a git tree
> > > containing those modules?
> >
> > From the comments which have been made, one point that seems to have
> > been identified is that if this module is first stripped and then
> > loaded, it can load, but if it's unstripped, it's too big.  This
> > sounds suboptimal to me - the debug info shouldn't be loaded into the
> kernel.
> 
> Reading the layout_and_allocate() function, that is probably the intention
> already, and if something goes wrong there on ARM, it could be fixed up in
> an arch specific module_frob_arch_sections() function.
> 
> > However, I guess there's bad interactions with module signing if you
> > don't do this and the module was signed with the debug info present,
> > so I don't think there's a good solution for this.
> 
> My point was another anyway: I can't think of any good reason why you
> would end up with this many modules on any sane system. The only cases
> I've seen so far are
> 
> - modules written in C++, with libstdc++ linked into the module
> - a closed-source platform port hidden in a loadable module that
>   contains all the device drivers and subsystems while ignoring the
>   infrastructure we have in the kernel, and the possible legal
>   implications.
> - a bug in the module using large arrays that should just be
>   dynamically allocated.
> - device firmware statically linked into the module rather than
>   loaded using request_firmware.
> 
> In each of these cases, the real answer is to fix the code they are trying
> to load to do things in a more common way, especially if the intention is
> to eventually merge the code upstream. It is of course possible that they
> are indeed trying something valid, that's why I asked to see the source
> code.
> 
> 	Arnd
