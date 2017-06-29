From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 13:53:57 +0200
Subject: [linux-sunxi] [PATCH v4 5/6] ARM: sun7i: Convert to CCU
In-Reply-To: <20170629132812.52ce1214d6967b82da52123e@bidouilliste.com>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <ac9cc7f0a67d3e9e5edd0d5eb21cc60820c2b457.1498422562.git-series.plaes@plaes.org>
 <a08cbe0d-dad4-7d0c-9845-452e0d6e3f03@arm.com>
 <20170629132812.52ce1214d6967b82da52123e@bidouilliste.com>
Message-ID: <20170629115357.sxs3tjmhfncfvtpj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 01:28:12PM +0200, Emmanuel Vadot wrote:
> On Thu, 29 Jun 2017 11:57:05 +0100
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
> > Hi,
> > 
> > On 25/06/17 21:45, Priit Laes wrote:
> > > Convert sun7i-a20.dtsi to new CCU driver.
> > 
> > I know that some people hat^Wget annoyed by me asking this, but anyway:
> > 
> > Why do we actually need this?
> 
>  No. I can understand the need for clkng/sunxi-ng/whatever you call it,
> it's not that bad (but see below) to add a new SoC on FreeBSD now that
> I've added the framework, but breaking old SoC that were perfectly fine
> isn't acceptable.

We haven't broken it.

>  It also mean that, on FreeBSD, we still have patches for sun7i dts to
> add hdmi support (which we have since a year or so) because last time
> someone (I think plaes) wanted to add clock node for it, it was said
> that it was needed to move to clkng first.

This is a circular argument. It wouldn't have been the case with
sunxi-ng, since we would have had that clock from the start...

> > This ultimately makes the DT incompatible with older kernels (as
> > actually shipped by distros today).
> 
>  Yes, right now sun5i support is broken in FreeBSD because I couldn't
> find the time to make a driver for it yet.

Probably because you merged new DTs without updating the code. That
has nothing to do with backward compatibility, the old DT would still
work fine.

> > So if we for instance use UEFI boot or otherwise just use "one golden
> > DT" to drive all kernels (like using the DT from U-Boot), we now don't
> > have one good DT that fits all. This is really a showstopper for boards
> > which ship a DT in firmware (in SPI flash, for instance, or on some eMMC).
> > So:
> > - Do we actually need to change the .dtsi? The old .dtsi should still work.
> > - Is there anything that the new and fancy clocks gives us over the
> > existing clocks? If yes, that should be a  stated in the commit message
> > or cover letter.
> > - Why do we change the clocks for those older SoCs in the first place?
> > Can't we just keep on using what worked for years? I think we really
> > can't remove the old code anyway.
> > 
> > The new clock driver moves information from the DT into the kernel. That
> > means it is no longer available for a DT consumer and the SoC details
> > (which clocks is located where, for instance), have to be replicated to
> > other DT users (U-Boot, *BSD, you-name-it). We already came across this
> > issue when looking at converting U-Boot over to use DT clocks.
> > Also it ultimately requires kernel changes for each new SoC, even if it
> > only differs in some detail which could be perfectly modelled in DT
> > (think of H3 vs. H5).
> 
>  The last point is very interesting, before adding a new Allwinner SoC
> was just a matter of maybe handling one/two new clocks (at least to
> have something that 'just boots'), now it's a whole new big boring file
> to write while reading datasheet.

You can definitely do that with sunxi-ng bindings if you want. You
just have to populate only the IDs that are of interest to you.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/be8e70a7/attachment.sig>
