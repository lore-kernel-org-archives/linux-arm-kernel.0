From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2016 16:37:51 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <20160621114849.GF29309@dhcppc9>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
 <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
 <20160615231303.GL1041@n2100.armlinux.org.uk>
 <20160621114849.GF29309@dhcppc9>
Message-ID: <20160621153751.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 05:18:49PM +0530, Pratyush Anand wrote:
> On 16/06/2016:12:13:03 AM, Russell King - ARM Linux wrote:
> > I should point out that this method should work for a zImage without
> > an appended DTB, and we have no way to update this header block for
> > the appended DTB case.
> 
> Well, I might be missing with my limited knowledge. So, just to clarify, zImage
> is "compressed image + uncompressor". In some cases it might have "+DTB".
> So, zImage should be located atleast "aligned uncompressed size" above "kernel
> base" and, initrd should be placed at "kernel base" +  "aligned uncompressed
> size" + "compressed image size" + "uncompressor size" + DTB(if any).
> 
> However, I am unable to understand that why can't we have a flag in zImage
> header block, which tells that whether a DTB has been appended in the zImage or
> not?

cat zImage foo.dtb > newImage

obviously doesn't result in the header block inside zImage being modified.
The only way around that is to have a tool which concatenates the two
and updates the header.  At that point, it's no longer simply a
concatenation.

> > So, an alternative standpoint is that we supply only the uncompressed
> > image size.  Then, the boot environment needs to understand that they
> > must allow for the compressed image and any appended DTB on top of that
> > (which it would see as one - the size of the combined image.)
> 
> So, why not we can have all three information in header ie. "uncompressed image
> size", "compressed image size" and "DTB size" if appended flag is set.

How big is the DTB size?  Without a tool to update the header, there's
no way to really know.

> > However, while that may sound like a good idea, we're falling into the
> > same trap that we've fallen into at the beginning of this thread: the
> > boot environment has to understand how the decompressor currently works,
> > and if we were to change that, this we're back to the calculation which
> > the boot environment is using not matching reality.
> 
> Currently we are discussing between 4 times to 11 times. So, if we know
> *atleast* "uncompressed image size" then this heuristic variation can be
> minimized a lot. If we do not provide header, then may be we can provide library
> to the kexec-tools which will enable us to know the length of "uncompressed
> image" when "compressed image" is provided as input.

If we provide the uncompressed size, then we know how big the uncompressed
image will be.  That much is fine, but there's more than that.

What is the padding applied to the uncompressed size?  Where does the
compressed image self-relocate to?  Where does the compressed image
relocate the DTB to?  What is the spacing between the DTB and the
compressed image?

All those are knowledge which is internal to the decompressor code.
If we supply, say, the padded uncompressed size, then we can work
around not knowing the padding in kexec.  However, we still need to
know the other details - so we still end up needing to code into
kexec (or other boot environment) a load of details specific to the
current decompressor implementation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
