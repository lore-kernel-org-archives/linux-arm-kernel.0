From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 09:07:01 +0000
Subject: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
In-Reply-To: <AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
	<20110112082416.GE3181@pulham.picochip.com>
	<AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
Message-ID: <20110112090701.GT11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 02:27:47PM +0530, viresh kumar wrote:
> > I think this is right, it's perfectly valid for a platform to return
> > NULL as a clk and you can pass that to clk_enable().
> >
> 
> I agree on the first part: NULL can be returned from clk_get(), but
> passing NULL to clk_enable and clk_get_rate doesn't look fine to me.

Whatever non-error cookie clk_get() passes out, clk_enable() etc must
eat, even if it contains dead flies rather than currants.  It's not
for the driver to make decisions on what clk_enable() et.al. accept,
other than as documented by the clk API - which says that errors from
clk_get() are indicated by IS_ERR(clk).

If IS_ERR(clk) is false, the driver _must_ assume that there is no error
and clk_enable() etc will accept the clk.
