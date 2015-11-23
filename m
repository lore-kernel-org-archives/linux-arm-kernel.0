From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Nov 2015 12:29:15 +0100
Subject: [linux-sunxi] Re: [PATCH v4 4/6] reset: sunxi: Add Allwinner H3
 bus resets
In-Reply-To: <CAGb2v665C-EM4t1h3rQ=hNR=1Z4J2mp7DRy_zM8-OkCXzZ03iw@mail.gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-5-git-send-email-jenskuske@gmail.com>
 <13919923.o3Dj9msmoa@wuerfel> <20151104163014.GB6114@lukather>
 <20151105074730.fd6a9d57a1f2c7933478c680@free.fr>
 <CAGb2v665C-EM4t1h3rQ=hNR=1Z4J2mp7DRy_zM8-OkCXzZ03iw@mail.gmail.com>
Message-ID: <20151123112915.GU32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 23, 2015 at 03:41:52PM +0800, Chen-Yu Tsai wrote:
> On Thu, Nov 5, 2015 at 2:47 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > On Wed, 4 Nov 2015 08:30:14 -0800
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >
> >> Hi Arnd,
> >>
> >> On Fri, Oct 30, 2015 at 09:27:03AM +0100, Arnd Bergmann wrote:
> >> > On Tuesday 27 October 2015 17:50:24 Jens Kuske wrote:
> >> > >
> >> > > +static int sun8i_h3_bus_reset_xlate(struct reset_controller_dev *rcdev,
> >> > > +                                   const struct of_phandle_args *reset_spec)
> >> > > +{
> >> > > +       unsigned int index = reset_spec->args[0];
> >> > > +
> >> > > +       if (index < 96)
> >> > > +               return index;
> >> > > +       else if (index < 128)
> >> > > +               return index + 32;
> >> > > +       else if (index < 160)
> >> > > +               return index + 64;
> >> > > +       else
> >> > > +               return -EINVAL;
> >> > > +}
> >> > > +
> >> > >
> >> >
> >> > This looks like you are doing something wrong and should either
> >> > put the actual number into DT,
> >>
> >> This is the actual number, except that there's some useless registers
> >> in between. Allwinner documents it like that:
> >>
> >> 0x0   Reset 0
> >> 0x4   Reset 1
> >> 0xc   Reset 2
> >>
> >> So we have to adjust the offset to account with the blank register in
> >> between (0x8).
> >>
> >> > or use a two-cell representation, with the first cell indicating the
> >> > block (0, 1 or 2), and the second cell the index.
> >>
> >> And the missing register is not a block either.
> >>
> >> That would also imply either changing the bindings of that driver (and
> >> all the current DTS that are using it), or introducing a whole new
> >> driver just to deal with some extraordinary offset calculation.
> >
> > In the H3, the holes are not used, but what would occur if these holes
> > would be used for some other purpose in future SoCs? Double mapping?
> 
> We'd have a different compatible string for it.
> 
> My suggestion for the resets is to just split them into 3 nodes: AHB
> (since AHB1 and AHB2 devices are mixed together in the bunch), APB1,
> and APB2 reset controls.
> 
> This follows what we have for existing SoCs, and gets rid of the unused
> hole. We can use the existing "allwinner,sun6i-a31-clock-reset" and
> "allwinner,sun6i-a31-ahb1-reset" compatibles.

That seems a bit weird to have a single clock and split resets, but as
long as they are not mixed, and you can compute easily the id from the
datasheet, ok.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/0f5b4408/attachment.sig>
