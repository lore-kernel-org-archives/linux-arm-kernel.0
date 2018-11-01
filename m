From: john.garry@huawei.com (John Garry)
Date: Thu, 1 Nov 2018 11:39:51 +0000
Subject: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
In-Reply-To: <20181101112743.GB31099@arm.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
 <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
 <bc7bd118-82f2-86be-71ea-46704df864a5@huawei.com>
 <45a8e09d-b32b-df32-ba34-5aa1909fb11f@arm.com>
 <20181101112743.GB31099@arm.com>
Message-ID: <1a2526e6-9ae7-88b1-76af-f1ef78c55580@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> Agreed. slit_valid() on the ACPI parsing is currently enforcing that before
>> acpi_numa_slit_init() which would call into numa_set_distance(). Hence arch
>> NUMA code numa_set_distance() never had the opportunity to do the sanity
>> checks as ACPI slit_valid() has completely invalidated the table.
>>
>> Unlike ACPI path, of_numa_parse_distance_map_v1() does not do any sanity
>> checks on the distance values parse from the "distance-matrix" property
>> and all the checks directly falls on numa_set_distance(). This needs to
>> be fixed in line with ACPI
>>
>> * If (to == from) ---> distance = LOCAL_DISTANCE
>> * If (to != from) ---> distance > LOCAL_DISTANCE
>>
>> At the same time its okay to just enhance numa_set_distance() test coverage
>> to include this new test. If we would have trusted firmware parsing all the
>> way, existing basic checks about node range, distance stuff should not have
>> been there in numa_set_distance(). Hence IMHO even if we fix the OF driver
>> part, we should include this new check there as well.
>
> I don't see what we gain by duplicating the check. In fact, it has a few
> downsides:
>
>   (1) It confuses the semantics of the API, because it is no longer clear
>       who "owns" the check
>
>   (2) It duplicates code in each architecture
>
>   (3) Some clever-cloggs will remove at least some of the duplication in
>       future
>
> I'm not willing to accept the check in the arm64 code if we update the
> OF code.
>
> I think the way forward here is for John to fix the crash he reported by
> adding the check to the OF code.

I was planning on doing that.

If somebody wants to follow up with
> subsequent patches to move more of the checking out of the arch code, then
> we can review that as a separate series.

Cheers,
John

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
