From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 22 Oct 2015 15:13:11 -0700
Subject: [PATCH 1/2] ARM: ux500: add an SMP enablement type and move cpu
 nodes
In-Reply-To: <CACRpkdb5eLWZKmbnuPJ1bBrQPqyH0wvh7SjJdVNN7XEiXkKf-w@mail.gmail.com>
References: <1438586801-30115-1-git-send-email-linus.walleij@linaro.org>
 <CAMAWPa_nVyyhXfBm3HvPyVGpodJe_dfM0kX0kO+rPtO9mfkG=w@mail.gmail.com>
 <CACRpkdb5eLWZKmbnuPJ1bBrQPqyH0wvh7SjJdVNN7XEiXkKf-w@mail.gmail.com>
Message-ID: <CAMAWPa9pVRY1evsZmZRyxY0JxRJ0tUhsug+xUDrw6mc8y4W9NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 5:24 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 20, 2015 at 6:52 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> On Mon, Aug 3, 2015 at 12:26 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> The "cpus" node cannot be inside the "soc" node, while this
>>> works for the CoreSight blocks, the early boot code will look
>>> for "cpus" directly under the root node, so this is a hard
>>> convention. So move the CPU nodes.
>>>
>>> Augment the "reg" property to match what is actually in the
>>> hardware: 0x300 and 0x301 respectively.
>>>
>>> Then add an SMP enablement type to be used by the SMP init
>>> code, "ste,dbx500-smp".
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> Hi ARM SoC people: please apply this as a fix for v4.2
>>> as it is prerequisite for 2/2 which is a more proper fix
>>> for the secondary CPU boot regression addressed by the
>>> fixed remappings patch.
>>
>> kernelci.org has had the ste-snowall failing in v4.2 stable[1] for

Note the failure was for v4.2 stable...

>> awhile, so I finally bisected[2] it down to this patch, which is in
>> mainline in the form of commit bf64dd262eaa (ARM: ux500: add an SMP
>> enablement type and move cpu nodes).  I confirmed that reverting that
>> commit on top of v4.2 gets the snowball booting again.
>>
>> Kevin
>>
>> [1] http://kernelci.org/boot/all/job/stable/kernel/v4.2.3/
>> [2] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/102/console
>
> OK I tested the u8500_defconfig and it still works fine on
> Snowball. So I have no clue what is causing this :(
> (See below for my bootlog.)
>
> - I first thought it was a multiplatform issue but it seems
>   not AFAICT from the logs.

It fails on both mutli_v7_defconfig and u8500_defconfig.

> - Is the CI boot is using the latest device tree from
>   arch/arm/boot/dts/ste-snowball.dts?

Yes, it always uses the DT from the same tree that the kernel is built from.

> 5070] starting kernel at 0x00008000, machine 3293
> [    0.000000] Booting Linux on physical CPU 0x300
> [    0.000000] Linux version 4.3.0-rc6-00001-gdff502ea54cb

Ah, you're using mainline.  The boot failure we found is in stable
v4.2 (and v4.1) which suggests that there's a patch/fix that's
upstream but not yet backported to stable.

Kevin
