From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Apr 2014 12:19:46 +0100
Subject: ARM: mm: Could I change module space size or place modules in
 vmalloc area?
In-Reply-To: <535B1618.5030504@huawei.com>
References: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
 <20140102101359.GU6589@tarshish>
 <002e01cf081c$44a11e70$cde35b50$@lge.com>
 <20140103004716.GG7383@n2100.arm.linux.org.uk>
 <535B1618.5030504@huawei.com>
Message-ID: <20140429111946.GC26067@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 03:12:40AM +0100, Jianguo Wu wrote:
> On 2014/1/3 8:47, Russell King - ARM Linux wrote:
> 
> > On Fri, Jan 03, 2014 at 09:39:31AM +0900, Gioh Kim wrote:
> >> Thank you for reply.
> >>
> >>> -----Original Message-----
> >>> From: Baruch Siach [mailto:baruch at tkos.co.il]
> >>> Sent: Thursday, January 02, 2014 7:14 PM
> >>> To: Gioh Kim
> >>> Cc: Russell King; linux-mm at kvack.org; linux-arm-kernel; HyoJun Im
> >>> Subject: Re: ARM: mm: Could I change module space size or place modules in
> >>> vmalloc area?
> >>>
> >>> Hi Gioh,
> >>>
> >>> On Thu, Jan 02, 2014 at 07:04:13PM +0900, Gioh Kim wrote:
> >>>> I run out of module space because I have several big driver modules.
> >>>> I know I can strip the modules to decrease size but I need debug info
> >>> now.
> >>>
> >>> Are you sure you need the debug info in kernel memory? I don't think the
> >>> kernel is actually able to parse DWARF. You can load stripped binaries
> >>> into the kernel, and still use the debug info with whatever tool you have.
> >>
> >> I agree you but driver developers of another team don't agree.
> >> I don't know why but they say they will strip drivers later :-(
> >> So I need to increase modules space size.
> > 
> > ARM can only branch relatively within +/- 32MB.  Hence, with a module
> > space of 16MB, modules can reach up to a maximum 16MB into the direct-
> > mapped kernel image.  As module space increases in size, so that figure
> > decreases.  So, if module space were to be 40MB, the maximum size of the
> > kernel binary would be 8MB.
> > 
> 
> Hi Russell ,Arnd or Will,
> 
> I encountered the same situation in arm64, I loaded 80+ modules in arm64, and
> run out of module address space(64M). Why the module space is restricted to 64M,
> can it be expanded?  

The module space is restricted to 64M on AArch64 because the range of the BL
instruction is += 128M. In order to call kernel functions, we need to ensure
that this range is large enough and therefore place the modules 64M below the
kernel text, allowing 64M for modules and 64M for the kernel text. We could
probably improve this a bit by assuming a maximum size for the kernel text.

If we want to remove the problem altogether, we'd need to hack the module
loader to insert trampolines (fiddly) or somehow persuade the tools to use
indirect branches (BLR) for all calls (inefficient).

Will
