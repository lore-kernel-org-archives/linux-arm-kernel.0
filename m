From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Sat, 1 Sep 2018 15:11:05 +0200
Subject: [PATCH v2 02/29] Documentation: nvmem: document lookup entries
In-Reply-To: <20180831203028.GC62862@ban.mtv.corp.google.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-3-brgl@bgdev.pl>
 <20180831203028.GC62862@ban.mtv.corp.google.com>
Message-ID: <CAMRc=MdergeeYO9HLiFX5_n=SJr22dOJBG2y3+DwkB29XeaFJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-31 22:30 GMT+02:00 Brian Norris <computersforpeace@gmail.com>:
> On Fri, Aug 10, 2018 at 10:04:59AM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Describe the usage of nvmem cell lookup tables.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
>> index 8d8d8f58f96f..9d5e3ca2b4f3 100644
>> --- a/Documentation/nvmem/nvmem.txt
>> +++ b/Documentation/nvmem/nvmem.txt
>> @@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
>>  It is mandatory that the NVMEM provider has a regmap associated with its
>>  struct device. Failure to do would return error code from nvmem_register().
>>
>> +Additionally it is possible to create nvmem cell lookup entries and register
>> +them with the nvmem framework from machine code as shown in the example below:
>
> Maybe it's partially a lacking in the existing documentation, but what
> does the "name" and the "nvmem_name" mean here? AFAICT, "nvmem_name" is
> akin to a provider identifier; and "name" is a key to match with the
> consumer. It feels like this should be in either the header / kerneldoc
> or this file. Or maybe both.
>
> Does this mean there can only be a single "mac-address" cell in the
> system? I have systems where there are multiple MACs provided in flash
> storage, and we need to map them to ethernet0 and ethernet1. Is that
> supported here?
>

This is a shortcoming of the nvmem subsystem we discussed under
another patch in this series with Boris and Srinivas. I will try to
post a series addressing this next week. Basically there's a global
list of nvmem cells referenced only by name and unless you're using DT
you can only have a single cell with given name. I will address it by
introducing the standard dev_id/con_id resource association.

Bart

> Brian
>
>> +static struct nvmem_cell_lookup foobar_lookup = {
>> +     .info = {
>> +             .name = "mac-address",
>> +             .offset = 0xd000,
>> +             .bytes = ERH_ALEN,
>> +     },
>> +     .nvmem_name = "foobar",
>> +};
>> +
>> +static void foobar_register(void)
>> +{
>> +     ...
>> +     nvmem_add_lookup_table(&foobar_lookup, 1);
>> +     ...
>> +}
>> +
>> +A lookup entry table can be later removed if needed:
>> +
>> +static void foobar_fini(void)
>> +{
>> +     ...
>> +     nvmem_del_lookup_table(&foobar_lookup, 1);
>> +     ...
>> +}
>> +
>>  NVMEM Consumers
>>  +++++++++++++++
>>
>> --
>> 2.18.0
>>
