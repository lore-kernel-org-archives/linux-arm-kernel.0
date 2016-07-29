From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2016 09:27:14 +0100
Subject: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of
 memory ranges in device tree
In-Reply-To: <1860371.lT9GInp2C3@hactar>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar>
 <20160727232331.GY1041@n2100.armlinux.org.uk>
 <1860371.lT9GInp2C3@hactar>
Message-ID: <20160729082714.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 08:54:55PM -0300, Thiago Jung Bauermann wrote:
> Am Donnerstag, 28 Juli 2016, 00:23:31 schrieb Russell King - ARM Linux:
> > Well, ARM (and the generic code I introduced for mem_ranges) follows
> > what i386, ia64, mips, s390, and sh all do with struct memory_range
> > when used for crashdump.
> > 
> > It is extremely bad for a project to have a single structure used
> > inconsistently like this - even with generic helpers, you can't be
> > sure that the right helpers are used on the right structures, and
> > it will lead to off-by-one errors all over the place.  Just don't
> > pull crap like this, it's asking for trouble - settle on one way
> > and stick to it.
> 
> Agreed. Personally, I prefer base address and size because it's unambiguous. 
> But as long as just one convention is used and the structure and helpers 
> make it clear which one they expect, it doesn't matter that much.

Indeed.

> > Given that the majority of architectures treat .end as inclusive, I
> > think ppc* and fs2dt need to conform to the convention establised by
> > the other architectures for this structure.
> 
> So do valid_memory_range and find_memory_range in kexec/kexec.c, which 
> assume struct memory_range is end-exclusive too. I'm not sure about 
> locate_hole, it seems to assume end-inclusive but it does have a line saying 
> "size = end - start".

Unfortunately, valid_memory_range() is a mess of doing this one way and
the other:

        send   = sstart + segment->memsz - 1;
        return valid_memory_range(info, sstart, send);
...
        last = base + memsz -1;
        if (!valid_memory_range(info, base, last)) {

So, callers of valid_memory_range pass a start and inclusive end address
to valid_memory_range(), and the end address becomes "send" in this
function.

                /* Check to see if we are fully contained */
                if ((mstart <= sstart) && (mend >= send)) {

So, this also points to an inclusive end address for mend, but the
preceding line has:

                    && mend == info->memory_range[i+1].start

which doesn't, so this is buggy because it inconsistently treats the
end address as inclusive vs exclusive.

find_memory_range() looks like end-exclusive.

locate_hole() in one place treats it as end-inclusive while doing the
merge, and end-exclusive while looking for a hole.

So, these functions are a mess and need fixing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
