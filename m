From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 29 Jul 2015 22:52:21 +0800
Subject: [PATCH 5/7] clk: atlas7: fix the clock tree for bluetooth stuff
In-Reply-To: <55B7FD22.10609@codeaurora.org>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-6-git-send-email-21cnbao@gmail.com>
 <55B7FD22.10609@codeaurora.org>
Message-ID: <CAGsJ_4wg1+5KrwTJRzE-iaSTvgvgFrM6cDyUTL16gx6Hk+tdPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-29 6:07 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 07/27/2015 11:27 PM, Barry Song wrote:
>> From: Guo Zeng <guo.zeng@csr.com>
>>
>> normally dmac should depends on only one clock, to operate
>> dmac internal register, but dmac4 is very special case, it
>> normally dmac should depends on only one clock, to operate
>> dmac internal register, but dmac4 is very special case, it
>
> The sentence is duplicated twice here
>
>> depends on two additional clock, the reason is that dmac4
>> is wrapped in hw into bt a7ca module, and accessing dmac4
>> internal register would also require that the a7ca_io and
>> related bt macro io clk also enabled.
>> here workaround this by setting depend clk into parent of
>> dmac4, and also related clks, to reflect dependency.
>
> We don't put clocks as parents of other clocks just because the child
> depends on the parent to be accessed. It isn't very clear from the
> description, but it sounds like a7ca_io is just another clock that the
> bluetooth driver needs to control? We want to express the true clk
> hierarchy, not some psuedo dependency tree.
>

Stephen, generically i agree the codes should be a map of real
hardware connection. here the problem is real hardware connection is
very much difficult for its drivers implementation and these clocks
are buggy designed in HW. they are not a tree, they are a "network".

see attached diagram(hope LKML will not reject the attachment), we are
not a tree,  that means btm_noc_clk depends on btm_io_clk, a7ca_io_clk
depends on btm_io_clk, dmac4_io_clk depends on btm_noc_clk,
a7ca_io_clk and btm_noc_clk....
usp3_io_clk depends on uart6_io_clk, dmac4_io_clk, btm_noc_clk,
a7ca_io_clk and btm_noc_clk.

so in the driver, we have a choice as below:
in uart6 driver, we take all of the clocks.
in dmac4 driver, we take all of btm_noc_clk, a7ca_io_clk and btm_noc_clk.
...
what a ugly code! that is what we did before.

so here, we moved to do a not-real clock tree,  that means
we makes
1.btm_io_clk the parent of btm_noc_clk
2. btm_noc_clk the parent of a7ca_io_clk
3. a7ca_io_clk the parent of dmac4_io_clk
...

but it doesn't break any dependency of these clocks, and make all
clients driver as clean as a simple tree.
i strongly think we should keep this "workaround", otherwise, we have
many pain in all of the related drivers.

>> noc_io
>>     -btm_noc_clk
>>             -a7ca_io
>>                     -dmac4_io
>>                                     -uart6_io
>>                                     -usp3_io
>>
>> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/clk/sirf/clk-atlas7.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
>> index 1000421..c1788df 100644
>> --- a/drivers/clk/sirf/clk-atlas7.c
>> +++ b/drivers/clk/sirf/clk-atlas7.c
>> @@ -1169,10 +1169,10 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
>>       { 127, "vss_sdr", "gpum_sdr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 1, &leaf7_gate_lock },
>>       { 128, "thgpum_nocr", "gpum_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 2, &leaf7_gate_lock },
>>       { 129, "a7ca_btss", "btm_btss", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 1, &leaf8_gate_lock },
>> -     { 130, "dmac4_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 2, &leaf8_gate_lock },
>> -     { 131, "uart6_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 3, &leaf8_gate_lock },
>> -     { 132, "usp3_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 4, &leaf8_gate_lock },
>> -     { 133, "a7ca_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 5, &leaf8_gate_lock },
>> +     { 130 , "dmac4_io", "a7ca_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 2, &leaf8_gate_lock },
>> +     { 131 , "uart6_io", "dmac4_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 3, &leaf8_gate_lock },
>> +     { 132 , "usp3_io", "dmac4_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 4, &leaf8_gate_lock },
>> +     { 133 , "a7ca_io", "noc_btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 5, &leaf8_gate_lock },
>>       { 134, "noc_btm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 6, &leaf8_gate_lock },
>>       { 135, "thbtm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 7, &leaf8_gate_lock },
>>       { 136, "btslow", "xinw_fixdiv_btslow", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 25, &root1_gate_lock },
>

-barry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.png
Type: image/png
Size: 27774 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/73e9f8b5/attachment-0001.png>
