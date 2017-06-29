From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 13:49:05 +0200
Subject: [linux-sunxi] [PATCH v4 5/6] ARM: sun7i: Convert to CCU
In-Reply-To: <a08cbe0d-dad4-7d0c-9845-452e0d6e3f03@arm.com>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <ac9cc7f0a67d3e9e5edd0d5eb21cc60820c2b457.1498422562.git-series.plaes@plaes.org>
 <a08cbe0d-dad4-7d0c-9845-452e0d6e3f03@arm.com>
Message-ID: <20170629114905.hr6icycjcn2fekfd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 11:57:05AM +0100, Andre Przywara wrote:
> Hi,
> 
> On 25/06/17 21:45, Priit Laes wrote:
> > Convert sun7i-a20.dtsi to new CCU driver.
> 
> I know that some people hat^Wget annoyed by me asking this, but anyway:
> 
> Why do we actually need this?
> 
> This ultimately makes the DT incompatible with older kernels (as
> actually shipped by distros today).
>
> So if we for instance use UEFI boot or otherwise just use "one golden
> DT" to drive all kernels (like using the DT from U-Boot), we now don't
> have one good DT that fits all.

What is broken exactly?

> This is really a showstopper for boards which ship a DT in firmware
> (in SPI flash, for instance, or on some eMMC).
>
> So:
> - Do we actually need to change the .dtsi? The old .dtsi should still work.

It does.

> - Is there anything that the new and fancy clocks gives us over the
> existing clocks? If yes, that should be a  stated in the commit message
> or cover letter.

Yes, support for all the clocks used in the SoC, and not a single
fraction of them (which will reduce the number of additions of new
bindings and drivers, which will in turn make the DT have less
changes, which will make it far more easier for distros and / or
firmwares to ship an immutable DT).

> - Why do we change the clocks for those older SoCs in the first place?
> Can't we just keep on using what worked for years?

Please tell me where the displays clocks, CSI or HDMI clocks are in
the old code.

> I think we really can't remove the old code anyway.

We don't.

> The new clock driver moves information from the DT into the kernel. That
> means it is no longer available for a DT consumer and the SoC details
> (which clocks is located where, for instance), have to be replicated to
> other DT users (U-Boot, *BSD, you-name-it). We already came across this
> issue when looking at converting U-Boot over to use DT clocks.
> Also it ultimately requires kernel changes for each new SoC, even if it
> only differs in some detail which could be perfectly modelled in DT
> (think of H3 vs. H5).

Doing otherwise would also assume that you have a perfect
understanding of all the clocks interactions, relationship and
computations from day one, which is something the old code proved that
it was unreasonable.

The new binding also makes it easier to add SCPI that you're
interested in iirc, where you basically just have to change the CCU
compatible, and be done with it as long as you use the same IDs.

It also lowers the barrier of entry for people that would want to
write new drivers, since the first thing you'd need to do otherwise
would be to create a clock driver for that, which is yet another thing
to learn.

The reduced duplication is also neat and reduces the number of similar
bugs in each and every clock, even though it's not related to clocks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/b3e8c529/attachment.sig>
