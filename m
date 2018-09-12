From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 12 Sep 2018 11:33:45 +0200
Subject: [PATCH v3 16/21] nvmem: add a notifier chain
In-Reply-To: <20180912075129.25185-17-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
 <20180912075129.25185-17-brgl@bgdev.pl>
Message-ID: <CAMRc=MdoUon+cCOqLaNMN+814bg+t7Ltv_2ysOvztP9B93dAYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-12 9:51 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add a blocking notifier chain with four events (add and remove for
> both devices and cells) so that users can get notified about the
> addition of nvmem resources they're waiting for.
>
> We'll use this instead of the at24 setup callback in the mityomapl138
> board file.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/nvmem/core.c           | 36 ++++++++++++++++++++++++++++++++++
>  include/linux/nvmem-consumer.h | 21 ++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9cc86d131e1e..af6f7163cb67 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -65,6 +65,8 @@ static LIST_HEAD(nvmem_cell_tables);
>  static DEFINE_MUTEX(nvmem_lookup_mutex);
>  static LIST_HEAD(nvmem_lookup_list);
>
> +static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  static struct lock_class_key eeprom_lock_key;
>  #endif
> @@ -300,6 +302,7 @@ static struct nvmem_device *nvmem_find(const char *name)
>
>  static void nvmem_cell_drop(struct nvmem_cell *cell)
>  {
> +       blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
>         mutex_lock(&nvmem_mutex);
>         list_del(&cell->node);
>         mutex_unlock(&nvmem_mutex);
> @@ -319,6 +322,7 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
>         mutex_lock(&nvmem_mutex);
>         list_add_tail(&cell->node, &cell->nvmem->cells);
>         mutex_unlock(&nvmem_mutex);
> +       blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
>  }
>
>  static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> @@ -434,6 +438,32 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
>         return 0;
>  }
>
> +/**
> + * nvmem_register_notifier() - Register a notifier block for nvmem events.
> + *
> + * @nb: notifier block to be called on nvmem events.
> + *
> + * Return: 0 on success, negative error number on failure.
> + */
> +int nvmem_register_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_register_notifier);
> +
> +/**
> + * nvmem_unregister_notifier() - Unregister a notifier block for nvmem events.
> + *
> + * @nb: notifier block to be unregistered.
> + *
> + * Return: 0 on success, negative error number on failure.
> + */
> +int nvmem_unregister_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
> +
>  static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
>  {
>         const struct nvmem_cell_info *info;
> @@ -647,6 +677,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>         if (rval)
>                 goto err_remove_cells;
>
> +       rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> +       if (rval)
> +               goto err_remove_cells;
> +
>         return nvmem;
>
>  err_remove_cells:
> @@ -675,6 +709,8 @@ static void nvmem_device_release(struct kref *kref)
>         nvmem_device_remove_all_cells(nvmem);
>         device_del(&nvmem->dev);
>         put_device(&nvmem->dev);
> +
> +       blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);

Ugh this is wrong, it should be called before all the other code in
this function. I'll resend in the next version after reviews.

Bart

>  }
>
>  /**
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 27eee3945405..0326b52e906b 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -14,6 +14,7 @@
>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/notifier.h>
>
>  struct device;
>  struct device_node;
> @@ -47,6 +48,13 @@ struct nvmem_cell_lookup {
>         struct list_head        node;
>  };
>
> +enum {
> +       NVMEM_ADD = 1,
> +       NVMEM_REMOVE,
> +       NVMEM_CELL_ADD,
> +       NVMEM_CELL_REMOVE,
> +};
> +
>  #if IS_ENABLED(CONFIG_NVMEM)
>
>  /* Cell based interface */
> @@ -80,6 +88,9 @@ void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
>  void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries,
>                             size_t nentries);
>
> +int nvmem_register_notifier(struct notifier_block *nb);
> +int nvmem_unregister_notifier(struct notifier_block *nb);
> +
>  #else
>
>  static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
> @@ -179,6 +190,16 @@ nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
>  static inline void
>  nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
>
> +static inline int nvmem_register_notifier(struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int nvmem_unregister_notifier(struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +
>  #endif /* CONFIG_NVMEM */
>
>  #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> --
> 2.18.0
>
