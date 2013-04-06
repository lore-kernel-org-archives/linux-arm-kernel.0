From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sat, 6 Apr 2013 19:51:55 +0200
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <6581638.FPkNsv6peb@flatron>
References: <20130319170933.28337.50448.stgit@localhost>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
 <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
 <6581638.FPkNsv6peb@flatron>
Message-ID: <CALBypN4mHwWZNiAQqErh1bL1sPHNuRbO5-yxzY+R1enQqEJOSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 6, 2013 at 3:21 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
> [RANT]
>
> I tend to disagree about this whole hype about device tree usage for other
> things than pure hardware description. I don't think device tree should be
> a way to force some kind of new world order, but rather a more convenient
> and more maintainable (than board files) way of support hardware platforms
> in Linux kernel.
>
Totally agree

> On Friday 05 of April 2013 20:07:09 Matt Sealey wrote:
>>
>> The device tree concept is NOT a place to dump configuration items for
>> your board as hardcoded values to try and force something you could
>> have done elsewhere. On i.MX53 you cannot boot a kernel verbatim - you
>> at least have to run through the Boot ROM and supply a DCD table or
>> plugins first. This is where you figure things like this out.
>

You're suggesting setting the frequencies, parents etc in the DCD table??
Why?
IMHO that's horribly unreadable.

> But you can't always have control over the bootloader. What's wrong in
> letting the kernel configure the board itself? It must configure most of
> the hardware anyway, based on platform data (either located in board files
> or parsed from device tree).
>
> Why not to make the kernel independent from the bootloader at all? Then
> the bootloader could just do some minimal initialization needed to load a
> kernel image from flash memory and launch it (+ some code to allow
> flashing of new images).
>

Yes that's my opinion too.

I think the bootloader should really do as little as possible since:
* It's generally harder and/or riskier to update the bootloader than
the kernel (althugh somewhat less true these days with boot from SD)
* There are multiple bootloaders (u-boot, barebox, ...) but only one kernel
* It makes it easier to do product families where you have a common
bootloader and kernel image with different DTBs per variant. You can
then put all the DTBs in the boot partition and use a bootloader
variable to chose the right one.

>> I am totally against this (sorry Sascha..). Let's put some effort into
>> fixing the bootloaders rather than trying to use the device tree to
>> enforce the ridiculous assumption that "Linux kernel does not trust
>> the bootloader".
Why is this "rediculous" IMHO the kernel shouldn't trust the
bootloader, beyond having setting up the hardware sufficiently to
reliably and safely execute code.

>> Once the bindings and trees are out of the kernel
>> source, you're going to HAVE to trust what the bootloader passes, be
>> it pregenerated compiled blob (which needs to be written to match the
>> hardware state the bootloader finishes up at) or dynamically generated
>> at runtime during the boot process (which can describe to the bit what
>> the hardware is doing).

You have to trust the DTB yes but that is not the same as trusting the
bootloader to have setup the hardware.
I fail to see what difference it makes if the DTS is inside or outside
the kernel source. Even today you can compile a DTB from out of tree
DTS and pass it to a mainline kernel.


Regards,

Martin
