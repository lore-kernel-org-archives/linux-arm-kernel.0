From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 10:11:39 +0100
Subject: [GIT PULL] firmware: arm_scpi: updates/cleanups for v4.15
In-Reply-To: <a0b4576b-3249-a783-ef92-9c394f27edb8@arm.com>
References: <901d3720-a023-0af9-2b20-b7d7e8528571@arm.com>
 <CAK8P3a0Pmcg+_zZNgTYfi_0m8zS=Rq9oqPSypxASKh8E34NKJg@mail.gmail.com>
 <a0b4576b-3249-a783-ef92-9c394f27edb8@arm.com>
Message-ID: <CAK8P3a0=9vqtQh3GGQhfkOQfaY2YU0GqtTUMwbMY79H6MDA0KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 11:00 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 20/10/17 21:33, Arnd Bergmann wrote:
>> On Mon, Oct 9, 2017 at 7:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>>>
>>>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
>>> tags/scpi-updates-4.15
>>>
>>> for you to fetch changes up to 430594c1c7f5051f0d99ed9d08d086d20587cdd1:
>>>
>>>   firmware: arm_scpi: silence sparse warnings (2017-10-09 10:20:02 +0100)
>>>
>>> ----------------------------------------------------------------
>>> ARM SCPI updates/cleanups for v4.15
>>>
>>> 1. Fixes to get rid of sparse warnings
>>> 2. Use of FIELD_GET and GENMASK for better subfields handling
>>> 3. Make mbox_free_channels device-managed helping in removing
>>> unnecessary code
>>> 4. Various other cleanups to simplify and improve code readability
>>
>> Pulled into next/drivers. I'm a little unsure about the first patch: the
>> resource is called "shmem", which suggests that you are dealing
>> with memory and should use "memremap()" instead of "ioremap()"
>> and readl/writel. Can you clarify what the mapping attributes are
>> supposed to be here? Thanks.
>
> This is the shared memory carved out of SRAM. Since it's shared with
> remote processor it's prefer to have device ordering and uncached.
> drivers/misc/sram.c does have ioremap, the shmem used here is reserved
> region from SRAM. Let me know if this sounds fine.

Ok, for SRAM, uncached access and __iomem pointers are correct.

Byte ordering tends to be a problem with this kind of data transfer,
as you usually have a combination of fixed-order fields that require
byte swaps and byte strings that must not be swapped. I'm fairly sure
you got these all right here, so there is no problem with your patches,
just something to remember for the future.

        Arnd
