From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 24 Jun 2011 13:40:27 +0200
Subject: [PATCH] USB: ehci: use packed, aligned(4) instead of removing
	the packed attribute
In-Reply-To: <Pine.LNX.4.44L0.1106231022500.2033-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1106231022500.2033-100000@iolanthe.rowland.org>
Message-ID: <4E0477AB.3080400@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.06.2011 16:25, schrieb Alan Stern:
> On Thu, 23 Jun 2011, Alexander Holler wrote:
>
>> Sorry, I never wanted to talk about the issue itself (I've already said
>> that), I just wanted to bring in some additional clarity for people
>> looking at the code.
>>
>> I think if there is a packed,aligned(4) most people reading that are
>> able to imaging how the struct looks like, whereas nothing (without
>> packed) might leave doubts which than requires to read compiler docs or
>> the generated code, if one searches a problem in that area.
>
> I disagree.  If there are no annotations at all (no packed), there
> should be no doubts.  The compiler will add padding wherever it is
> needed for internal alignment and perhaps also at the end of the
> structure.  Nowhere else.

I agree to disagree but I assume thats ok. ;)

Let me finally add some maybe interesting or informational points for 
those who are working or examing the issue and/or who might be involved 
in other discussions on the reason for removing the packed:

- I didn't have any problems booting from ehci with kernels compiled 
with gcc 4.6 on armv5 (or x86*).

- 2.6.38.4 (and below) compiled with gcc 4.6 booted from ehci (on a 
classic beagleboard c4, armv7), whereas everything from 2.6.38.5 upwards 
didn't (same compiler, same config). I've discovered that before having 
seen that this might be the issue with the packed, therefor I haven't 
tested if 2.6.38.5 might work without a packed and have just used gcc 
4.5.x for 2.6.38.x. I have tested that a 2,6,39.x compiled with gcc 4.6 
and with a removed packed boots from ehci on the beagleboard, so the 
patch which removes the packed might be a candidate for the stable tree. 
The reason why booting from ehci stopped with 2.6.38.5+ (gcc 4.6) might 
be interesting for someone. Looking at the git log I haven't seen 
something special and I don't know why anything below 2.6.38.5 worked 
with gcc 4.6 and the packed.

- I don't like the idea that every member of every packed struct 
(without an aligned) might be handled byte by byte. It might be 
necessary but I still don't like it and would prefer the old behaviour 
of gcc. I've added this point just to express my personal humble opinion 
and I don't want to get involved in a discussion on that topic. ;)

I've just got involved on that topic by accident and never have had a 
real reason to do something there (I've done that just for fun). 
Therefore I now prefer to disappear, which means there is absolutely no 
reason to respond (to me) or to explain anything to me.

Regards and sorry if I wasted someones time,

Alexander
