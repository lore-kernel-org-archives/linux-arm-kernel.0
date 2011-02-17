From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Feb 2011 20:48:39 -0500 (EST)
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <20110217000923.GF2364@angua.secretlab.ca>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
	<20110217000923.GF2364@angua.secretlab.ca>
Message-ID: <alpine.LFD.2.00.1102161944090.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Feb 2011, Grant Likely wrote:

> Patch looks good to me, but on a related note, I'm looking for a way
> to also find the end of .bss.
> 
> When John looks at adding support for appending an initrd and/or dtb
> to the zimage, it will be important to make sure the start of the
> initrd/dtb does not overlap the ram the kernel is expecting to be
> empty and available.  I was thinking about simply grepping System.map
> for __end and doing some sed magic to extract the offset from the
> beginning of the kernel.

I'd use the 'size' command instead:

$ arm-linux-size vmlinux
   text    data     bss     dec     hex filename
3707759  135316  137808 3980883  3cbe53 vmlinux

> Do you think that is sufficient to protect appended data images?

Starting with my compressed/head.S rework, you'd have to:

1) Detect if there is some valuable data past _edata, and if so then 
   increase the cached _edata value in r6 accordingly.  This way, if 
   zImage needs to relocate itself then that will include that data.

2) Modify the conditions and parameters for a zImage relocation to 
   ensure the end of the kernel .bss is below the start of your data.

3) Modify the relocation of .bss entries in the GOT table so .bss is 
   effectively moved after that appended data.

4) Tell the kernel about the data via extra ATAG/DTB entries.

Except for (4), this can be done with only a few assembly instructions.  
And even in the ATAG case there is a good example in 
arch/arm/boot/bootp/init.S for (4), but that could as well be done in C 
instead, like the initial patch that John Bonesio did.


Nicolas
