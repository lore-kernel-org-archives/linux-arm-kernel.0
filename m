From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Wed, 18 Jan 2017 18:48:35 +0100
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <20170118165612.zkjaj36kedg64rjw@lukather>
References: <20161125002852.18097-1-megous@megous.com>
 <0985b1ec-ba95-1505-cc59-adec4b88238f@megous.com>
 <20170109095946.6esbfx6pafega5cd@lukather>
 <557330d0-2dcd-2211-8538-51c4d6b68834@megous.com>
 <20170116164300.j2zvjkxr7c5h5hyo@lukather>
 <f1ccd8ce-df6c-8204-71ab-2f774ac269d5@megous.com>
 <20170118165612.zkjaj36kedg64rjw@lukather>
Message-ID: <c4152a9b-9b31-5ed7-39cd-da1a3489bc89@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 18.1.2017 v 17:56 Maxime Ripard napsal(a):
>>> What's your current plan to fix that? I guess the easiest (and most
>>> likely to be reusable) would be to allow for clock tables, instead of
>>> using the generic approach. We might have some other clocks (like
>>> audio or video) that would need such a precise tuning in the future
>>> too.
>>
>> My proposed solution is this for M factor (H3 specific solution):
>>
>> https://github.com/megous/linux/commit/88be3d421e958579026135d8acec4b3983958738
> 
> This one is fine.
> 
>> and this for P factor:
>>
>> https://github.com/megous/linux/commit/d7f274ed0c13fa9b4099445cb6bf9b2f8f2cfa8a
>>
>> Perhaps it should be configurable if the P limitation is not universal
>> for all NKMP clocks. But I haven't read all the datasheets.
> 
> And this is exactly what I wanted to avoid, for the reason you're
> giving :)
> 
> This is some generic code, and yet you're putting a clock and SoC
> specific limit in there. You have two ways to deal with that. Either
> come up with some generic throttling mecanism to force a particular
> value above or below a given threshold, but that might be tedious to
> do, and require some significant rework.
> 
> Or you can use a table, which is generic and should be relatively
> easy. I really think this is the most straightforward solution, and
> even more so since we just want to support a limited number of
> frequencies in this case.

So I would add a pointer to a table to struct ccu_nkmp and define the
table itself in ccu-sun8i-h3.c?

If struct ccu_nkmp would have non-NULL pointer to a table, it would be
used instead of the math in ccu_nkmp.c.

Sounds ok?

regards,
  o.

> Maxime
> 
