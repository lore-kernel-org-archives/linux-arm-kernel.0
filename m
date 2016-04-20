From: ddaney.cavm@gmail.com (David Daney)
Date: Wed, 20 Apr 2016 09:29:45 -0700
Subject: [PATCH v5 12/14] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <CAFpQJXXeQKKrgObdhxu8QaTm-wb81yddLtwFreed4eS5Qi1TPw@mail.gmail.com>
References: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com>
 <1461116439-22991-13-git-send-email-ddaney.cavm@gmail.com>
 <CADKHWaeZPj7UWU4znf7NRo3JO8+JGrBP4WJE6S5gVM0KvydNug@mail.gmail.com>
 <CAFpQJXXeQKKrgObdhxu8QaTm-wb81yddLtwFreed4eS5Qi1TPw@mail.gmail.com>
Message-ID: <5717AE79.5060605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 01:31 AM, Ganapatrao Kulkarni wrote:
> On Wed, Apr 20, 2016 at 1:11 PM, Dennis Chen <dennis.chen@linaro.org> wrote:
>> On 20 April 2016 at 09:40, David Daney <ddaney.cavm@gmail.com> wrote:
[...]
>>> @@ -388,7 +389,9 @@ static int __init dummy_numa_init(void)
>>>   void __init arm64_numa_init(void)
>>>   {
>>>          if (!numa_off) {
>>> -               if (!numa_init(of_numa_init))
>>> +               if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
>>> +                       return;
>>> +               if (acpi_disabled && !numa_init(of_numa_init))
>>>                          return;
>>>          }
>>>
>> On top of the latest version of the dt-based numa patch, if 'numa=off'
>> specified in the command line,
>> this function will fallback to invoke dummy_numa_init(), which give
>> rise the question here is, do we need to
>> touch any ACPI related stuff in the case? If not, then the output
>
> no, ACPI is not fallback configuration for DT and vice versa.
>
>> message "No NUMA configuration found" followed
>> seems is not necessary since it's a little bit confusing in case of
>> numa has already been turned off explicitly.
>
> thanks, this print can be moved out.
> from function dummy_numa_init and it can be added in function arm64_numa_init
> as a last line of if (!numa_off) to indicate, ACPI/DT based NUMA
> configuration failed.
>
> more appropriate would be,
> pr_info("%s\n", "NUMA configuration failed or not found");
>

Although purely cosmetic, I agree that we need to improve the messages 
as to not confuse people.

I will rework the messages with your suggestions in mind to see if we 
can get something that is both concise and unambiguously reflects what 
the user asked for.

David.
