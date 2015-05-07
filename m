From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 07 May 2015 14:03:57 -0700
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <CAMAWPa_n+59+v+x3fKkmdtW1wMJF7kqtTjLLowmv1xwGWprYJw@mail.gmail.com>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>	<1981330.kGUrTurMy5@diego>	<5543E79F.2080400@codeaurora.org>	<22709390.NTAlubMgNB@diego>	<55440EDA.4030905@codeaurora.org>
 <CAMAWPa_n+59+v+x3fKkmdtW1wMJF7kqtTjLLowmv1xwGWprYJw@mail.gmail.com>
Message-ID: <554BD33D.7050907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/15 08:17, Kevin Hilman wrote:
> On Fri, May 1, 2015 at 4:40 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 05/01/15 15:07, Heiko St?bner wrote:
>>> Am Freitag, 1. Mai 2015, 13:52:47 schrieb Stephen Boyd:
>>>
>>>>> Instead I guess we could hook it less deep into clk_get_sys, like in the
>>>>> following patch?
>>>> It looks like it will work at least, but still I'd prefer to keep the
>>>> orphan check contained to clk.c. How about this compile tested only patch?
>>> I gave this a spin on my rk3288-firefly board. It still boots, the clock tree
>>> looks the same and it also still defers nicely in the scenario I needed it
>>> for. The implementation also looks nice - and of course much more compact than
>>> my check in two places :-) . I don't know if you want to put this as follow-up
>>> on top or fold it into the original orphan-check, so in any case
>>>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Thanks. I'm leaning towards tossing your patch 2/2 and replacing it with
>> my patch and a note that it's based on an earlier patch from you.
> It appears this has landed in linux-next in the form of 882667c1fcf1
> clk: prevent orphan clocks from being used.  A bunch of boot failures
> for sunxi in today's linux-next[1] were bisected down to that patch.
>
> I confirmed that reverting that commit on top of next/master gets
> sunxi booting again.
>
>

Thanks for the report. I've removed the two clk orphan patches from
clk-next. Would it be possible to try with next-20150507 and
clk_ignore_unused on the command line? Also we can try to see if
critical clocks aren't being forced on by applying this patch and
looking for clk_get() failures

------8<------

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7e1e2bd189b6..d88585b680bb 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1347,6 +1347,9 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 
 		if (!IS_ERR(clk))
 			clk_prepare_enable(clk);
+		else
+			pr_err("Failed to enable critical clock %s\n",
+					clocks[i]);
 	}
 }
 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
