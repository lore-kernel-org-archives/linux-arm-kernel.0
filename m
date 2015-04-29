From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 Apr 2015 14:08:58 +0800
Subject: [PATCH] ARM: imx: correct Audio/Video PLL rate calculation formula
In-Reply-To: <20150428094657.GA15036@shlinux1.ap.freescale.net>
References: <1429810455-22447-1-git-send-email-b20788@freescale.com>
 <20150427142941.GA1788@dragon>
 <20150428094657.GA15036@shlinux1.ap.freescale.net>
Message-ID: <20150429060857.GB27573@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Tue, Apr 28, 2015 at 05:47:00PM +0800, Anson Huang wrote:
> On Mon, Apr 27, 2015 at 10:29:43PM +0800, Shawn Guo wrote:
> > On Fri, Apr 24, 2015 at 01:34:15AM +0800, Anson Huang wrote:
> > > The audio/video PLL's rate calculation formula is as below in RM:
> > > 
> > > Fref * (DIV_SELECT + NUM / DENOM),
> > > 
> > > in original clk-pllv3's code, below code is used:
> > > 
> > > (parent_rate * div) + ((parent_rate / mfd) * mfn
> > > 
> > > as it does NOT consider the float data using div, so below
> > > calculation formula should be used as a decent method:
> > > 
> > > (parent_rate * div) + ((parent_rate * mfn) / mfd)
> > > 
> > > and we also need to consider parent_rate * mfd may exceed
> > > a 32 bit value, 64 bit value should be used.
> > 
> > Can you provide some real world data (PLL output frequency) to
> > demonstrate the difference between old and new formula?
> > 
> > Shawn
> > 
> 
> I happen to meet this issue on i.MX7D, on i.MX7D, DRAM PLL is a
> Audio/Video type PLL, the target freq is 1066MHz, the register
> settings are as below:
> 
> PLL_DDRn: 8060202C   -> div = 0x2C
> DDR_NUM: 06AAAC4D    -> mfn = 0x6AAAC4D
> DDR_DENOM: 100003EC  -> mfd = 0x100003EC
> 
> parent_rate = 24MHz.
> 
> with old formula, the (parent_rate / mfd) * mfn = 0
> with new formula, the (parent_rate * mfn) / mfd = 10
> 
> so old formula gets PLL_DDR = 1056MHz, new formuls gets
> PLL_DDR = 1066MHz.
> 
> For other Audio/Video PLL, the result is also different, but
> the difference is less then 1MHz.
> 
> That is why I do this patch.

Okay.  Can you please add these data into commit log and resend the
patch?  Also, all i.MX clock drivers are being moved into
drivers/clk/imx/, so please rebase your patch on my imx/clk-move
branch.

Shawn
