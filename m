From: ahs3@redhat.com (Al Stone)
Date: Wed, 9 Sep 2015 13:57:59 -0600
Subject: [PATCH v2 1/5] ACPI: add in a bad_madt_entry() function to
 eventually replace the macro
In-Reply-To: <55EDADF5.5060008@arm.com>
References: <1440022048-6285-1-git-send-email-al.stone@linaro.org>
 <1440022048-6285-2-git-send-email-al.stone@linaro.org>
 <55EDADF5.5060008@arm.com>
Message-ID: <55F08F47.1070906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2015 09:32 AM, Sudeep Holla wrote:
> Hi Al,
> 
> On 19/08/15 23:07, Al Stone wrote:
> 
> I finally got a chance to try this series on Juno. Well it exposed a firmware
> bug in MADT table :)
> 
> [..]
> 
>>                  acpi_tbl_entry_handler handler,
>> @@ -245,6 +484,8 @@ acpi_parse_entries(char *id, unsigned long table_size,
>>                 table_end) {
>>                  if (entry->type == entry_id
>>                      && (!max_entries || count < max_entries)) {
>> +                       if (bad_madt_entry(table_header, entry))
>> +                               return -EINVAL;
> 
> Not sure if we can have the above check here unconditionally.
> Currently I can see there are 2 other users of acpi_parse_entries i.e.
> PCC and NUMA. So may be it can be made conditional or return success for
> non-MADT tables from bad_madt_entry ?

So, I went back and double checked the other users and they're looking at
the return value for acpi_parse_entries properly; adding in the check above
unconditionally should not cause any behavior change.  Further, despite the
name, acpi_parse_entries is only used to examine MADT subtables.  Granted,
we should probably make the name clearer at some point (too ambiguous as to
which entries are parsed right now).  Nonetheless, current usage seems to
be in order.


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
