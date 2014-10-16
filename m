From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Oct 2014 11:34:10 +0200
Subject: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
In-Reply-To: <543F8CD2.1010302@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130452.GD27755@sirena.org.uk>
 <543F8CD2.1010302@rock-chips.com>
Message-ID: <20141016093410.GB2200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 05:16:02PM +0800, addy ke wrote:
> On 2014/10/15 21:04, Mark Brown wrote:
> > On Wed, Oct 15, 2014 at 07:25:49PM +0800, Addy Ke wrote:

> >> +	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
> >> +		rs->speed = MAX_SCLK_OUT;

> >> +	/* the minimum divsor is 2 */
> >> +	if (rs->max_freq < 2 * rs->speed) {
> >> +		clk_set_rate(rs->spiclk, 2 * rs->speed);
> >> +		rs->max_freq = clk_get_rate(rs->spiclk);
> >> +	}

> > I'll apply this but you should be checking the return code from
> > clk_set_rate() here, please send a followup patch doing that.  It might

> If clk_set_rate return error, do I only put dev_warn here or return error value to spi core?

It'd be better to return an error if we need to set the rate and can't
do it.

> > also be worth consdering just setting the rate unconditionally here, it
> > seems like it should make things simpler.

> I think we need.
> If we set the rate unconditionally here, clk_set_rate() will be executed in each spi transfer.

Is that really such a high cost?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/b2499940/attachment.sig>
