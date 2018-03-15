From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 15 Mar 2018 15:49:48 -0600
Subject: coresight dummy funnel question
In-Reply-To: <CAHrpEqQeJdZG8CNN5728B7E6fE7PEZ08S=Ka8FtXKsftu+JMyQ@mail.gmail.com>
References: <CAHrpEqRwwMRUBGa_BYasiondhQALZtMcZC8tUfUYyuQMN47uoQ@mail.gmail.com>
 <CANLsYkzdGSbSSXsCDGUzbYNKHKy7YiWft5JdT5b3RN+aqn+nGQ@mail.gmail.com>
 <CAHrpEqQ8OHKB3gbE6tB0hg-Hz9SCU+wCWsk7QgRwcembvH9aFQ@mail.gmail.com>
 <CANLsYkxsratEdiQaRO14hNrzWoQ1LKfWWjjieeeDJ6y=mnGedQ@mail.gmail.com>
 <CAHrpEqQeJdZG8CNN5728B7E6fE7PEZ08S=Ka8FtXKsftu+JMyQ@mail.gmail.com>
Message-ID: <CANLsYkx0PqmBJgAFuBxAzCZxrREo9sfA2CCo1OjMDRPpySxCDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2018 at 13:06, Zhi Li <lznuaa@gmail.com> wrote:
> On Thu, Mar 15, 2018 at 10:46 AM, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>> On 9 March 2018 at 15:07, Zhi Li <lznuaa@gmail.com> wrote:
>>> On Fri, Mar 9, 2018 at 12:03 PM, Mathieu Poirier
>>> <mathieu.poirier@linaro.org> wrote:
>>>> Hi Zhi,
>>>>
>>>> On 7 March 2018 at 08:57, Zhi Li <lznuaa@gmail.com> wrote:
>>>>> Mathieu:
>>>>>
>>>>>            I am working one enable coresight in our SOC.
>>>>>
>>>>>            But our SOC's cluster funnel have not export program interface.
>>>>>            Our cluster included 4 A53.
>>>>>
>>>>>            4 ETM of A53 connect to funnel, which have NOT program
>>>>> interface. Funnel is default enabled.
>>>>>
>>>>>            Do you have suggest how to bypass or use dummy funnel in dts file?
>>>>
>>>> Is the funnel discoverable on the AMBA bus or is it like the original
>>>> version of replicators?
>>>
>>> No, No any program interface at all. Look like replicators
>>
>> The best way to proceed is probably to allow entry in the funnel
>> driver from the platform bus as well.  There is a very good example
>> here [1].
>
> But our funnel have not export register program interface.
> Do I use a dummy funnel driver for that?

Exactly

>
> static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>    base = devm_ioremap_resource(dev, res);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
>
> Allowed base is null.
>
> check drvdata->base in funnel_enable()
> if(drvdata->base )
>             funnel_enable_hw(drvdata, inport);

Please look at what is being done for the replicators and enact the
same for your new funnel.  Looking at the code I think it will be
cleaner to keep the probe routines for the platform driver and AMBA
driver separate.

>
> Is it okay overall?
>
> best regards
> Frank Li
>
>>
>> Thanks,
>> Mathieu
>>
>> [1]. https://elixir.bootlin.com/linux/v4.16-rc5/source/drivers/tty/serial/amba-pl011.c
>>
>>>
>>> best regards
>>> Frank Li
>>>
>>>>
>>>>>
>>>>>
>>>>> best regards
>>>>> Frank Li
