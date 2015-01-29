From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 14:08:25 -0800
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #4
In-Reply-To: <20150129220256.GG20785@quad.lixom.net>
References: <1422532272-32055-1-git-send-email-nicolas.ferre@atmel.com>
 <20150129220256.GG20785@quad.lixom.net>
Message-ID: <CAOesGMjf6mPhq3s9jf+kTvKFkYM+yLdZ7akLQM_q_TCj3qHF3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 2:02 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Jan 29, 2015 at 12:51:12PM +0100, Nicolas Ferre wrote:
>> Arnd, Olof, Kevin,
>>
>> This is a batch of cleanup/soc modifications that you may also stack on top of
>> your "soc" branch as the previous one.
>> It collects some more cleanup material and simplifies the AT91 boot code. Only
>> some little details remain before having a classical DT boot (without additional
>> mapping of registers for instance). This part will be addressed in 3.21.
>>
>> The switch to multi-platform is not included as it needs some patches in ASoC,
>> ata and arm-soc/next/drivers to be able to compile. I may send patches or a
>> pull-request that can be send to Linus late during the merge-window. Tell me
>> how you feel it can be done (or delayed to 3.21).
>>
>> The conflict related to the rename of board-dt-sama5.c => sama5.c is solved in
>> this branch:
>> https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/log/?h=arm-soc-for-next%2bat91-3.20-cleanup
>>
>> Thanks, best regards,
>>
>> The following changes since commit 9726b6892beeaa736610370429a23a481d1b133e:
>>
>>   ARM: at91: pm: remove warning to remove SOC_AT91SAM9263 usage (2015-01-26 13:44:19 +0100)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup4
>>
>> for you to fetch changes up to fa9df37f603459bf08a4f8fc99337874c677e2bf:
>>
>>   ARM: at91/trivial: unify functions and machine names (2015-01-27 18:46:31 +0100)
>>
>> ----------------------------------------------------------------
>> Fourth cleanup/soc batch for 3.20:
>> - merge all the at91sam9 code and remove the empty SoC-specific files
>> - remove the at91_boot_soc that is now useless in a DT context
>> - move the sram code in PM code as it's now only used there
>> - some file + function name changes after this big cleanup
>>
>> ----------------------------------------------------------------
>> Alexandre Belloni (4):
>>       ARM: at91: at91rm9200: set idle and restart from rm9200_dt_device_init()
>>       ARM: at91: merge all SOC_AT91SAM9xxx
>>       ARM: at91: remove at91_boot_soc
>>       ARM: at91: remove at91_dt_initialize and machine init_early()
>>
>> Nicolas Ferre (3):
>>       ARM: at91: move alternative initial mapping to board-dt-sama5.c
>>       ARM: at91: change board files into SoC files
>>       ARM: at91/trivial: unify functions and machine names
>
> Very nice cleanups, and they just keep coming! Just watch out for regressions.
> :)
>
>
> Merged.


Actually, this one might be causing a regression, since it conflicts
with a fix that's in mainline now:

commit b8659752c37ec157ee254cff443b1c9d523aea22
Refs: v3.19-rc1-4-gb8659752c37e
Author:     Wenyou Yang <wenyou.yang@atmel.com>
AuthorDate: Thu Dec 11 15:31:09 2014 +0800
Commit:     Nicolas Ferre <nicolas.ferre@atmel.com>
CommitDate: Mon Jan 12 15:50:23 2015 +0100

    ARM: at91: board-dt-sama5: add phy_fixup to override NAND_Tree

    Appearance: On some SAMA5D4EK boards, after power up, the Eth1 doesn't work.

    Reason: The PIOE2 pin is connected to the NAND_Tree# of KSZ8081,
    But it outputs LOW during the reset period, which cause the
NAND_Tree# enabled.

    Add phy_fixup() to disable NAND_Tree by overriding the Operation
    Mode Strap Override register(i.e. Register 16h) to clear the NAND_Tree bit.

    Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
    Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>


This conflicts since it changes board-dt-sama5.c which is removed by
this branch, but I don't see the same fixup in your branch.

I've dropped this branch so that you can address the above without
causing a bisectability issue -- please send fresh pull request when
addressed.


-Olof
