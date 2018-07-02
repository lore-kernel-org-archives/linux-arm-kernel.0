From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Jul 2018 11:01:49 +0100
Subject: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
In-Reply-To: <20180630071620.gszzib7oha3jn3j2@hawk.localdomain>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
 <20180630071620.gszzib7oha3jn3j2@hawk.localdomain>
Message-ID: <a6c51606-05a5-84ce-8e6b-c66c7f2c77f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/06/18 08:16, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 05:17:57PM +0100, Sudeep Holla wrote:
>> Currently we use the ACPI processor ID only for the leaf/processor nodes
>> as the specification states it must match the value of ACPI processor ID
>> field in the processor?s entry in the MADT.
>>
>> However, if a PPTT structure represents processors group, it match a
>> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
>> flag describe whether the ACPI processor ID is valid.
>>
>> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
>> consistent instead of using table offset as it's currently done for non
>> leaf nodes.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/acpi/pptt.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> Hi,
>>
>> There's ongoing discussion on assigning ID based in OS using simple
>> counters. It can never be consistent with firmware's view. So if the
>> firmware provides valid UID for non-processors node, we must use it.
> 
> I agree with this. I've been so focused on the fact that the ACPI offsets
> are arbitrary, and thus counters can't be worse, that I nearly forgot how
> these IDs are actually defined:
> 

Yes, it's platform dependent and I now realize that I never explicitly
mentioned that, let alone emphasize on that. I was for UID for the same
reason.

[...]

> 
> When the valid flag is set we'll now return a [hopefully] correct platform
> dependent ID, but when it's not we'll return an ACPI table offset. How
> will users of the ID know? Also, it's possible to return -ENOENT for the
> ID when calling find_acpi_cpu_topology(). How can we distinguish that from
> an arbitrary platform dependent ID?
> 

But why should one need to distinguish that ? Even offset is kind of
sparsely distributed UID.
-- 
Regards,
Sudeep
