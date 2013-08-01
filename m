From: robherring2@gmail.com (Rob Herring)
Date: Thu, 1 Aug 2013 15:09:51 -0500
Subject: [PATCH v2] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
In-Reply-To: <20130801105824.GE24642@n2100.arm.linux.org.uk>
References: <1374581199-8277-1-git-send-email-festevam@gmail.com>
 <CAL_JsqLY5_biGDFFJpP_a_=WwAnVZT2CxiKvgw7=1mjBvp6znA@mail.gmail.com>
 <20130801105824.GE24642@n2100.arm.linux.org.uk>
Message-ID: <CAL_Jsq+Zgb5Uti3HKDAs4q8bpCp8i=3XHeK+9EWPZW+ZKAA+ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 5:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 31, 2013 at 11:03:46PM -0500, Rob Herring wrote:
>> I just submitted my patch for 798181 ECO fix handling to the patch
>> system today. Then I noticed this patch in your fixes branch. This is
>> going to cause some churn as my patch needs to move the core version
>> check back to a .c file.
>>
>> I don't know if you are okay with rebasing your fixes branch or not.
>> If my patch is applied first, then this issue can be handled by just
>> replacing dummy_flush_tlb_a15_erratum call in context.c a call to
>> erratum_a15_798181.
>
> Well, firstly, are you sure your patch is correct?

Yes.

> You're removing the call to dummy_flush_tlb_a15_erratum() before the
> smp_call_function() - smp_call_function() does _not_ call the function
> for the local CPU.  So, what this means is we don't end up doing any
> of the workaround for the local CPU.

No,  dummy_flush_tlb_a15_erratum() is now called from within
erratum_a15_798181 if errata_fix_needed is non-zero. The return value
only means do the IPI or not.

> Secondly, doesn't the check in your case reduce down to:
>
>         unsigned int midr = read_cpuid_id();
>
>         /* Cortex-A15 r0p0..r3p2 affected */
>         if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2 ||
>             /* ECO not fully fixed */
>             !(read_cpuid(CPUID_REVIDR) & 0x010))
>                 return 0;
>         return 1;
>
> because, assuming midr is not satisfied:
>
> revidr  errata_fix_needed       function return
> 000     2                       1
> 010     1                       0
> 200     2                       1
> 210     0                       0
>
> I think that the above version is still cheap enough to be inline.

Only because it is incomplete. :)

Rob
