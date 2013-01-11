From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 23:24:39 +0000
Subject: [PATCH RFT 3/3] ARM: tegra: dts: seaboard: enable keyboard
In-Reply-To: <50F09BC7.90607@wwwdotorg.org>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
 <1357911185-11048-3-git-send-email-ldewangan@nvidia.com>
 <50F09BC7.90607@wwwdotorg.org>
Message-ID: <20130111232438.GN23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 04:09:59PM -0700, Stephen Warren wrote:
> On 01/11/2013 06:33 AM, Laxman Dewangan wrote:
> > 	kbc->clk = clk_get(&pdev->dev, NULL);
> > 	if (IS_ERR(kbc->clk)) {
> > 		dev_err(&pdev->dev, "failed to get keyboard clock\n");
> > 		err = PTR_ERR(kbc->clk);
> > 		goto err_iounmap;
> > 	}
> 
> Should that check be if (!kbc-clk) instead? Or does the common clock
> framework require if (IS_ERR_OR_NULL(kbc->clk)); hopefully not since
> IS_ERR_OR_NULL shouldn't be used any more.

/**
 * clk_get - lookup and obtain a reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock consumer ID
 *
 * Returns a struct clk corresponding to the clock producer, or
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * valid IS_ERR() condition containing errno.  ...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Or, put another way:

	If (!IS_ERR(clk))
		The_Clock_Is_Valid();
	Else
		The_Clock_Is_Invalid();
		The_Error = PTR_ERR(clk);
