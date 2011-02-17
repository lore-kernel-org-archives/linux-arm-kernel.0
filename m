From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 17 Feb 2011 15:40:15 -0500 (EST)
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <20110217185223.GA30606@n2100.arm.linux.org.uk>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
	<20110217000923.GF2364@angua.secretlab.ca>
	<20110217092617.GB24627@n2100.arm.linux.org.uk>
	<20110217175156.GB31812@angua.secretlab.ca>
	<20110217185223.GA30606@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102171456330.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Feb 2011, Russell King - ARM Linux wrote:

> On Thu, Feb 17, 2011 at 10:51:56AM -0700, Grant Likely wrote:
> > As for knowing where it can relocate to, we already know (actually
> > current code just makes an assumption) about how long the kernel
> > proper image is and where it wants to live in the zImage's head.S.
> > Assuming enough ram, if r6 reflects the size of the zImage + the size
> > of the appended data then it should be good.
> 
> That isn't a valid argument.  Just because "the decompressor already
> does it" does not mean that it'll work with ramdisks.  We've been
> lucky so far that it has worked with the kernel - and that's exactly
> what it is - luck.

Two things here:

1) It is possible to know the length of an ATAG or DT block.  The size 
   of a ramdisk image is not known without external information.

2) If the size of a ramdisk was discoverable by the zImage code, and if 
   the ramdisk image was simply appended to zImage itself, then there 
   would be no guessing as to where to allocate and load things as 
   separate blobs.

Let's suppose zImage is 1MB in size, the appended ramdisk image is 16MB, 
and the decompressed kernel is 3MB.  And for simplicity let's ignore 
TEXT_OFFSET for the moment.

If zImage is loaded at 3MB from start of physical memory (or above) then 
nothing needs to be relocated.  It will simply decompress the kernel 
from 0MB up to 3MB from start of physical memory.  If a ramdisk is 
appended to zImage then that location can be passed straight to the 
kernel.  We only need to make sure the kernel .bss is not larger than 
1MB in that case which should be the norm.  No guessing, no reliance on 
luck.  The only limitation is that you need at least 20MB of RAM here, 
and there is no way around it whatever the booting method. (Actually you 
could save 1MB by not using zImage but a straight Image, but if you're 
so tight in RAM you shouldn't use a ramdisk to start with.)

If zImage is loaded at 0MB (typical) then it has to move things around.  
Currently the code decompress the kernel and store it from the 1MB 
address up to the 4MB address, and then move the kernel back down to 0MB 
(a 3MB copy). What my patch does is to have zImage copy itself (1MB 
large) to the 3MB address and then decompress the kernel from 0MB to 
3MB.

Now if there is a ramdisk image appended to zImage, the zImage 
relocation becomes a 17MB copy.  And to be 100% safe, we might consider 
the end of the kernel .bss to determine the relocation address for 
zImage. But still, the final situation is the same as the case where no 
relocation is needed. The ramdisk image is relocated along with zImage 
to the optimal location i.e. from 4MB upwards.  Again, no guessing, no 
reliance on luck, no risk of overwriting a separately loaded ramdisk.

Of course this doesn't work on targets with segmented memory such as on 
SA1100.  For those the conventional method of loading the kernel in one 
segment and the ramdisk in another must be preserved.

But with modern ARM machines, it would be far simpler to just

	cat zImage ramdisk.gz > boot_image

and load that boot_image anywhere in memory and no bother with guesses 
as to where to separately load the ramdisk and hope it won't get 
overwritten at some point by the kernel decompressor.

But we're not there with initrd yet.  I believe the rework of the 
decompressor code has great value on its own.  And then the 
concatenation trick could be used for DTB which can be easily be self 
sized.  Doing that with a ramdisk image would require some information 
header in between.  But one step at a time.


Nicolas
