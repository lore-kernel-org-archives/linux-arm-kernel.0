From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 8 Feb 2018 11:43:44 +0000
Subject: [PATCH v2 11/20] arm64: capabilities: Add support for features
 enabled early
In-Reply-To: <20180208113559.GW5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-12-suzuki.poulose@arm.com>
 <20180207103855.GB5862@e103592.cambridge.arm.com>
 <a1275474-fbf0-91b2-befb-cbd59d5ccf1e@arm.com>
 <20180208113559.GW5862@e103592.cambridge.arm.com>
Message-ID: <56ca9a17-b8db-8c3e-0267-049cedf28edc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/18 11:35, Dave Martin wrote:
> On Wed, Feb 07, 2018 at 06:34:37PM +0000, Suzuki K Poulose wrote:
>> On 07/02/18 10:38, Dave Martin wrote:
>>> On Wed, Jan 31, 2018 at 06:27:58PM +0000, Suzuki K Poulose wrote:

>>>>    * 3) Verification: When a CPU is brought online (e.g, by user or by the kernel),
>>>>    *    the kernel should make sure that it is safe to use the CPU, by verifying
>>>> @@ -139,11 +148,22 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>>>    *
>>>>    *    As explained in (2) above, capabilities could be finalised at different
>>>>    *    points in the execution. Each CPU is verified against the "finalised"
>>>> - *    capabilities and if there is a conflict, the kernel takes an action, based
>>>> - *    on the severity (e.g, a CPU could be prevented from booting or cause a
>>>> - *    kernel panic). The CPU is allowed to "affect" the state of the capability,
>>>> - *    if it has not been finalised already. See section 5 for more details on
>>>> - *    conflicts.
>>>> + *    capabilities.
>>>> + *
>>>> + *	x------------------------------------------------------------------- x
>>>> + *	| Verification:       | Boot CPU | SMP CPUs by kernel | CPUs by user |
>>>> + *	|--------------------------------------------------------------------|
>>>> + *	| Primary boot CPU    |          |                    |              |
>>>> + *	|  capability         |   n      |      y             |       y      |
>>>> + *	|--------------------------------------------------------------------|
>>>> + *	| All others          |   n      |      n             |       y      |
>>>> + *	x--------------------------------------------------------------------x
>>>
>>> Minor clarify nit: it's not obvious that "n" means "no conflict" and "y"
>>> means "conflict".
>>>
>>> Could we have blank cell versus "X" (with a note saying what that
>>> means), or "ok" versus "CONFLICT"?
>>
>> This is not strictly about conflicts, but about what each CPU get
>> verified against.  Since there are multiple stages of "finalisation"
> 
> You're right: I meant something like "potential conflict", but I hadn't
> read the previous paragraph carefully enough and didn't explain what I
> meant very well.
> 
>> for the capabilities, the table shows how the CPUs get verified.
>>
>> Would it help if I changed the description above the table to :
>>
>>   *    As explained in (2) above, capabilities could be finalised at different
>>   *    points in the execution. Each CPU is verified against the "finalised"
>>   *    capabilities. The following table shows, the capabilities verified
>>   *    against each CPU in the system.
>>   *
>>   *      x------------------------------------------------------------------- x
>>   *      | Verified against:   | Boot CPU | SMP CPUs by kernel | CPUs by user |
> 
> I still find it a bit cryptic.
> 
> Would it be simpler just to write this out in prose, with reference to
> the actual capability types?  I feel that things have to be abbreviated
> a bit to fit nicely into the table otherwise.
> 
> What about:
> 
>   * As explained in (2) above, capabilities could be finalised at different
>   * points in the execution, depending on the capability type. Each newly booted
>   * CPU is verified against those capabilities that have been finalised by the
>   * time that CPU boots:
>   *
>   *	* SCOPE_BOOT_CPU: all CPUs are verified against the capability except
>   *	  for the primary boot CPU.
>   *
>   *	* SCOPE_LOCAL_CPU, SCOPE_SYSTEM: all CPUs hotplugged on by the user
>   *	  after kernel boot are verified against the capability.

Sure, looks better.
