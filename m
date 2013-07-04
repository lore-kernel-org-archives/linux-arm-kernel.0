From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 04 Jul 2013 13:28:54 -0400 (EDT)
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <51D5A938.30607@gmail.com>
References: <51D5A938.30607@gmail.com>
Message-ID: <alpine.LFD.2.03.1307041322070.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Jul 2013, Daniel Mack wrote:

> Hi,
> 
> I'm facing a problem with a transition from legacy board-file driven ARM
> machines to DTB, and I'm under the impression that a solution for it
> could be of broader interest.
> 
> In short, devices that have been deployed in quantities come in three
> hardware variants, which all boot with a unique machine-id. We ship
> kernel images that have board support for all three machine types, and
> do minor fixups to platform data of some drivers at runtime, depending
> on the board revision number (passed in via ATAGs).
> 
> The built-in support for attaching a DTB to the zImage does not suffice
> here, because we have one image for all models, and also, we couldn't do
> a 'per-board-revision' selection that way either.
> 
> Unless I missed some recent discussion, this case is not easy to handle.
> Yes, I know that these kind of things should be handled by a
> next-generation bootloader, but in our case, we want to avoid a loader
> update of already shipped hardware by all means.
> 
> As a solution, I'm thinking of a small framework that could for example
> work as follows.
> 
> a) A small mechanism allows storing multiple DTB binary files inside the
> kernel binary at compile time, and a simple function can extract them
> again by name at runtime (something like what the firmware framework
> does, but I don't know if that one can be used at such an early stage in
> the boot process).
> 
> b) A DT_MACHINE_START-like macro takes both the machine ID and the name
> of a DTB file that is compiled in. When matched, generic functions would
> load the given file, populate the device tree and then conduct a generic
> DT boot for the specified platform.
> 
> c) Allow users to open-code the DTB lookup depending on whatever kind of
> runtime information (be it the board_revision or anything else).
> 
> 
> Of course, everything has to be an opt-in that stubs itself out at zero
> costs if not needed.
> 
> 
> I'm open to opinion and sugesstions :)

What you describe above more or less fits the definition of what I 
called the "impedance matcher".  However it doesn't need to be part of 
the kernel at all.  But you should make it into a separate binary.

Please have a look at the bottom of this post for a more comprehensive 
description: http://article.gmane.org/gmane.linux.ports.arm.kernel/242929


Nicolas
