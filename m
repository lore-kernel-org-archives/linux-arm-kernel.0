From: ahs3@redhat.com (Al Stone)
Date: Tue, 14 Jan 2014 10:18:44 -0700
Subject: [PATCH v6 5/6] ACPI: do not map/unmap memory regions for FADT
 entries in reduced HW mode
In-Reply-To: <52D48BED.4060505@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
 <3512616.qUD2F1beoi@vostro.rjw.lan> <52D471A7.9090907@linaro.org>
 <11986900.5FYeBqExXg@vostro.rjw.lan> <52D48BED.4060505@linaro.org>
Message-ID: <52D57174.7090109@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 05:59 PM, Al Stone wrote:
> On 01/13/2014 05:02 PM, Rafael J. Wysocki wrote:
>> On Monday, January 13, 2014 04:07:19 PM Al Stone wrote:
>>> On 01/10/2014 04:32 PM, Rafael J. Wysocki wrote:
>>>> On Friday, January 10, 2014 03:52:19 PM al.stone at linaro.org wrote:
>>>>> From: Al Stone <al.stone@linaro.org>
>>>>>
>>>>> Several of the FADT fields are normally kept in specific memory
>>>>> regions.  Since these fields are to be ignored in hardware reduced
>>>>> ACPI mode, do not map those addresses when in that mode, and of
>>>>> course do not release the mappings that have not been made.
>>>>>
>>>>> The function acpi_os_initialize() could become a stub in the header
>>>>> file but is left here in case it can be of further use.
>>>>
>>>> Why exactly is this change necessary?
>>>
>>> Two reasons: (1) why do work we do not have to do?  and (2) it
>>> seemed to make sense to me to have the code reflect the spec
>>> accurately.
>>>
>>>> Will things work incorrectly on HW-reduced ACPI systems if we don't
>>>> make it?
>>>
>>> If the ACPI tables have all of these fields properly set to zero
>>> in hardware reduced, this change does not need to be made.  If a
>>> vendor provides broken ACPI tables where these values are valid,
>>> but still sets hardware reduced in the FADT, these fields could
>>> then be used as before -- but allowing them to be used would mean
>>> we can no longer claim we are implementing hardware reduced correctly.
>>> So things would work, but the system would by definition be in some
>>> sort of undefined hybrid ACPI mode.
>>
>> So this is how it goes.  I'm being told that there are systems in
>> existence
>> where the HW-reduced bit is set for Windows RT compatibility, but
>> otherwise
>> the ACPI HW is fully functional on them.  Apparently, people are able to
>> install and run Linux on those systems today.
>>
>> Question is, are they still going to be able to run Linux on them
>> after the
>> changes in this set?
>
> Hrm.  This would have been incredibly useful to know earlier.  I
> might have taken a completely different approach.  Or perhaps not
> even have bothered.
>
> I'm not naive enough to think all vendors will fully or rigorously
> comply with standards.  Down that path madness lies.  But at face
> value, it sounds like they didn't even try.
>
> Without access to the ACPI tables and the hardware itself, there is
> no way to know if Linux will run; I have yet to see any such system.
> The phrase "...the ACPI HW is fully functional..." could mean way too
> many things -- it could mean anything from strict compliance with
> hardware reduced mode to completely compliant with legacy mode but all
> we did was toggle the hardware reduced flag so we could use GPIOs
> instead of an SCI.
>
> As far as I can tell, that makes the question undecidable.  I can't
> prove a negative -- I can't prove these patches won't break an unknown
> set of systems that have implemented an unknown hybrid of legacy and
> hardware reduced modes.
>
> If someone can tell me that these mongrel ACPI systems continue
> to run correctly when they run a Linux built with the
> ACPI_REDUCED_HARDWARE flag set in the ACPICA code, I might at least
> have a clue as to where the boundaries of compliance are.
>
> Or, if such hardware is commercially available, where does one get it?
>
> Otherwise, the only safe patch is 1/6, the Kconfig changes.
>

Thinking about this over night, I'll re-submit just the Kconfig changes
for now, and rethink the approach.

In the meantime... seriously, what devices are these with the weird
ACPI tables and hardware?  How do I get one?  Or access to one?  A part
number or a vendor or something is kind of essential here; otherwise, I
can only surmise they are being done behind closed doors somewhere.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
