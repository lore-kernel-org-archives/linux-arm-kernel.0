From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 1 Jul 2014 16:44:04 +0530
Subject: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
In-Reply-To: <CABGGiswMuofH5WRh4jgwh1=CV+fEXM_Ec3+WNwThbuMLVxsdcg@mail.gmail.com>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
 <53AB1CC1.4010907@codeaurora.org>
 <CAKohpo=Q7eWNwcK6KF9_U-zD0g=96QHW9hiQupLpV5GqoWE+mA@mail.gmail.com>
 <53ACB568.4000903@codeaurora.org>
 <20140627015354.32686.83046@quantum>
 <CAKohponvN3rAvJrfi4TojFcq5gq7r2oNE4Q0_NtwBHmEZ8waBA@mail.gmail.com>
 <CAKohpo=dgSW551yzqjAV2_opw_4naqFEWpwUz9ktkGgR5vCBZA@mail.gmail.com>
 <CABGGiswMuofH5WRh4jgwh1=CV+fEXM_Ec3+WNwThbuMLVxsdcg@mail.gmail.com>
Message-ID: <CAKohpokaVPn7yNPNAGrE6juGaOYuxZvVsbmkOZmyi9rDub6t7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2014 00:03, Rob Herring <rob.herring@linaro.org> wrote:
>> What about comparing "clocks" property in cpu DT nodes?
>
> What if a different clock is selected for some reason.

I don't know why that will happen for CPUs sharing clock line.

> I think a clock api function would be better.

@Mike: What do you think? I think we can get a clock API for
this.

> That being said, I don't really have any issue with such a function.
> Some comments on the implementation.

>> +static int of_property_match(const struct device_node *np1,
>> +                             const struct device_node *np2,
>> +                             const char *list_name)
>> +{
>> +       const __be32 *list1, *list2, *list1_end;
>
> s/list/prop/
>
> Everywhere.

Ok.

>> +       int size1, size2;
>> +       phandle phandle1, phandle2;
>> +
>> +       /* Retrieve the list property */
>> +       list1 = of_get_property(np1, list_name, &size1);
>> +       if (!list1)
>> +               return -ENOENT;
>> +
>> +       list2 = of_get_property(np2, list_name, &size2);
>> +       if (!list2)
>> +               return -ENOENT;
>> +
>> +       if (size1 != size2)
>> +               return 0;
>> +
>> +       list1_end = list1 + size1 / sizeof(*list1);
>> +
>> +       /* Loop over the phandles */
>> +       while (list1 < list1_end) {
>> +               phandle1 = be32_to_cpup(list1++);
>> +               phandle2 = be32_to_cpup(list2++);
>> +
>> +               if (phandle1 != phandle2)
>> +                       return 0;
>> +       }
>
> You can just do a memcmp here.

Yeah, that would be much better.

> This is wrong anyway because you don't know #clock-cells size.

I was actually comparing all the clock-cells, whatever there number
is to make sure "clocks" properties are exactly same. Anyway
memcmp will still guarantee that.

Thanks for your review.
