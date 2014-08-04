From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 4 Aug 2014 13:10:14 +0900
Subject: linux-next: build failure after merge of the gpio tree
In-Reply-To: <20140729084237.GE31360@ulmo.nvidia.com>
References: <20140729183153.0e77a6f6@canb.auug.org.au>
 <20140729084237.GE31360@ulmo.nvidia.com>
Message-ID: <CAAVeFuJmHX351WQpEo43sQUf+4BHk9QRJqZfJMsgWf8AXH=_8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have sent a patch to fix this. In the meantime, if the merge
conflict of the GPIO tree on board-paz00.c is solved by taking the
GPIO version, there is no build error.

There are a few important patches pending in the GPIO tree that should
undergo testing - Stephen, do you think you could resolve the conflict
that way to enable the latest GPIO tree to be tested again?

Thanks,
Alex.

On Tue, Jul 29, 2014 at 5:42 PM, Thierry Reding <treding@nvidia.com> wrote:
> On Tue, Jul 29, 2014 at 10:31:53AM +0200, Stephen Rothwell wrote:
>> * PGP Signed by an unknown key
>>
>> Hi Linus,
>>
>> After merging the gpio tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>>
>> In file included from arch/arm/mach-tegra/board-paz00.c:20:0:
>> include/linux/gpio/machine.h:24:2: error: unknown type name 'u16'
>>   u16 chip_hwnum;
>>   ^
>> include/linux/gpio/machine.h:31:19: error: field 'list' has incomplete type
>>   struct list_head list;
>>                    ^
>>
>> Caused by commit 0a6d315827ee ("gpio: split gpiod board registration
>> into machine header") or an interaction of that with commit
>> a0524acc94c9 ("ARM: tegra: Sort includes alphabetically") from the
>> arm-soc tree.
>>
>> linux/gpio/machine.h needs to include some of the same files that
>> linux/gpio/driver.h does.  See Rule 1 in Documentation/SubmitChecklist.
>>
>> I have used the version of the gpio tree from next-20140728 for today.
>
> I think linux/gpio/machine.h needs at least linux/types.h (for u16,
> though I guess that "dependency" could be removed by simply making
> gpiod_lookup.chip_hwnum an unsigned int) and linux/list.h for struct
> list_head.
>
> Thierry
