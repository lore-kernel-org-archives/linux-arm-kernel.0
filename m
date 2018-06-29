From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 29 Jun 2018 11:48:15 -0500
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
Message-ID: <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/29/2018 10:46 AM, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:
>> If it matters a lot, vendors must use UID for consistency. Since OS doesn't
>> use those IDs for any particular reason, OS must not care.
> 
> That depends. If you look at how topology_logical_package_id() is used in
> x86 code you'll see it gets used as an index to an array in a couple
> places. If we don't remap arbitrary IDs to counters than we may miss out
> on some opportunities to avoid lists.
> 
> Also, we're talking about what's visible to users. I think it's much more
> likely to break a user app by exposing topology IDs that have values
> greater than the linear CPU numbers (even though properly written apps
> shouldn't expect them to be strictly <=), than the opposite.
> 
>>
>>>>
>>>>>>
>>>>>> So I would like to keep it simple and just have this counters for
>>>>>> package ids as demonstrated in Shunyong's patch.
>>>>>>
>>>>>
>>>>> If we don't also handle cores when there are threads, then the cores
>>>>> will also end up having weird IDs.
>>>>>
>>>>
>>>> Yes, but if PPTT says it has valid ID, I would prefer that over DT like
>>>> generated.
>>>
>>> Valid *ACPI* ID, which just means it's a guaranteed unique ACPI UID,
>>> which isn't likely going to be anything useful to a user.
>>>
>>
>> How is that different from OS generated one from user's perspective ?
>> Vendors might assign sockets UID and he may help them to replace one.
>> Having some generated counter based id is not helpful.
> 
> I agree with this. It's a good argument for maintaining a mapping of
> package-id to id-physically-printed-on-a-package somewhere. To avoid
> maintaining a mapping it could just be stored directly in
> cpu_topology[cpu].package_id, but then how can we tell the difference
> between a valid printed-on-package-id and an ACPI offset? We'd still
> have to maintain additional state to determine if it's valid or not,
> so we could just maintain a mapping instead.

Just to be clear, there isn't anything (AFAIK) in the ACPI specification 
which dictates what values should comprise the various ACPI id's. They 
are assumed only to be machine readable, which is why it seems some 
implementations are just using a sanitized version of mpidr for the 
core/MADT acpi id. That is why simply using the id flagged as valid in a 
PPTT node doesn't necessarily give you a more human readable value.

If you want a human readable socket identifier that matches something 
stamped above the socket, that is what SMBIOS is for. Queue discussion 
about that tables reliability for functional ids. Either way, as the 
spec is written today (or any ECRs I've seen), your definitely not going 
to get both nice socket1, socket2, and cpu1, cpu2 out of the same 
PPTT/ACPIid name-space since the numerical id's conflict.
