From: robdclark@gmail.com (Rob Clark)
Date: Wed, 5 Jul 2017 18:07:53 -0400
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170629210002.GB22780@codeaurora.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <20170629124908.GV4902@n2100.armlinux.org.uk>
 <20170629145808.GQ29665@vireshk-i7>
 <20170629154353.GX4902@n2100.armlinux.org.uk>
 <20170629210002.GB22780@codeaurora.org>
Message-ID: <CAF6AEGvH3Vivi8d=MyXsv3x9J9AenAdLN9pr9RtucQ+AwZTO=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 5:00 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/29, Russell King - ARM Linux wrote:
>> On Thu, Jun 29, 2017 at 08:28:08PM +0530, Viresh Kumar wrote:
>> > On 29-06-17, 13:49, Russell King - ARM Linux wrote:
>> > > The thing that concerns me most about this is that typically the LCD
>> > > controller will be performing DMA to system RAM.
>> > >
>> > > The location of the frame buffer is unknown to the decompressor - and
>> > > as the decompressor self-relocates itself (using purely assembly code),
>> > > it could relocate itself on top of the frame buffer, causing the "nice"
>> > > image to become very colourful.
>> > >
>> > > The decompressor doesn't have the information from DT at that point to
>> > > know what are safe locations, so it's up to the boot loader to place
>> > > the frame buffer somewhere out of the way.  (If people want to write
>> > > a DT parser in position independent ARM assembly code that may change.)
>> > >
>> > > As long as people realise this, then it's not a problem, but given the
>> > > number of problems that we've already encountered with boot loaders and
>> > > memory space layout, I don't trust them to get this right.
>> > >
>> > > Right now, the ARM kernel booting document requires:
>> > >
>> > > - Quiesce all DMA capable devices so that memory does not get
>> > >   corrupted by bogus network packets or disk data. This will save
>> > >   you many hours of debug.
>> > >
>> > > so we would need to modify that to make an exception for LCD controllers.
>> > > However, we definitely can't have devices left enabled which are capable
>> > > of writing to system memory, or which changing system memory is likely
>> > > to cause bad effects (eg, packet ring buffers, USB buffers etc, which is
>> > > really what the above requirement is about.)
>> >
>> > Well, LCD was just an example here. But yeah, it is one of the most
>> > probable case we have.
>> >
>> > So, this thing is already working for sure, of course with some out of
>> > tree hacks. Every smart phone shows their company's logo (some kind of
>> > flash) while the phone boots. How do they get around such issues?
>>
>> As far as the memory being used goes, they probably locate the frame
>> buffer well away from the kernel or any area that the kernel is likely
>> to use during decompression.
>>
>> It's probably also marked as a reserved memory region in DT to avoid
>> the kernel touching it during boot, or _maybe_ they just locate it
>> somewhere in memory that they've tested that the kernel doesn't touch
>> until after their kernel has initialised the LCD controller (thereby
>> avoiding the memory being permanently consumed.)
>>
>
> Yes. The display controller is typically pointed to a memory
> carveout that we treat as reserved in the kernel. I'm fairly
> certain that we avoid the "permanently consumed" problem by
> making it a carveout for the display controller, so that when the
> display controller probes it can take ownership of the memory
> from the bootloader.
>

For aarch64/arm64 booting with EFI, the bootloader passes info about
memory layout to the kernel (including the fact that the framebuffer
is carved out) so kernel doesn't clobber the scanout buffer.  The
non-EFI case, the bootloader should (not that lk does) patch up the
fdt reserved memory node w/ correct address/size.  I think
lk+downstream just relies on luck.

(I have a patch that makes lk insert a framebuffer-simple node, which
I think should also solve it in the non-bootefi case)

BR,
-R
