From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Nov 2015 08:23:04 -0800
Subject: [linux-sunxi] [PATCH v4 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <CAGRGNgW9nVJvAcaduF0y1ptbpLA-3MkR4LCYvh-n1=mtxTyqfg@mail.gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
 <CAGRGNgW9nVJvAcaduF0y1ptbpLA-3MkR4LCYvh-n1=mtxTyqfg@mail.gmail.com>
Message-ID: <20151104162304.GZ6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

On Wed, Oct 28, 2015 at 10:12:09AM +1100, Julian Calaby wrote:
> > +       of_property_for_each_u32(node, "clock-indices", prop, p, index) {
> > +               of_property_read_string_index(node, "clock-output-names",
> > +                                             i, &clk_name);
> > +
> > +               if (index == 17 || (index >= 29 && index <= 31))
> > +                       clk_parent = AHB2;
> > +               else if (index <= 63 || index >= 128)
> > +                       clk_parent = AHB1;
> > +               else if (index >= 64 && index <= 95)
> > +                       clk_parent = APB1;
> > +               else if (index >= 96 && index <= 127)
> > +                       clk_parent = APB2;
> 
> A way to make this reusable in the future might be to encode it in a
> structure like:
> 
> static const struct bus_clock_paths sun8i_h3_bus_clock_paths __initdata = {
>         {.parent = 2, .min = 17, .max = 17}, /* index 17 is from AHB2 */
>         {.parent = 2, .min = 29, .max = 31}, /* AHB2 bank */
>         {.parent = 1, .min = 63, .max = 128}, /* AHB1 bank */
> ...
>         {}
> };
> 
> Then the code here can be reused for other clocks like this in the
> future without too much bloat. (And this would potentially could be
> generic enough for other platforms.)

We don't really need that at the moment. There's not point in writing
more complicated code to support a use case we don't have yet.

(However, something along these lines will definitely be needed if we
ever have another SoC having the same bus gates madness)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/b4739fa1/attachment.sig>
