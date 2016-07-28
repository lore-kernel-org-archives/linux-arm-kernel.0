From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu, 28 Jul 2016 20:54:55 -0300
Subject: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of memory
 ranges in device tree
In-Reply-To: <20160727232331.GY1041@n2100.armlinux.org.uk>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar> <20160727232331.GY1041@n2100.armlinux.org.uk>
Message-ID: <1860371.lT9GInp2C3@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 28 Juli 2016, 00:23:31 schrieb Russell King - ARM Linux:
> On Wed, Jul 27, 2016 at 07:45:13PM -0300, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > Am Dienstag, 19 Juli 2016, 23:28:13 schrieb Geoff Levand:
> > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > 
> > > The end address of "reg" attribute in device tree's memory should be
> > > inclusive.
> > 
> > Actually, there's a bug/inconsistency in kexec-tools right now.
> > 
> > crashdump-arm.c expect usablemem_rgns.ranges[i].end to be the last byte
> > in the range, but crashdump-powerpc.c, crashdump-ppc64.c and fs2dt.c
> > expect it to be the first byte after the range.
> 
> Well, ARM (and the generic code I introduced for mem_ranges) follows
> what i386, ia64, mips, s390, and sh all do with struct memory_range
> when used for crashdump.
> 
> It is extremely bad for a project to have a single structure used
> inconsistently like this - even with generic helpers, you can't be
> sure that the right helpers are used on the right structures, and
> it will lead to off-by-one errors all over the place.  Just don't
> pull crap like this, it's asking for trouble - settle on one way
> and stick to it.

Agreed. Personally, I prefer base address and size because it's unambiguous. 
But as long as just one convention is used and the structure and helpers 
make it clear which one they expect, it doesn't matter that much.

> Given that the majority of architectures treat .end as inclusive, I
> think ppc* and fs2dt need to conform to the convention establised by
> the other architectures for this structure.

So do valid_memory_range and find_memory_range in kexec/kexec.c, which 
assume struct memory_range is end-exclusive too. I'm not sure about 
locate_hole, it seems to assume end-inclusive but it does have a line saying 
"size = end - start".

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
