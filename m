From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 20 Jan 2013 13:56:34 -0800
Subject: [PATCH] of: fix incorrect return value of
 of_find_matching_node_and_match()
In-Reply-To: <50FC66BA.9030503@gmail.com>
References: <1358619642-23607-1-git-send-email-thomas.abraham@linaro.org>
 <50FC66BA.9030503@gmail.com>
Message-ID: <CAJuYYwT++66UUT5wdZh=B=VC7s2=T4w0qO6G7CEG6eCHT5WBCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2013 13:50, Rob Herring <robherring2@gmail.com> wrote:
> On 01/19/2013 12:20 PM, Thomas Abraham wrote:
>> The of_find_matching_node_and_match() function incorrectly sets the matched
>> entry to 'matches' when the compatible value of a node matches one of the
>> possible values. This results in incorrectly selecting the the first entry in
>> the 'matches' list as the matched entry. Fix this by noting down the result of
>> the call to of_match_node() and setting that as the matched entry.
>
> Looks fine, but is this breaking something in 3.8 or can it wait for 3.9?

Yes, it can wait for 3.9. I am using this function while adding device
tree support for timers on exynos platform which will probably merged
in 3.9.

Thanks,
Thomas.

>
> Rob
>
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  drivers/of/base.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 2390ddb..960ae5b 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -612,6 +612,7 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
>>                                       const struct of_device_id **match)
>>  {
>>       struct device_node *np;
>> +     const struct of_device_id *m;
>>
>>       if (match)
>>               *match = NULL;
>> @@ -619,9 +620,10 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
>>       read_lock(&devtree_lock);
>>       np = from ? from->allnext : of_allnodes;
>>       for (; np; np = np->allnext) {
>> -             if (of_match_node(matches, np) && of_node_get(np)) {
>> +             m = of_match_node(matches, np);
>> +             if (m && of_node_get(np)) {
>>                       if (match)
>> -                             *match = matches;
>> +                             *match = m;
>>                       break;
>>               }
>>       }
>>
