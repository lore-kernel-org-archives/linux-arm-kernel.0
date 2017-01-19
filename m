From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2017 14:56:42 +0000
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
 <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
Message-ID: <20170119145642.GC27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 03:46:41PM +0100, Uwe Kleine-K?nig wrote:
> On Thu, Jan 19, 2017 at 12:35:40PM -0200, Fabio Estevam wrote:
> > Hi Uwe,
> > 
> > On Thu, Jan 19, 2017 at 12:13 PM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > 
> > > Would it be nice to add a comment about why this was added? Something to
> > > prevent a cleanup like "remove empty nodes and invalid memory
> > > configurations".
> > 
> > Do you mean something like this?
> > 
> > /* "chosen" and "memory" nodes are mandatory */
> > chosen {};
> > memory { device_type = "memory"; reg = <0 0>; };
> 
> Not very helpful comment. Something like:
> 
> 	/*
> 	 * The decompressor relies on a pre-existing chosen node to be
> 	 * available to insert the command line and merge other ATAGS
> 	 * info.
> 	 */
> 
> Is it difficult to fix the decompressor?

... and that comment would be wrong.  Yes, the decompressor relies on it,
as do some uboot versions.

> I didn't understood the breakage regarding the memory node good enough
> to suggest a comment for that.

A missing memory node appears to prevent some uboot versions supplying
any kind of memory layout to the kernel, which then causes the kernel to
crash very early during boot.

Again, this is not using appended DTB - this is using a separately loaded
DTB in uboot.  uboot fails to update the dtb if these nodes are missing.

Frankly, I think the original change (removing the skeleton.dtsi include)
was misguided and needs to be reverted - the change is imho built upon an
incorrect assumption that nothing in skeleton.dtsi is required.  That's
clearly false.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
