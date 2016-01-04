From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 4 Jan 2016 12:48:25 +0530
Subject: [PATCH v8 3/4] arm64/arm, numa, dt: adding numa dt binding
 implementation for arm64 platforms.
In-Reply-To: <568A1549.9070405@huawei.com>
References: <1451385148-13448-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1451385148-13448-4-git-send-email-gkulkarni@caviumnetworks.com>
 <568A1549.9070405@huawei.com>
Message-ID: <CAFpQJXUfOcRQcEChyAWahu2zFdf_1Xe0FrErJ_ydyeWKRA=QqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On Mon, Jan 4, 2016 at 12:16 PM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> Hi Ganapatrao,
>
>
> On 2015/12/29 18:32, Ganapatrao Kulkarni wrote:
>> +static int __init early_init_parse_memory_node(unsigned long node)
>> +{
>> +     const __be32 *reg, *endp;
>> +     int length;
>> +     int nid;
>> +
>> +     const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>> +
>> +     /* We are scanning "memory" nodes only */
>> +     if (type == NULL)
>> +             return 0;
>> +     else if (strcmp(type, "memory") != 0)
>> +             return 0;
>> +
>> +     nid = early_init_of_get_numa_nid(node);
>> +
>> +     if (nid == NUMA_NO_NODE)
>> +             return -EINVAL;
>> +
>> +     reg = of_get_flat_dt_prop(node, "reg", &length);
>> +     endp = reg + (length / sizeof(__be32));
>> +
>> +     while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
>> +             u64 base, size;
>> +             struct memblock_region *mblk;
>> +
>> +             base = dt_mem_next_cell(dt_root_addr_cells, &reg);
>> +             size = dt_mem_next_cell(dt_root_size_cells, &reg);
>> +             pr_debug("NUMA-DT:  base = %llx , node = %u\n",
>> +                             base, nid);
>> +
>> +             for_each_memblock(memory, mblk) {
>> +                     if (mblk->base == base) {
>> +                             if (numa_add_memblk(nid,
>> +                                                     mblk->base,
>> +                                                     mblk->size) < 0)
>> +                                     return -EINVAL;
>> +                             break;
>> +                     }
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>
> Here it seems that you didn't address the comments[1] I gave on your
> previous patch set.
sorry, i have missed your comment.
i will update it.
>
> [1] http://www.spinics.net/lists/devicetree/msg104493.html
>
> Thanks,
> --
> Shannon
>
thanks
Ganapat
