From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 18 May 2014 20:50:40 +0800
Subject: [GIT PULL] sirf clk update for 3.16
In-Reply-To: <20140515060124.3084.44286@quantum>
References: <CAGsJ_4z+Y2P1YNTQWC-VsaT3N0Kasd=LvxAbLVLMftnt8gZbkg@mail.gmail.com>
 <20140515060124.3084.44286@quantum>
Message-ID: <CAGsJ_4ymGxROu5fz2YFwPMTsPDiXrHUshoQFJ5SWhtHCK5HGKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-15 14:01 GMT+08:00 Mike Turquette <mturquette@linaro.org>:
> Quoting Barry Song (2014-05-12 07:45:00)
>> Hi Mike,
>>
>> can you pull the below update for 3.16? it cleanups the sirf clk codes
>> to fix some minor checkpatch issues according to key customer's
>> requirement.
>>
>>
>> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
>>
>>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
>> tags/clk-sirf-for-3.16
>
> Hi Barry,
>
> I get the following warnings when pulling this tag onto the clk-next
> branch:
>
> In file included from drivers/clk/sirf/clk-prima2.c:20:0:
> drivers/clk/sirf/clk-common.c:199:2: warning: initialization discards ?const? qualifier from pointer target type [enabled by default]
>   .parent_names = pll_clk_parents,
>   ^
>   ... repeats a for every .parent_names instance ...
>
> In file included from drivers/clk/sirf/clk-atlas6.c:20:0:
> drivers/clk/sirf/clk-common.c:199:2: warning: initialization discards ?const? qualifier from pointer target type [enabled by default]
>   .parent_names = pll_clk_parents,
>   ^
>   ... repeats a for every .parent_names instance ...
>
> Can you fix up and resubmit?
>

hi Mike,
this might mean we need a fix in clk core. we moved to "const char *
const" for clk parents
by:
137 -static const char *pll_clk_parents[] = {
138 +static const char * const pll_clk_parents[] = {
...
repeated for every clk_parent.
...

to fix checkpatch issues like:
#287: FILE: clk-common.c:287:
+static const char *dmn_clk_parents[] = {

WARNING: static const char * array should probably be static const char * const

but in clk_init_data, parent_names are "const char **"
const char              **parent_names;

if we don't change the parent_names of clk_init_data structure, the
only thing we can do to fix "warning: initialization discards ?const?
qualifier from pointer target type" is doing things like:

 static struct clk_init_data clk_spi1_init = {
        .name = "spi1",
        .ops = &ios_ops,
-       .parent_names = std_clk_io_parents,
+       .parent_names = (const char **)std_clk_io_parents,
        .num_parents = ARRAY_SIZE(std_clk_io_parents),
 };

but this looks not too right. what is your opinion? i want to send a
fix for this issue by:

commit ef10a461aaa5db647a5e8d4d1f43659bab2ae9e1
Author: Barry Song <Baohua.Song@csr.com>
Date:   Sun May 18 20:47:29 2014 +0800

    clk: move parent_names of clk_init_data to "const char * const *"

    Signed-off-by: Barry Song ...

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5119174..f919806 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -188,7 +188,7 @@ struct clk_ops {
 struct clk_init_data {
        const char              *name;
        const struct clk_ops    *ops;
-       const char              **parent_names;
+       const char * const      *parent_names;
        u8                      num_parents;
        unsigned long           flags;
 };


> Regards,
> Mike
>

-barry
