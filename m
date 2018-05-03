From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 3 May 2018 10:41:43 +0200
Subject: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
In-Reply-To: <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
 <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
 <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
 <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
Message-ID: <CAJZ5v0iiWd0eET0iuj4RZuaQ4T12W-H775SEd0CFG5hK9+q9WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 12:35 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
>
> On 05/02/2018 03:24 AM, Rafael J. Wysocki wrote:
>>
>> On Tue, May 1, 2018 at 4:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>
>>>
>>> On 26/04/18 00:31, Jeremy Linton wrote:
>>>>
>>>> Propagate the topology information from the PPTT tree to the
>>>> cpu_topology array. We can get the thread id and core_id by assuming
>>>> certain levels of the PPTT tree correspond to those concepts.
>>>> The package_id is flagged in the tree and can be found by calling
>>>> find_acpi_cpu_topology_package() which terminates
>>>> its search when it finds an ACPI node flagged as the physical
>>>> package. If the tree doesn't contain enough levels to represent
>>>> all of the requested levels then the root node will be returned
>>>> for all subsequent levels.
>>>>
>>>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> [..]
>>>
>>>> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>>>>         * Discard anything that was parsed if we hit an error so we
>>>>         * don't use partial information.
>>>>         */
>>>> -     if (of_have_populated_dt() && parse_dt_topology())
>>>> +     if ((!acpi_disabled) && parse_acpi_topology())
>>>
>>>
>>> [nit] not sure if extra () is need above,
>>
>>
>> No, it isn't.
>>
>>> but I am fine either way.
>>
>>
>> The redundant parens need to go away, really.
>>
>
> Yah, I missed this one, is there a linter everyone is using that finds
> these?

I'm not actually sure.  At least I can't recall any right away.
