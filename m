From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 Nov 2013 10:35:05 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <528A4B5D.8050809@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
 <20131118152920.GL26046@ulmo.nvidia.com>
 <20131118155022.GB28334@sirena.org.uk>
 <20131118160626.GN26046@ulmo.nvidia.com>
 <528A4B5D.8050809@wwwdotorg.org>
Message-ID: <20131119093504.GF31504@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 10:16:13AM -0700, Stephen Warren wrote:
> On 11/18/2013 09:06 AM, Thierry Reding wrote:
> ...
> > Part of my point was that you could possibly still use the same IP
> > with only a modified (standard) register interface. That way no
> > licensing of third party IP would be needed. You'd only need to
> > rewrite parts of the IP to make it look (and behave) like the
> > standard one.
> > 
> > That's exactly how 16550-compatible UARTs work, isn't it? Or even
> > the way that USB (EHCI, ...) work. There's a standardize register
> > interface, possibly with a way for vendor-specific extensions, but
> > the interface itself doesn't need to be licensed, so there are no
> > additional costs to supporting the standard interface. There are
> > only the advantages of being able to reuse a well-tested body of
> > code.
> 
> Your idea would be great if it could be made to work in practice.

This wasn't really my idea, so I can't take all the credit for it. =)

> I'm not convinced how possible this would be, without ARM mandating it
> in their contractual licensing terms, or large customers mandating it
> in order to use SoCs for their flagship designs.

I don't think ARM mandating this is necessary. In the end it boils down
to faster time to market, doesn't it? I mean if you have a device that
exposes a standard set of registers and a driver for that standard set
already exists, then it's very little work to get the device working
with it. You also save a lot of work on validation.

The 16550 UART register set wasn't mandated by anyone as far as I know,
but still the majority of UART devices implement it. I guess the same is
true of EHCI or SDHCI.

Some aspects could possibly be solved by making them parts of a bus
specification I guess. If bus specifications made some provisions for
controlling the power, reset, clocking and other aspects of the IP on
that bus, that would make quite a few things easier. That isn't a new
idea of course, it's been done in other systems, such as PCI, before.

> The one fly in the ointment is that even in cases where there are
> standard register interfaces, there are always quirks in how vendors
> implement those interfaces, so HW ends up being 90-99.5% compliant
> with the interface, but with subtle differences. Take a look at
> Tegra's SDHCI, EHCI and PCIe controllers for examples! Still, I
> suppose that even with that caveat, having a 90% identical driver
> compared to a 0% identical driver would be better than where we are
> today.

Yes, that's true. The Linux 8250 driver, while generally dealing with
the same register set, still requires an awful amount of code and data
tables to make it work on the myriad of devices out there. And the set
of registers is pretty small compared to other types of hardware.

I guess in the end it boils down to a redistribution of the workload.
While I think we're doing a pretty good job with adding hardware support
in the Linux kernel, we're still struggling to keep up with new hardware
being continually added. One solution to that problem is to keep adding
massive amounts of software engineers to keep up with the changes in
hardware. Typically this has the side-effect of making the delta between
upstream and downstream kernels larger, unfortunately.

Another solution, the one discussed here, is to move more complexity
into hardware, therefore reducing the workload of software engineers by
making the job of hardware engineers harder.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/9df466d4/attachment.sig>
