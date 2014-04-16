From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 17:26:01 +0900
Subject: [PATCH v5 08/20] ARM: shmobile: r8a7779: Add helper to read mode
 pins
In-Reply-To: <CAMuHMdUuswCe7XB=PkVkP6nD9bvQ1oXCokSDveoZ9_R--Z6Ogw@mail.gmail.com>
References: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
 <1397613454-7522-9-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXVAaU=eEBr4hwfbz3TGL+k0NHxGtzh-uuzFwuUqeNA9Q@mail.gmail.com>
 <20140416075501.GE12344@verge.net.au>
 <CAMuHMdUuswCe7XB=PkVkP6nD9bvQ1oXCokSDveoZ9_R--Z6Ogw@mail.gmail.com>
Message-ID: <20140416082558.GF12344@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 10:12:32AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Apr 16, 2014 at 9:55 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > +u32 __init r8a7779_read_mode_pins(void)
> >> > +{
> >> > +       void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
> >> > +       u32 mode;
> >> > +
> >> > +       BUG_ON(!modemr);
> >> > +       mode = ioread32(modemr);
> >> > +       iounmap(modemr);
> >> > +
> >> > +       return mode;
> >> > +}
> >>
> >> No caching, cfr. rcar_gen2_read_mode_pins()?
> >
> > I have one question about caching, which IIRC you
> > implemented for R-Car Gen 2. Is the code called often enough
> > that it makes any difference?
> 
> 2 times. (Add 1 more time with "[PATCH 1/5] [DEBUG] ARM: shmobile:
>  r8a7791: Disable MSTP clocks during boot" applied).
> 
> I agree it's not much, I'm mostly concerned about the ioremap()/iounmap()
> pair, which is expensive compared to using a cached integer value.

Thanks, I understand. I agree its reasonable
to implement caching for this.
