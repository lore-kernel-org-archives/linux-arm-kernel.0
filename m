From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 5 Jul 2013 16:23:33 +0200
Subject: [PATCH v3 2/6] misc: sram: add ability to mark sram sections as
 reserved
In-Reply-To: <CAOMZO5AHX0UpeKQh+faPT=MfCf53eo=kXigtOZd7iuKrz-sFeA@mail.gmail.com>
References: <201307051440.19428.heiko@sntech.de>
 <201307051441.27605.heiko@sntech.de>
 <CAOMZO5AHX0UpeKQh+faPT=MfCf53eo=kXigtOZd7iuKrz-sFeA@mail.gmail.com>
Message-ID: <201307051623.33991.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 5. Juli 2013, 14:55:40 schrieb Fabio Estevam:
> On Fri, Jul 5, 2013 at 9:41 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Some SoCs need parts of their sram for special purposes. So while being
> > part of the periphal, it should not be part of the genpool controlling
> > the sram.
> > 
> > Threfore add an option mmio-sram-reserved to keep arbitary portions of
> > the sram from being part of the pool.
> > 
> > Suggested-by: Rob Herring <robherring2@gmail.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/misc/sram.txt |    8 +++
> >  drivers/misc/sram.c                             |   80
> >  +++++++++++++++++++++-- 2 files changed, 82 insertions(+), 6
> >  deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/sram.txt
> > b/Documentation/devicetree/bindings/misc/sram.txt index 4d0a00e..eae080e
> > 100644
> > --- a/Documentation/devicetree/bindings/misc/sram.txt
> > +++ b/Documentation/devicetree/bindings/misc/sram.txt
> > 
> > @@ -8,9 +8,17 @@ Required properties:
> >  - reg : SRAM iomem address range
> > 
> > +Optional properties:
> > +
> > +- mmio-sram-reserved: ordered list of reserved chunks inside the sram
> > that +  should not become part of the genalloc pool.
> > +  Format is <base size>, <base size>, ...; with base being relative to
> > the +  reg property base.
> 
> Isn't it a typo?
> 
> I think you meant:
> Format is <base start>, <reserved size>,

no, the intended format is like

<0x0 0x100>, <0x1000 0x100>, ...

base + size, base + size, and so on


> 
> > +
> > 
> >  Example:
> >  
> >  sram: sram at 5c000000 {
> >  
> >         compatible = "mmio-sram";
> >         reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000
> >         */
> > 
> > +       mmio-sram-reserved = <0x0 0x100>; /* reserve
> > 0x5c000000-0x5c000100 */
>
> > 
> >  };
