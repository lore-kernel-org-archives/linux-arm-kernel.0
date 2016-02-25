From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 10:11:05 -0800
Subject: [PATCH] clk: sunxi: allow PLL6 clock to be reused
In-Reply-To: <56CAD72D.7050102@arm.com>
References: <1456105198-25295-1-git-send-email-andre.przywara@arm.com>
 <CAGb2v66Fkvpqay+pNYjN1KP_KSUmv-du+PVSsyeuK+Y7bzEt+g@mail.gmail.com>
 <56CAD72D.7050102@arm.com>
Message-ID: <20160225181105.GE4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:38:53AM +0000, Andre Przywara wrote:
> >> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> >> index 1e63c5b..3a7da86 100644
> >> --- a/drivers/clk/sunxi/clk-factors.h
> >> +++ b/drivers/clk/sunxi/clk-factors.h
> >> @@ -36,6 +36,7 @@ struct factors_data {
> >>         void (*getter)(struct factors_request *req);
> >>         void (*recalc)(struct factors_request *req);
> >>         const char *name;
> >> +       int name_idx;
> > 
> > I would drop the .name field. It was a bad workaround
> > due to limitations of the factors clk code at the time
> > by me. We really shouldn't hard-code the name if we want
> > to reuse the driver.
> 
> I know what you mean (my first thought, too) and I totally agree, but we
> need it still for PLL5, which does not carry the original name in the DT
> output names.
> So at least this workaround here does not work, I guess we have to come
> up with something different - which would be a different patch.
> I can take a look into this later.

Actually, it could be easily worked around. Always take the first
clock output name, take whatever is before '_', and you can remove the
name field entirely.

Jens did something along these lines here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379900.html

Maybe we should simply rebase this patch, and remove the part that
falls back on the name field.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/aba3505b/attachment.sig>
