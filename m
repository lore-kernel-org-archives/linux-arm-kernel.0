From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 06 Aug 2012 20:08:57 -0400 (EDT)
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <CAKGA1bnJCSaVcErs3R8U3ZjQkhMmZAZPM=2P2R7udVc80ZmoDQ@mail.gmail.com>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
 <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
 <20120806194016.GB1120@n2100.arm.linux.org.uk>
 <CAKGA1b=hMZD3nd2sjXzR89-wX4BotxZwHOkkiLFoEL_CSS4zug@mail.gmail.com>
 <alpine.LFD.2.02.1208061829510.5231@xanadu.home>
 <CAKGA1bnJCSaVcErs3R8U3ZjQkhMmZAZPM=2P2R7udVc80ZmoDQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1208061935380.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Aug 2012, Matt Sealey wrote:

> On Mon, Aug 6, 2012 at 5:36 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Mon, 6 Aug 2012, Matt Sealey wrote:
> >
> >> Right now there's already a fixed entry point - ARM kernels are fixed
> >> entry point of relative 0 to the start of the loaded image. Okay, so
> >> we can't format a totally valid ELF header, but in the event that we
> >> want to encode all this information yet again, why reinvent the wheel?
> >
> > That's the point.  We do _not_ want to encode anything.
> >
> > By convention, if your CPU is ARM mode capable, then it must call the
> > kernel in ARM mode, period.  Can't be simpler than that, right?  The
> > bootloader shouldn't care if the kernel is itself ARM or Thumb, and the
> > kernel shouldn't care if the bootloader is ARM or Thumb.
> >
> > If you have a real problem with this then let's hear it so it can be
> > addressed.
> 
> I don't have a real *problem* with it, I just think since the kernel
> can be compiled in both modes, but you may have some kind of remit to
> not run ARM code (even if it's just a couple instructions at the
> start) or some toolchain requirement or.. something.. it would be
> entirely the bootloader's job to determine what mode it is in when it
> jumps into the kernel. If you boot a Thumb bootloader and load an ARM
> kernel, you'll get a crash. If you boot an ARM bootloader and a Thumb
> kernel (with the current ARM instructions in head.S), you'll get a
> crash. This is well defined, perfectly obvious, and I realise that..

And isn't it also rather silly?

History has told that the more "entirely the bootloader's job" we rely 
on, the less reliable and interoperable we become.  Because you now have 
to compile two kernels to fully validate your bootloader instead of only 
one, and some people won't bother if the second kernel doesn't match 
their own use case.

> But if you would need to micromanage the system such that they both
> matched, or were perverse enough to build a Thumb bootloader and a
> Thumb kernel, you might be counfounded that you actually created a
> 99.99% Thumb bootloader which switched to ARM mode before going into
> the kernel, and a 99.99% Thumb kernel but needed to jump into Thumb
> mode after the first part of the kernel code?

I'm pragmatic enough to fully accept this impurity.

The x86 kernel does boot in 16-bit mode even if nobody compiles 16-bit 
applications anymore.

> It should be possible (with that kernel config switch it would be) if 
> you're into that kind of configurability to build your Thumb 
> bootloader, build your Thumb kernel and have it never exit Thumb mode 
> for any reason, even if it is just for some few bytes of very minor 
> bootstrapping.

And what does this buy you?

> The same perfectly obvious caveats apply, but it's possible. The
> question is, if you could do it, how would you make sure bootloaders
> booted the right way? I would hazard a guess that given your opinion
> on it, it would be just as good if they all just crashed.

Whereas right now it just works because the kernel is always entered in 
ARM mode.

> So let's just patch out the ARM parts if you're building a Thumb
> kernel on a Thumb-only device, and assume it was in Thumb mode all
> along if another subordinate option was selected.. that way the kernel
> can automatically fulfill one side of the contract in that you
> configured "build thumb2 kernel" and it would contain 0% normal arm
> code for ARMv7-M (or -R) and be able to be prompted to do so if you
> were building for ARMv6k/ARMv7-A. Ordinary people would not turn it
> on.. whacky weirdos like you and me might do it for proof of concept
> ;)

No.  People will play with it as well and complain because their kernel 
doesn't boot anymore.  We have enough real bug reports not to add to 
them with futile ones.  And there are already way too many kernel config 
options.

Some other people will hardcode Thumb mode entry in their bootloaders.  
And if you wanted to compile your kernel in ARM mode for such a device 
then you'd have the perverse need for a shim in Thumb mode at the 
beginning of the kernel image to switch to ARM mode.

Whacky Weirdos can hack their kernel all they want.  That doesn't have 
to be sanctioned in mainline.

> All it needs is a bootloader able to fulfill it's side of the contract
> (build a thumb2 bootloader..) and jump while in Thumb mode, which I am
> 100% certain exists. It'd be a 20 line patch maximum to make U-Boot do
> this (it already can build as Thumb2 I think.. if not, there are
> patches around) through an environment variable and distros that knew
> they built in Thumb mode could simply modify the variable in boot.scr
> or so, and the jump would end up being done in Thumb. That way you
> have to kick it, but no changes are required in the kernel format
> (just in the packaging of the kernel and configuration of the
> bootloader). Guessing would be a bad idea...

The fewer contracts we have with bootloaders the better we are.  
Unfortunately those contracts are increasing in scope.  Let's avoid the 
really trivial cases if we can help it.

By mandating ARM mode, there is absolutely no guessing and no place for 
misinterpretation, buggy implementation, or other silliness of which 
bootloaders are full of.

The only good case for using Thumb mode in kernel entry is with those 
CPUs with no support for ARM mode.


Nicolas
