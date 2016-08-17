From: neidhard.kim@lge.com (Jongsung Kim)
Date: Wed, 17 Aug 2016 18:42:11 +0900
Subject: [PATCH] arm: module-plts: improve algorithm for counting PLTs
In-Reply-To: <CAKv+Gu_x0KWbtgy6+arEPRQZ=G1Ma7dvX=p07K2UR4aZj=jnYg@mail.gmail.com>
References: <1471352117-19113-1-git-send-email-neidhard.kim@lge.com>
 <CAKv+Gu_x0KWbtgy6+arEPRQZ=G1Ma7dvX=p07K2UR4aZj=jnYg@mail.gmail.com>
Message-ID: <120f8ff1-59aa-fff2-a46a-241fed741af0@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 2016? 08? 16? 23:39, Ard Biesheuvel wrote:
> (+ Dave)
>
> Hello Jongsung,
>
> On 16 August 2016 at 14:55, Jongsung Kim <neidhard.kim@lge.com> wrote:
>> Current count_plts() uses O(n^2) algorithm for counting distinct
>> PLTs. It's good and fast enough when handling relatively small
>> number of relocs. But the time for counting grows so fast by its
>> nature. A Cortex-A53 operating at 1GHz takes about 10 seconds to
>> count 4,819 distinct PLTs from 257,394 relocs. It can be serious
>> for embedded systems those usually want to boot fast.
> If I take the largest module I can find in my multi_v7_defconfig build, I get
>
> $ readelf -r ./net/mac80211/mac80211.ko |wc -l
> 7984
> $ readelf -r ./net/mac80211/mac80211.ko |grep -E JUMP\|CALL |wc -l
> 3675
>
> Where does the figure 257,394 originate from?
We have a relatively large(~12MB) ko that contains kernel drivers to
support an LGE DTV SoC in development:

$ arm-linux-readelf -r kdrv_lg1313.ko | wc -l
280135
$ arm-linux-readelf -r kdrv_lg1313.ko | grep -E JUMP\|CALL | wc -l
62045

Looks still growing.
>
>> This patch introduces faster O(n) algorithm for counting unique
>> PLTs using hash-table. The following table compares the time (in
>> usecs) for counting distinct PLTs from relocs (using Cortex-A53
>> @1GHz mentioned above):
>>
>>         --------------------------------------
>>           relocs    PLTs      O(n^2)     O(n)
>>         --------------------------------------
>>               15       1           1       27
>>               30       6           1       29
>>               60      14           5       31
>>              120      26          15       32
>>              240      47          51       36
>>              480      88         216       50
>>              960     125         560       67
>>            1,920     191       1,476      106
>>            3,840     253       5,731      179
>>            7,680     431      21,226      347
>>           15,360     637      88,211      698
>>           30,720   1,291     331,626    1,369
>>           61,440   1,902     803,964    2,917
>>          122,880   3,320   4,129,439    6,428
>>          245,760   4,646   8,837,064   13,024
>>         ======================================
>>
>> The time increases near-linearly, and the time to handling same
>> 257,394 relocs is reduced to < 20msec from 10 seconds. (< 0.2%)
>>
>> With very small number of PLTs, O(n^2) counting is still faster
>> than O(n) counting, because O(n) counting needs additional O(n)
>> memory space allocation. In these cases, however, the difference
>> looks very short and negligible.
>>
>> This patch does not replaces original O(n^2) counting algorithm
>> with introduced O(n) algorithm, to use it as fall-back algorithm
>> when required memory allocation fails.
>>
> I think there are other optimizations that are much simpler that we
> could look into first. For instance, PLT entries can only be used for
> call and jump relocations that refer to SHN_UNDEF symbols: this is a
> rather fundamental restriction, since the PLT itself must be in range
> for these call and jump instructions. If the module grows so big that
> PLT entries are required for jumps inside the same module, we can no
> longer guarantee that the PLT can be located close enough.
>
> I quickly tested this with the module above:
> Before:
>
> # insmod cfg80211.ko
> [   45.981587] Allocating 238 PLT entries for 3632 external
> jumps/calls (out of 3632 relocations)
> [   45.981967] Allocating 4 PLT entries for 10 external jumps/calls
> (out of 10 relocations)
> [   45.982386] Allocating 19 PLT entries for 37 external jumps/calls
> (out of 37 relocations)
> [   45.982895] Allocating 7 PLT entries for 11 external jumps/calls
> (out of 11 relocations)
> [   45.983409] Allocating 4 PLT entries for 16 external jumps/calls
> (out of 16 relocations)
>
> # insmod mac80211.ko
> [   52.028863] Allocating 545 PLT entries for 5762 external
> jumps/calls (out of 5762 relocations)
> [   52.029207] Allocating 8 PLT entries for 16 external jumps/calls
> (out of 16 relocations)
> [   52.029431] Allocating 4 PLT entries for 4 external jumps/calls
> (out of 4 relocations)
> [   52.029676] Allocating 39 PLT entries for 107 external jumps/calls
> (out of 107 relocations)
>
> (i.e., without the optimization, all jumps and calls are identified as
> potentially external)
>
> After:
>
> # insmod cfg80211.ko
> [   47.685451] Allocating 111 PLT entries for 2097 external
> jumps/calls (out of 3632 relocations)
> [   47.686016] Allocating 3 PLT entries for 5 external jumps/calls
> (out of 10 relocations)
> [   47.686440] Allocating 11 PLT entries for 11 external jumps/calls
> (out of 37 relocations)
> [   47.686837] Allocating 4 PLT entries for 4 external jumps/calls
> (out of 11 relocations)
> [   47.687098] Allocating 3 PLT entries for 13 external jumps/calls
> (out of 16 relocations)
>
> # insmod mac80211.ko
> [   50.410922] Allocating 231 PLT entries for 2857 external
> jumps/calls (out of 5762 relocations)
> [   50.411277] Allocating 2 PLT entries for 2 external jumps/calls
> (out of 16 relocations)
> [   50.411562] Allocating 1 PLT entries for 1 external jumps/calls
> (out of 4 relocations)
> [   50.411918] Allocating 20 PLT entries for 43 external jumps/calls
> (out of 107 relocations)
>
> Another thing to note is that the .init section hardly deserves its
> own PLT. In the example above the 3rd resp 2nd line refers to
> .init.text, and there is really no point in putting 11 resp 2 PLT
> entries (or 88 resp 16 bytes) into a separate section just so that we
> can release it again after init. So the next optimization is to simply
> merge them.
>
> I will send out the patches separately, please tell me what you think.
Your patchset looks great and it can handle 280,135 rels roughly
in 1.5 seconds. (over 5x speed) However, mine is still faster. :-)
I will reply on your patchset with more data.
> Thanks,
> Ard.
Thanks,
JS
