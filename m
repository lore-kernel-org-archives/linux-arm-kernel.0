From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Jun 2016 00:36:16 -0700
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <20160621215141.GC5783@n2100.arm.linux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
 <20160621215141.GC5783@n2100.arm.linux.org.uk>
Message-ID: <20160622073614.GZ22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [160621 14:54]:
> So that's 20.7MB, and the zImage was 3.6MB.  You're getting an
> expansion ratio of 5.7x.
> 
> To fix that, we'd need to up it to 7x, but the problem with upping
> it in this way is that it increases the requirements for the
> crashdump region too.  We can play with this number, but there will
> always be cases where it doesn't work - either because the ratio is
> too big or too small.

OK

> By way of illustration, "zImage size + MAX_RODATA_SZ + 4x zImage size"
> doesn't even work for this case, since you need about 25MB.  Your
> calculation comes out at 22MB, which is 3MB short.  Not only that, but
> it introduces (from what I can see) an irrelevant fudge factor of
> "MAX_RODATA_SZ" which has no basis in what's really going on here, and
> I'm left wondering what "MAX_RODATA_SZ" is actually referring to.

Well I thinking the section alignment split might give us some
known size for rodata, but looking at it more it's only with
DEBUG_ALIGN_RODATA. If we can't make any assumptions about the
size of the rodata, then no point adding it.

> So... I'm of the opinion that we shouldn't play with it - but instead
> try to come up with a solution which *doesn't* involve teaching kexec
> a whole load of internals about how the ARM kernel booting happens.
> 
> What's more worrying to me at the moment, though, is that the kexec code
> only tries to find memory for the actual "kernel" size, not the actual
> space required to decompress the kernel.  It could find a chunk of
> memory large enough to fit the kernel image to be loaded, but is not big
> enough to allow its decompression.  kexec is really quite a mess on
> ARM. :(

How about we check the size of RAM available, and if there is plenty
of RAM we use a safe compression ratio of 8. If RAM is a problem,
we could make the compression ratio smaller and warn about it. And
we could also allow passing the compression ratio to kexec as an
option.

I forgot if we still have some 128MB limits too..

Regards,

Tony
