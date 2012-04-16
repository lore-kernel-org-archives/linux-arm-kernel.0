From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 16 Apr 2012 16:10:56 -0700
Subject: [PATCH 13/13] clk: basic: improve parent_names & return errors
In-Reply-To: <20120412064920.GH2445@S2101-09.ap.freescale.net>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-14-git-send-email-mturquette@linaro.org>
 <20120412064920.GH2445@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zMPQK-W_nbRztXCNdLHoTJU73ZnrxAS8VvvmzgdaVS2mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:49 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Apr 11, 2012 at 06:02:51PM -0700, Mike Turquette wrote:
> ...
>> @@ -175,23 +188,32 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>> ? ? ? div->flags = clk_divider_flags;
>> ? ? ? div->lock = lock;
>>
>> + ? ? /* allocate the temporary parent_names */
>> ? ? ? if (parent_name) {
>> - ? ? ? ? ? ? div->parent[0] = kstrdup(parent_name, GFP_KERNEL);
>> - ? ? ? ? ? ? if (!div->parent[0])
>> - ? ? ? ? ? ? ? ? ? ? goto out;
>> + ? ? ? ? ? ? parent_names[0] = kstrdup(parent_name, GFP_KERNEL);
>> + ? ? ? ? ? ? if (!parent_names[0]) {
>> + ? ? ? ? ? ? ? ? ? ? pr_err("%s: could not allocate parent_names\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__);
>> + ? ? ? ? ? ? ? ? ? ? goto fail_parent_names;
>> + ? ? ? ? ? ? }
>> ? ? ? }
>
> Why do we need to copy the parent_names here at all? ?clk_register()
> has done that for each basic clk.

Yes, this was a braindead change on my part.  I'll remove the kstrdup
in my next series (the rest of this patch will stay in).

Thanks,
Mike

> Regards,
> Shawn
