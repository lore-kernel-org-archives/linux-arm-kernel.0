From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 8 Feb 2016 23:22:06 +0100
Subject: [PATCH] clk: meson: Fix meson_clk_register_clks() signature type
 mismatch
In-Reply-To: <20160208221508.GT4848@codeaurora.org>
References: <1454879583-27036-1-git-send-email-afaerber@suse.de>
 <20160208221508.GT4848@codeaurora.org>
Message-ID: <56B9150E.5010808@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.02.2016 um 23:15 schrieb Stephen Boyd:
> On 02/07, Andreas F?rber wrote:
>> As preparation for arm64 based mesongxbb, which pulls in this code once
>> enabling ARCH_MESON, fix a size_t vs. unsigned int type mismatch.
>> The loop uses a local unsigned int variable, so adopt that type,
>> matching the header.
>>
>> Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
> Applied to clk-next. It would have been nice to have the
> compilation error though

Ask and you shall receive:

  CC      drivers/clk/meson/clkc.o
drivers/clk/meson/clkc.c:200:13: error: conflicting types for
'meson_clk_register_clks'
 void __init meson_clk_register_clks(const struct clk_conf *clk_confs,
             ^
In file included from drivers/clk/meson/clkc.c:22:0:
drivers/clk/meson/clkc.h:180:6: note: previous declaration of
'meson_clk_register_clks' was here
 void meson_clk_register_clks(const struct clk_conf *clk_confs,
      ^
scripts/Makefile.build:258: recipe for target 'drivers/clk/meson/clkc.o'
failed
make[3]: *** [drivers/clk/meson/clkc.o] Error 1
scripts/Makefile.build:407: recipe for target 'drivers/clk/meson' failed
make[2]: *** [drivers/clk/meson] Error 2
scripts/Makefile.build:407: recipe for target 'drivers/clk' failed
make[1]: *** [drivers/clk] Error 2
Makefile:959: recipe for target 'drivers' failed
make: *** [drivers] Error 2

Not really telling, is it. ;)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
