From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 10 Sep 2018 10:17:48 +0200
Subject: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
Message-ID: <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-10 9:32 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 07/09/18 11:07, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Add a way for machine code users to associate devices with nvmem cells.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/nvmem/core.c          | 143 +++++++++++++++++++++++++++-------
>>   include/linux/nvmem-machine.h |  16 ++++
>>   2 files changed, 132 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index da7a9d5beb33..9e2f9c993a07 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
>>   static DEFINE_MUTEX(nvmem_cell_mutex);
>>   static LIST_HEAD(nvmem_cell_tables);
>>   +static DEFINE_MUTEX(nvmem_lookup_mutex);
>> +static LIST_HEAD(nvmem_lookup_list);
>> +
>>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>>     #ifdef CONFIG_DEBUG_LOCK_ALLOC
>> @@ -285,6 +288,18 @@ static struct nvmem_device *of_nvmem_find(struct
>> device_node *nvmem_np)
>>         return to_nvmem_device(d);
>>   }
>>   +static struct nvmem_device *nvmem_find(const char *name)
>> +{
>> +       struct device *d;
>> +
>> +       d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
>> +
>> +       if (!d)
>> +               return NULL;
>> +
>> +       return to_nvmem_device(d);
>> +}
>> +
>
> This is removed and added back in same patch, you should consider
> positioning the caller if possible to avoid any un-necessary changes.
>
>>   static void nvmem_cell_drop(struct nvmem_cell *cell)
>>   {
>>         mutex_lock(&nvmem_mutex);
>> @@ -421,6 +436,21 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem,
>> int index)
>>         return cell;
>>   }
>>   +static struct nvmem_cell *
>> +nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>> +{
>> +       struct nvmem_cell *cell = ERR_PTR(-ENOENT);
>> +       struct nvmem_cell_lookup *lookup;
>> +       struct nvmem_device *nvmem;
>> +       const char *dev_id;
>> +
>> +       if (!dev)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       dev_id = dev_name(dev);
>> +
>> +       mutex_lock(&nvmem_lookup_mutex);
>> +
>> +       list_for_each_entry(lookup, &nvmem_lookup_list, node) {
>> +               if ((strcmp(lookup->dev_id, dev_id) == 0) &&
>> +                   (strcmp(lookup->con_id, con_id) == 0)) {
>> +                       /* This is the right entry. */
>> +                       nvmem = __nvmem_device_get(NULL,
>> lookup->nvmem_name);
>> +                       if (!nvmem) {
>> +                               /* Provider may not be registered yet. */
>> +                               cell = ERR_PTR(-EPROBE_DEFER);
>> +                               goto out;
>> +                       }
>> +
>> +                       cell = nvmem_find_cell_by_name(nvmem,
>> +                                                      lookup->cell_name);
>> +                       if (!cell)
>> +                               goto out;
>
> Here nvmem refcount has already increased, you should probably fix this!

Indeed.

>>
>> +               }
>> +       }
>> +
>> +out:
>> +       mutex_unlock(&nvmem_lookup_mutex);
>> +       return cell;
>> +}
>
>
> ...
>
>> diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
>
>
> Should be part of nvmem-consumer.h.
>

If anything, this should probably go to nvmem-provider.h. But I like
the gpiolib way of putting machine-specific code into a separate
header. Most systems are not interested in these definitions anyway.
IMO this is a valid use case where creating a new header makes sense.

Bart

>> index 1e199dfaacab..7859c08934d5 100644
>> --- a/include/linux/nvmem-machine.h
>> +++ b/include/linux/nvmem-machine.h
>> @@ -26,16 +26,32 @@ struct nvmem_cell_table {
>>         struct list_head        node;
>>   };
>>   +struct nvmem_cell_lookup {
>> +       const char              *nvmem_name;
>> +       const char              *cell_name;
>> +       const char              *dev_id;
>> +       const char              *con_id;
>> +       struct list_head        node;
>> +};
>
>
> Consider adding kerneldoc to this structure.
>
>
>> +
>>   #if IS_ENABLED(CONFIG_NVMEM)
>>     void nvmem_add_cell_table(struct nvmem_cell_table *table);
>>   void nvmem_del_cell_table(struct nvmem_cell_table *table);
>>   +void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t
>> nentries);
>> +void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t
>> nentries);
>> +
>>   #else /* CONFIG_NVMEM */
>>     static inline void nvmem_add_cell_table(struct nvmem_cell_table
>> *table) {}
>>   static inline void nvmem_del_cell_table(struct nvmem_cell_table *table)
>> {}
>>   +static inline void
>> +nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t
>> nentries) {}
>> +static inline void
>> +nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t
>> nentries) {}
>> +
>>   #endif /* CONFIG_NVMEM */
>>     #endif  /* ifndef _LINUX_NVMEM_MACHINE_H */
>>
>
