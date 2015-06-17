From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Jun 2015 08:47:35 -0500
Subject: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <20150617133314.GB15153@linux>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
Message-ID: <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 8:33 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-06-15, 08:23, Rob Herring wrote:
>> > +                       operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
>>
>> You've made a fundamental change here in that this can now be a list
>> of phandles. There should be some description on what a list means
>> (merge the tables?, select one?).
>
> Did you miss the description I wrote few lines earlier or are you
> asking for something else? This is what I wrote earlier:
>
>> > +Devices may want to choose OPP tables at runtime and so can provide a list of
>> > +phandles here. But only *one* of them should be chosen at runtime.
>
> So, clearly only ONE of the tables should be used.

Yes, never mind.

>
>> I think this needs to have a defined order and the platform should
>> know what that is. For example, if you read the efuses and decide you
>> need the "slow" table, you know to pick the first entry. Then you
>> don't need opp-name. Does that work for QCom?
>
> Why forcing on the order here? For example, consider a case where the
> platform can have four tables, A B C D. Now DT is free to pass all
> four or just a subset of those. Like, for some boards table B doesn't
> stand valid. And so it may wanna pass just A C D. And so keeping these
> tables in order is going to break for sure. Flexibility is probably
> better in this case.

Defined order is a key part of DT bindings. We solve the variable
length problem with name lists associated with variable length
property like:

operating-point-names = "slow", "fast";

I'm not a fan of doing this if we can avoid it, but we should at least
follow the same pattern. Don't send me a patch with that yet, I want
to hear from Stephen.

You can also use "status" to disable specific tables rather than
removing from the list.

Rob
