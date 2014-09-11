From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Sep 2014 09:05:25 -0700
Subject: [PATCH v3 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20140911132935.068DCC408F6@trevor.secretlab.ca>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <20140911132935.068DCC408F6@trevor.secretlab.ca>
Message-ID: <CAOesGMhQXSTb_c_fDcVGubkUkoPVvikm3k7W8sOCZJNwqmqBUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 6:29 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Mon,  1 Sep 2014 22:57:38 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> ACPI 5.1 has been released and now be freely available for
>> download [1]. It fixed some major gaps to run ACPI on ARM,
>> this patch just follow the ACPI 5.1 spec and prepare the
>> code to run ACPI on ARM64.
>>
>> ACPI 5.1 has some major changes for the following tables and
>> method which are essential for ARM platforms:
>> 1) MADT table updates.
>> 2) FADT updates for PSCI
>> 3) GTDT
>>
>> This patch set is the ARM64 ACPI core patches covered MADT, FADT
>> and GTDT, platform board specific drivers are not covered by this
>> patch set, but we provide drivers for Juno to boot with ACPI only
>> in the follwing patch set for review purpose.
>>
>> We first introduce acpi.c and its related head file which are needed
>> by ACPI core, and then get RSDP to extract all the ACPI boot-time tables.
>> When all the boot-time tables (FADT, MADT, GTDT) are ready, then
>> parse them to init the sytem when booted. Specifically,
>> a) we use FADT to init PSCI and use PSCI to boot SMP;
>> b) Use MADT for GIC init and SMP init;
>> c) GTDT for arch timer init.
>>
>> This patch set is based on 3.17-rc2 and was tested by Graeme on Juno
>> and FVP base model boot with ACPI only OK, if you want to test them,
>> you can pull from acpi-5.1-v3 branch in leg/acpi repo:
>> git://git.linaro.org/leg/acpi/acpi.git
>>
>> Updates since v2:
>>  - Refactor the code to make SMP/PSCI init with less sperated init
>>    path by Tomasz
>>  - make ACPI depend on EXPERT
>>  - Address lots of comments from Catalin, Sudeep, Geoff
>>  - Add Juno device ACPI driver patches for review
>>
>> Updates since v1:
>>  - Set ACPI default off on ARM64 suggested by Olof;
>>  - Rebase the patch set on top of linux-next branch/linux-pm tree which
>>    includes the ACPICA for full ACPI 5.1 support.
>>  - Update the document as suggested;
>>  - Adress lots of comments from Mark, Sudeep, Randy, Naresh, Olof, Geoff
>>    and more...
>>
>> [1]: http://www.uefi.org/sites/default/files/resources/ACPI_5_1release.pdf
>
> I've read through this entire series now. In my mind, aside from a few
> comments that I know you're addressing, this is ready.  The hooks into
> arm64 core code are not terribly invasive, it is nicely organized and
> manageable. Get the next version out ASAP, but I would also like to see
> the diffs from this version to the next so I don't need to review the
> entire series again.

I'm going to take a pass on the next version of the series that will
get posted; I've been a bit too busy to pay close attention to the
series the last few weeks and I might as well wait until the next
version at this rate.

> Regarding the requests to refactor ACPICA to work better for ARM. I
> completely agree that it should be done, but I do not think it should be
> a prerequisite to getting this core support merged. That kind of
> refactoring is far easier to justify when it has immediate improvement
> on the mainline codebase, and it gives us a working baseline to test
> against. Doing it the other way around just makes things harder.
>
> I would really like to see the next version of this series go into
> linux-next. I think this is ready for some wider exposure. Have you got
> a branch being pulled into Fengguang's autobuilder yet?

That's not how -next works. We only add code to -next that is targeted
to the upcoming release, we certainly don't add it to get "wider
exposure". If the code is ready then it can go in, but that's not the
case at this time.

For "wider exposure" -- who do you have in mind? Everybody that's
currently got hardware relevant for this already needs out-of-tree
patches, so getting it into -next doesn't add any exposure. Doesn't
Linaro do kernel builds and publish trees for this reason already?


-Olof
