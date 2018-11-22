From: tiny.windzz@gmail.com (Frank Lee)
Date: Thu, 22 Nov 2018 08:55:16 +0800
Subject: [PATCH] soc: bcm: brcmstb: add of_node_put()
In-Reply-To: <1395243f-2c08-6079-e8a8-79712179fe57@gmail.com>
References: <20181121124342.21987-1-tiny.windzz@gmail.com>
 <1395243f-2c08-6079-e8a8-79712179fe57@gmail.com>
Message-ID: <CAEExFWtSwPwCFUH73GvoWKhbz8wHZbJC0fNsO=rRzgrSzEBYkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 3:23 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 11/21/2018 4:43 AM, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node returned
> > by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
>
> You probably copied/pasted this from a prior patch, the function name is
> soc_is_brcmstb() here, do you mind fixing that and also providing a
> Fixes: tag?
Hi Florian:

Do you need me to send a patch that changed the commit log or refactor
the soc_is_brcmstb()?
For example:
https://lore.kernel.org/patchwork/patch/1015523/

Yours,
    Yangtao
>
> Thanks
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/soc/bcm/brcmstb/common.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> > index 14185451901d..95b777fffee6 100644
> > --- a/drivers/soc/bcm/brcmstb/common.c
> > +++ b/drivers/soc/bcm/brcmstb/common.c
> > @@ -32,12 +32,15 @@ static const struct of_device_id brcmstb_machine_match[] = {
> >  bool soc_is_brcmstb(void)
> >  {
> >       struct device_node *root;
> > +     bool rc;
> >
> >       root = of_find_node_by_path("/");
> >       if (!root)
> >               return false;
> >
> > -     return of_match_node(brcmstb_machine_match, root) != NULL;
> > +     rc = of_match_node(brcmstb_machine_match, root) != NULL;
> > +     of_node_put(root);
> > +     return rc;
> >  }
> >
> >  u32 brcmstb_get_family_id(void)
> >
>
> --
> Florian
