From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Jun 2016 01:51:07 -0700
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <20160622082958.GD5783@n2100.arm.linux.org.uk>
References: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
 <20160621215141.GC5783@n2100.arm.linux.org.uk>
 <20160622073614.GZ22406@atomide.com>
 <20160622082958.GD5783@n2100.arm.linux.org.uk>
Message-ID: <20160622085105.GE22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [160622 01:32]:
> When CONFIG_DEBUG_RODATA is enabled, we align the text, read-only data,
> data, and so on to 1MB boundaries so that we can change the permissions
> of the sections to enforce the properties of the various ELF segments.
> This padding massively inflates the size of the run-time kernel image,
> and can result in megabytes of wastage (if we're as little as one byte
> into 1MB, we have to round up to the next megabyte.)

Yes understood, and looks like we cannot make any assumptions about
what the alignment might be.

> The padding, being a string of zeros, is very compressable, and this
> increases the compression ratio.
> 
> The BSS is not included in the compressed image, but needs to be taken
> account of when avoiding overwriting the DTB.
> 
> > How about we check the size of RAM available, and if there is plenty
> > of RAM we use a safe compression ratio of 8. If RAM is a problem,
> > we could make the compression ratio smaller and warn about it. And
> > we could also allow passing the compression ratio to kexec as an
> > option.
> 
> You do know that you can already pass the "size" of the kernel to be
> reserved to kexec.  --image-size.  It's not documented in --help, but
> it is there (which is another annoying thing about ARM kexec...)

Oh ok that's nice.

Regards,

Tony
