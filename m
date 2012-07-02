From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 2 Jul 2012 16:29:10 -0700
Subject: [PATCH v2] clk: __clk_set_parent: set uninitialized variable
In-Reply-To: <4FF15EDF.7030806@ti.com>
References: <1341214902-15667-1-git-send-email-mkl@pengutronix.de>
 <4FF15EDF.7030806@ti.com>
Message-ID: <CAJOA=zN1FoFQmuht1R06n2xQbZ=g0aqN=5Lo2-v8MQx55qHmeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2012 at 1:42 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Monday 02 July 2012 01:11 PM, Marc Kleine-Budde wrote:
>>
>> This patch fixes the following warning:
>>
>> ? ? ?drivers/clk/clk.c: In function '__clk_set_parent':
>> ? ? ?drivers/clk/clk.c:1083:5: warning: 'i' may be used uninitialized in
>> this function [-Wuninitialized]
>>
>> which has been introduced with commit:
>>
>> ? ? ?commit 7975059db572eb47f0fb272a62afeae272a4b209
>> ? ? ?Author: Rajendra Nayak<rnayak@ti.com>
>> ? ? ?Date: ? Wed Jun 6 14:41:31 2012 +0530
>>
>> ? ? ? ? ?clk: Allow late cache allocation for clk->parents
>>
>> This patch applies to linux-3.5-rc5
>>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Marc Kleine-Budde<mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> here an updated version. Changes since v1:
>> - Set i to clk->num_parents as Uwe pointed out.
>
>
> I started looking at how to avoid this initing
> of i to clk->parents (which is correct for the logic
> used below, but somehow seems error prone if someone
> happens to change the logic without noticing the init
> part)
> This is what I came up with, not tested at all, but
> worth considering if Mike dislikes the idea of initing
> i to clk->parents.
>

Hi Rajendra and Marc,

I prefer the code flow in Rajendra's change.  It seems more readable
and has a negative diffstat ;-)

$ git diff --stat
 drivers/clk/clk.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

Rajendra, can you test and send a proper patch for the same?  Thanks
Marc for sending your two previous patches.  I don't think that I will
Cc this one to stable since it falls under the category of
"theoretical but not yet observed" bugs.

Thanks again,
Mike

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index dcbe056..af737cc 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1067,26 +1067,23 @@ static int __clk_set_parent(struct clk *clk, struct
> clk *parent)
>
> ? ? ? ? old_parent = clk->parent;
>
> - ? ? ? /* find index of new parent clock using cached parent ptrs */
> - ? ? ? if (clk->parents)
> - ? ? ? ? ? ? ? for (i = 0; i < clk->num_parents; i++)
> - ? ? ? ? ? ? ? ? ? ? ? if (clk->parents[i] == parent)
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
> - ? ? ? else
> + ? ? ? if (!clk->parents)
>
> ? ? ? ? ? ? ? ? clk->parents = kzalloc((sizeof(struct clk*) *
> clk->num_parents), ? ? GFP_KERNEL);
> -
> ? ? ? ? /*
> - ? ? ? ?* find index of new parent clock using string name comparison
> - ? ? ? ?* also try to cache the parent to avoid future calls to
> __clk_lookup
> + ? ? ? ?* find index of new parent clock using cached parent ptrs,
> + ? ? ? ?* or if not yet cached, use string name comparison and cache
> + ? ? ? ?* them now to avoid future calls to __clk_lookup.
> ? ? ? ? ?*/
> - ? ? ? if (i == clk->num_parents)
> - ? ? ? ? ? ? ? for (i = 0; i < clk->num_parents; i++)
> - ? ? ? ? ? ? ? ? ? ? ? if (!strcmp(clk->parent_names[i], parent->name)) {
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (clk->parents)
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk->parents[i] =
> __clk_lookup(parent->name);
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
> - ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? for (i = 0; i < clk->num_parents; i++) {
> + ? ? ? ? ? ? ? if (clk->parents && clk->parents[i] == parent)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? else if (!strcmp(clk->parent_names[i], parent->name)) {
> + ? ? ? ? ? ? ? ? ? ? ? if (clk->parents)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk->parents[i] =
> __clk_lookup(parent->name);
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
>
> ? ? ? ? if (i == clk->num_parents) {
> ? ? ? ? ? ? ? ? pr_debug("%s: clock %s is not a possible parent of clock
> %s\n",
>
> regards,
> Rajendra
>
>
>>
>> regards, Marc
>>
>> ? drivers/clk/clk.c | ? ?6 ++++--
>> ? 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index dcbe056..9a75635 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1068,13 +1068,15 @@ static int __clk_set_parent(struct clk *clk,
>> struct clk *parent)
>> ? ? ? ? old_parent = clk->parent;
>>
>> ? ? ? ? /* find index of new parent clock using cached parent ptrs */
>> - ? ? ? if (clk->parents)
>> + ? ? ? if (clk->parents) {
>> ? ? ? ? ? ? ? ? for (i = 0; i< ?clk->num_parents; i++)
>> ? ? ? ? ? ? ? ? ? ? ? ? if (clk->parents[i] == parent)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>> - ? ? ? else
>> + ? ? ? } else {
>> + ? ? ? ? ? ? ? i = clk->num_parents
>> ? ? ? ? ? ? ? ? clk->parents = kzalloc((sizeof(struct clk*) *
>> clk->num_parents),
>>
>> GFP_KERNEL);
>> + ? ? ? }
>>
>> ? ? ? ? /*
>> ? ? ? ? ?* find index of new parent clock using string name comparison
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
