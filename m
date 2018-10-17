From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 17 Oct 2018 12:59:39 +0000
Subject: [PATCH v4 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <CAOMZO5BMeHjsyZWhUb5RmEBRCYViUN-Vx8KyLBWtDJGKBHHpCg@mail.gmail.com>
References: <cover.1539779579.git.leonard.crestez@nxp.com>
 <95dce7010676581691b1ac9906e9298470e0aa1a.1539779579.git.leonard.crestez@nxp.com>
 <CAOMZO5BMeHjsyZWhUb5RmEBRCYViUN-Vx8KyLBWtDJGKBHHpCg@mail.gmail.com>
Message-ID: <a97517bf72f649915bccf555ab7d3c8c4551298d.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-10-17 at 09:48 -0300, Fabio Estevam wrote:
> On Wed, Oct 17, 2018 at 9:38 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > 
> > On 6ull and 6sll the DCP block has a clock which needs to be explicitly
> > enabled.
> > 
> > Add minimal handling for this at probe/remove time.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Please always explain what changed from the previous patch version.

There is a changelog in the cover letter.

> > +       /* Restart the DCP block. */
> > +       ret = stmp_reset_block(sdcp->base);
> > +       if (ret) {
> > +               dev_err(dev, "Failed reset\n");
> > +               goto err_disable_unprepare_clk;
> > +       }
> 
> This seems like an unrelated change that should be in a separate patch.
> 
> Also, this was not present in v3, so it is better to explain that this
> has been introduced in v4.

This only looks slightly odd in git diff but it's not unrelated.

I placed clk get/prepare/enable just before stmp_reset_block and made
stmp_reset_block print a message and goto err_disable_unprepare_clk on
failure instead of just "if (ret) return ret;"
