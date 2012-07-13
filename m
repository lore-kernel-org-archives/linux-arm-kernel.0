From: nm@ti.com (Menon, Nishanth)
Date: Fri, 13 Jul 2012 02:27:49 -0500
Subject: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional
 states
In-Reply-To: <CAORVsuWvELiRj4XYGQ5WZuNbmWO_Hp8FaHHHhSjXbCPDeaigGg@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-3-git-send-email-j-pihet@ti.com>
 <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
 <4FFFB19D.2090808@ti.com>
 <CAOMWX4ctd20p2qBKyVBEE7PxXaEoExMivnE9Kcx6Om1w6U5yCw@mail.gmail.com>
 <CAORVsuWvELiRj4XYGQ5WZuNbmWO_Hp8FaHHHhSjXbCPDeaigGg@mail.gmail.com>
Message-ID: <CAOMWX4faqqLTM+YmiKjqonQyew+U+49PsK04FUKXUUySdJATkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 2:18 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
[..]
>> Santosh pointed me to the thread offline. This is indeed a much better
>> approach IMHO than having 3 conflicting options inside powerdomain
>> framework.
> After looking at the code and having sent my comments, I like it ...
> mainly because it is really similar to my proposal ;-p
> Can you elaborate more on 'having 3 conflicting options inside
> powerdomain framework'?
Current code has:
a) PWRDM_POWER_XYZ -> describe power state
b) PWRSTS_XYZ ->meant to describe supported states for each pwrdm

this patch introduces:
a) PWRDM_POWER_XYZ -> describe power state (only for powerdomain*.[ch])
b) PWRSTS_XYZ ->meant to describe supported states for each pwrdm
c) PWRDM_FUNC_XYZ -> for files other than powerdomain*.[ch]

https://patchwork.kernel.org/patch/1160431/
maintains
a) PWRDM_POWER_XYZ -> describe power state
b) PWRSTS_XYZ ->meant to describe supported states for each pwrdm

i) reduces code churn
ii) supports logic pwr handling within existing framework
iii) no conflicting usage beyond known definition and usage. (though
personally, I;d like to see PWRSTS_XYZ dissappear into private
header..


> Here are the main differences in the implementation:
> - the RFC code provides a _private header file, which forces the
> external users (cpuidle, pmXXXX.c etc.),
That is one of the reasons I like it. I need to have a code which will
be maintained beyond the original code creators - reduced ability to
mess up the code by "not-well-informed" developers is paramount
importance for me.

> - the RFC code still uses the same function names while my code
> renames them to '*_func_*'. This makes the code look more complicated
> than it really is.

True. But, it paves the way to move all functions that is not intended
to be used beyond powerdomain files to a private power domain header -
which achieves the same objective without code churn.

Regards,
Nishanth Menon
