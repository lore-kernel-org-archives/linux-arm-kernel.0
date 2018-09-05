From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 5 Sep 2018 16:59:45 +0200
Subject: [PATCH 11/13] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <CAMRc=MfbiwRPP9=0e4P-8zYOPhXvT7kL8=W8C2E27HXuCE2Aew@mail.gmail.com>
References: <20180905095738.26406-1-brgl@bgdev.pl>
 <20180905095738.26406-12-brgl@bgdev.pl>
 <20180905155741.22b7d0ef@bbrezillon>
 <CAMRc=Mco7Tbk5P_mgv49f+3j9DKYk5AL6EjPhwF7M=Hb7o5-Mw@mail.gmail.com>
 <20180905162135.700d2145@bbrezillon>
 <CAMRc=MfbiwRPP9=0e4P-8zYOPhXvT7kL8=W8C2E27HXuCE2Aew@mail.gmail.com>
Message-ID: <20180905165945.6101d62e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Sep 2018 16:47:57 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-09-05 16:21 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Wed, 5 Sep 2018 16:00:36 +0200
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> >> 2018-09-05 15:57 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:  
> >> > On Wed,  5 Sep 2018 11:57:36 +0200
> >> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >> >  
> >> >>
> >> >> +struct nvmem_cell_lookup {
> >> >> +     const char              *nvmem_name;
> >> >> +     const char              *dev_id;  
> >> >
> >> > Shouldn't we have a con_id here?
> >> >  
> >> >> +     const char              *cell_id;
> >> >> +     struct list_head        node;
> >> >> +};  
> >>
> >> I wanted to stay in line with the current API - nvmem_cell_get() takes
> >> as argument a string called cell_id. I wanted to reflect that here.  
> >
> > Actually, you need both. con_id is the name you would have in your DT
> > in the nvmem-cell-names property, cell_id is the name of the cell
> > you'd find under the nvmem device node.
> >
> > Let's take an example:
> >
> >         mydev {
> >                 #nvmem-cell-names = "mac-address", "revision";
> >                 #nvmem-cells = <&cell1>, <&cell2>;
> >         };
> >
> >         mynvmemdev {
> >                 #size-cells = <1>;
> >                 #address-cells = <1>;
> >
> >                 cell1: foo at 0 {
> >                         reg = <0x0 0x6>;
> >                 };
> >
> >                 cell2: bar at 6 {
> >                         reg = <0x6 0x10>;
> >                 };
> >         };
> >
> > this can be described the same way using a consumer lookup table:
> >
> > struct nvmem_cell_lookup_entry {
> >         const char *con_id;
> >         const char *nvmem_name;
> >         const char *cell_name;
> > };
> >
> > struct nvmem_cell_lookup_table {
> >         struct list_head node;
> >         const char *dev_id;
> >         unsigned int nentries;
> >         const struct nvmem_cell_lookup_entry *entries;
> > }
> >
> > static const struct nvmem_cell_lookup_entry mydev_nvmem_cells[] = {
> >         {
> >                 .con_id = "mac-address",
> >                 .nvmem_name = "mynvmemdev",
> >                 .cell_name = "foo",
> >         },
> >         {
> >                 .con_id = "revision",
> >                 .nvmem_name = "mynvmemdev",
> >                 .cell_name = "bar",
> >         },
> > }
> >
> > static const struct nvmem_cell_lookup_table mydev_nvmem_lookup = {
> >         .dev_id = "mydev.0",
> >         .nentries = ARRAY_SIZE(mydev_nvmem_cells),
> >         .entries = mydev_nvmem_cells,
> > };
> >
> >
> > ...
> >
> >         nvmem_add_cell_lookups(&mydev_nvmem_lookup);  
> 
> Ok I get it. Shouldn't we change the argument name of nvmem_cell_get()
> and friends from 'name' to 'con_id' or simply 'id' similarly to what
> other frameworks do to avoid such confusion?

I'll let Srinivas answer that one.

> 
> I also don't see a need for splitting the lookup into two structures
> here. Something like:
> 
> struct nvmem_cell_lookup {
>         const char *nvmem_name;
>         const char *cell_name;
>         const char *dev_id;
>         const char *con_id;
> };
> 
> Would be perfectly fine and would allow to register all lookups for
> given machine with a single call.

Yep, makes sense.
