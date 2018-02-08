From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 8 Feb 2018 14:27:42 +0100
Subject: [PATCH 2/7] soc: davinci: new genpd driver
In-Reply-To: <34d3980b-2c94-1540-94f0-dc0c86743475@ti.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-3-brgl@bgdev.pl>
 <65f2690c-c605-3c66-9d8a-9a882aaf446d@ti.com>
 <CAMRc=Mf+S3k_wfhUWEx2-39AZx1szkgy-u-bsZQUMiaY06UKww@mail.gmail.com>
 <34d3980b-2c94-1540-94f0-dc0c86743475@ti.com>
Message-ID: <CAMRc=MeQUdzWfAgUCX5k5iwmyyVeCvjhw0CKauSY_1F0+SBPBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-08 13:56 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Thursday 08 February 2018 03:24 PM, Bartosz Golaszewski wrote:
>> 2018-02-08 10:30 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>>> On Wednesday 07 February 2018 07:15 PM, Bartosz Golaszewski wrote:
>>>> +     /*
>>>> +      * DaVinci always uses a single clock for power-management. We assume
>>>> +      * it's the first one in the clocks property.
>>>> +      */
>>>> +     clk = of_clk_get(dev->of_node, 0);
>>>> +     if (IS_ERR(clk))
>>>> +             return PTR_ERR(clk);
>>>
>>> We already get this today with drivers/base/power/clock_ops.c once
>>> .con_ids list is dropped from pm_clk_notifier_block (which I think it
>>> should).
>>>
>>> If there is no reason to introduce thus functionality at this stage,
>>> perhaps we should wait till such a time when its clearly needed?
>>>
>>> Thanks,
>>> Sekhar
>>
>> If I understand correctly: once we drop the con_ids list, we end up
>> calling clk_get(dev, NULL) from pm_clk_acquire(), which matches
>> against the clock with NULL con_id, which may not necessarily be the
>> first clock in the list.
>
> Hmm, not sure of this. In __of_clk_get_by_name() called by clk_get():
>
> int index = 0;
>
> /*
>  * For named clocks, first look up the name in the
>  * "clock-names" property.  If it cannot be found, then
>  * index will be an error code, and of_clk_get() will fail.
>  */
> if (name)
>         index = of_property_match_string(np, "clock-names", name);
>
> So, if no con_id is provided (name == NULL), then index is set to 0
> which will always get the first clock in clocks = list.
>

But we're talking here about device tree mode. In legacy mode the
device_node pointer will be NULL, __of_clk_get_by_name() will return
-ENOENT and we'll end up calling clk_get_sys() -> clk_find(). We'll
then iterate over the clock entries and check the following:

(...)
152                 if (p->con_id) {
153                         if (!con_id || strcmp(p->con_id, con_id))
154                                 continue;
155                         match += 1;
156                 }
(...)

So we'll skip the first clock if it has a con_id and we passed an
empty con_id to clk_get().

Bartosz
