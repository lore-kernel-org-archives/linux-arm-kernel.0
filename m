From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 01:34:45 -0400
Subject: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <540E8C1F.5060802@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
 <20140903172138.GG1824@e102568-lin.cambridge.arm.com>
 <5408854B.9010703@linaro.org> <540E8212.8090304@redhat.com>
 <540E8C1F.5060802@linaro.org>
Message-ID: <540E9175.1070807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 01:11 AM, Hanjun Guo wrote:
> On 2014?09?09? 12:29, Jon Masters wrote:
>> Hi Hanjun, Lorenzo,
> 
> Hi Jon,
> 
>>
>> Resending due to my mail client removing list CCs...sorry about that.
>>
>> On 09/04/2014 11:29 AM, Hanjun Guo wrote:
>>
>>>>> +	} else {
>>>>> +		/* Fist GICC entry must be BSP as ACPI spec said */
>>>> s/Fist/First/
>>>>
>>>>> +		if  (cpu_logical_map(0) != mpidr) {
>>>>> +			pr_err("First GICC entry is not BSP for MPIDR 0x%llx\n",
>>>>> +			       mpidr);
>>>>> +			return -EINVAL;
>>>>> +		}
>>>> Interesting, this means that if I want to change the boot CPU I have to
>>>> recompile the ACPI tables. Is that really true ?
>> Well, the ACPI5.1 specification does require that the PEs (cores) be
>> listed in a very specific order, with the boot CPU first, and then a
>> precisely defined sequence of interleaving of any possible SMT threads
>> with other cores. So I think you would in practice update your tables.
> 
> Thanks for the clarify.

No problem :) I'm trying to go through the various threads and ensure
various things are documented in the record. I'm skipping (for now)
notes on e.g. CPU cache flush behavior because we're not pushing for C3
support (or really any runtime power management) in the first round.

>>
>>>>> +	/*
>>>>> +	 * ACPI 5.1 only has two explicit methods to boot up SMP,
>>>>> +	 * PSCI and Parking protocol, but the Parking protocol is
>>>>> +	 * only specified for ARMv7 now, so make PSCI as the only
>>>>> +	 * way for the SMP boot protocol before some updates for
>>>>> +	 * the ACPI spec or the Parking protocol spec.
>>>>> +	 */
>> The Parking Protocol may be updated for a (limited) number of platforms
>> that may use it in the early days. The preferred option (as described in
>> the SBBR) is to use PSCI when at all possible. Some implementations of
>> the architecture may not be able to use PSCI for MP-Boot. Thus while
>> there may be some limited early use of the parking protocol (including
>> while PSCI firmware is being finalized during bringup activities), it
>> will ultimately be completely replaced by PSCI based boot over time.
> 
> Thank you for the clarify again :)
> 
> Will Parking Protocol be upstreamed?

Yes, a version against v8 will be posted (perhaps in the next few days),
but we should not wait for it in this general discussion. The default in
v8 will be PSCI other than for early bringup, or for an architecture
implementation that cannot use PSCI, which is rare.

(When we wrote the SBBR we had many discussions about this. A goal is to
be fair to everyone - those rare instances where PSCI is not possible
must be covered by a specification, but there must be a strong
preference established for a preferred course over the longer term)

> If yes, I think we can update the
> comments when Parking Protocol driver upstreamed.

Indeed so. For the moment, the logic you have in your patch to fail
setup in the case that there is no defined PSCI cpu ops for the
associated processor is fine IMHO.

Jon.
