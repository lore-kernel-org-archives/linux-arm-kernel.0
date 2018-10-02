From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 2 Oct 2018 13:59:18 +0200
Subject: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is
 enabled
In-Reply-To: <13b4b871-8f81-d007-ef37-eb697f984f01@linaro.org>
References: <20181002110246.3175-1-brgl@bgdev.pl>
 <13b4b871-8f81-d007-ef37-eb697f984f01@linaro.org>
Message-ID: <CAMpxmJUf8NdCHXVMxZVfO20ddKFdFSxzo6xkcL=6Ve0TC_GY-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wt., 2 pa? 2018 o 13:49 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa?(a):
>
>
>
> On 02/10/18 12:02, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The following warning is produced when building nvmem core if
> > CONFIG_OF is disabled:
> >
> > drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined but not used [-Wunused-function]
> >   nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> >   ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > This is caused by the fact that the only caller of this routine is
> > under an ifdef depending on this option. Fix it by adding a relevant
> > ifdef to the function in question as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   drivers/nvmem/core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index cc815bb2eebd..65f61cd0a687 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -492,6 +492,7 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
> >       return rval;
> >   }
> >
> > +#if IS_ENABLED(CONFIG_OF)
>
> You should probably attribute the function with "__maybe_unused"
> Instead of adding this condition.
>

Sounds better indeed. I'll resend tomorrow to avoid spamming.

Bart

> --srini
>
>
> >   static struct nvmem_cell *
> >   nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> >   {
> > @@ -507,6 +508,7 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> >
> >       return cell;
> >   }
> > +#endif
> >
> >   static struct nvmem_cell *
> >   nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
> >
