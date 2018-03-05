From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 5 Mar 2018 16:31:28 +0000
Subject: [REPOST PATCH] arm/arm64: KVM: Add PSCI version selection API
In-Reply-To: <40c74835-da24-485f-14bb-a0c357c7e79b@redhat.com>
References: <20180215175803.6870-1-marc.zyngier@arm.com>
 <db215c1e-0ce8-32e4-d131-e790bebf353e@redhat.com>
 <86o9k63f7a.wl-marc.zyngier@arm.com>
 <40c74835-da24-485f-14bb-a0c357c7e79b@redhat.com>
Message-ID: <CAFEAcA9=YpNngKqeOXiO7QDvL=1ZaQEW8fh3XHjwD+i8qQm9wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2018 at 12:26, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Marc,
> On 02/03/18 12:11, Marc Zyngier wrote:
>> On Fri, 02 Mar 2018 10:44:48 +0000,
>> Auger Eric wrote:
>>> I understand the get/set is called as part of the migration process.
>>> So my understanding is the benefit of this series is migration fails in
>>> those cases:
>>>
>>>> =0.2 source -> 0.1 destination
>>> 0.1 source -> >=0.2 destination
>>
>> It also fails in the case where you migrate a 1.0 guest to something
>> that cannot support it.
>
> That's because on the destination, the number of regs is less than on
> source, right?

I think it fails because the KVM_REG_ARM_PSCI_VERSION register will be
in the migration state but not in the destination's list of registers:
the code in QEMU's target/arm/machine.c:cpu_post_load() function that
checks "register in their list but not ours: fail migration" will
catch this.

That also means that we will fail migration from a new kernel where
we've specifically asked for PSCI 0.2 to an old PSCI-0.2-only kernel
(because the KVM_REG_ARM_PSCI_VERSION reg will appear in the migration
stream even if its value is the one value that matches the old kernel
behaviour). I don't know if we care about that.

thanks
-- PMM
