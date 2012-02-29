From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Feb 2012 10:40:59 +0100
Subject: [GIT PULL] at91 first cleanup series for 3.4
In-Reply-To: <201202281218.39428.arnd@arndb.de>
References: <4F4674F2.8090603@atmel.com> <201202271731.03230.arnd@arndb.de>
 <4F4CB824.5010801@atmel.com> <201202281218.39428.arnd@arndb.de>
Message-ID: <4F4DF2AB.6060403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2012 01:18 PM, Arnd Bergmann :
> On Tuesday 28 February 2012, Nicolas Ferre wrote:

[..]

>>> I'm also still not entirely happy with the contents because the newly
>>> introduced macros all still use __raw_readl() instead of readl_relaxed(),
>>
>> This "cleanup" series was not meant to modify this in addition to the
>> removal of at91_sys_xxx() functions. It has already been a long effort
>> and we do not want to mix all modifications together.
>> I think that Jean-Christophe already told you that, BTW.
> 
> Hmm I think I missed that part. My point was that we try to reduce the number
> of instances of __raw_readl. These patches spread them to more places that
> will require cleaning up later. I can see how you want to keep the two changes
> (__raw_readl -> readl_relaxed and at91_sys_xxx -> at91_yyy_xxx) separate, but
> it would be less churn to add one patch first that converts at91_sys_xxx
> to use readl_relaxed and then spread that out than converting them all after
> the fact.

Yes, indeed that would have been a good way to proceed but
unfortunately, this at91_sys_xxx() removal action has begun a while ago
(mainline patches that I can link to this action are from Sept. 2011).
We did not have in mind this move from __raw_xxxx() to xxxx_relaxed() at
that time. Jean-Christophe wanted and still want to finish this action
before switching to those new functions and I agree with him.

We discussed together and decided to move to xxxx_relaxed() in the core
AT91 for early 3.5 development cycle. There will be more to convert, but
it will be safer at that time.

>>> and because the rtt setup appears unnecessarily complex while at the same
>>> time still not sufficient for a combined at91 kernel. It would be nice
>>
>> Well, complexity of this code is pretty low and I do not see a simple
>> way to deal with this (resource with/without drivers, multiple resources
>> on some SoC / single on another, etc.).
> 
> The main problem here is that the presence of devices is determined by
> a CONFIG_* symbol that controls the compilation of the respective
> device driver. It would be nicer if the set of devices that is created
> on a given board is always the same, but the arbitration between the
> drivers is handled independent of which drivers are built into the kernel.
> 
>>> I've applied your series to the staging/cleanup branch for now, which
>>> means it gets into linux-next but I won't send to Linus unless I get
>>> an update.
>>
>> So, tell me if you can create a next/cleanup2 (or any kind of "devel")
>> branch with this pull request. In addition, can you please give me
>> advice for my future work that is dependent on this series (and Grant's
>> irqdomain work actually)...
> 
> I can do that, which would pin down the following branches:
> 
> 1. next/fixes-non-critical
> 2. next/cleanup
> 3. next/soc
> 4. next/cleanup2
> 
> These can no longer get reordered when I do that, but any other branches are
> still independent of these and can be arbitrarily moved around anywhere after
> next/cleanup2.

Ok, I understand your point and all the implications. But the problem
with at91/9x5 branch is that it is a product introduction and it is our
responsibility to no leave it on the side. This material represents in
fact a kind of "base" for our 3.4 development (second step "base" actually).

So if you can create this next/cleanup2, please do: it will help us a
lot. I have created a rebased branch which only relies on
at91/pm_cleanup and at91/9x5 here:

git://github.com/at91linux/linux-at91.git at91-3.4-for_cleanup2

(do you want me to send you another pull request?)


> We can easily put the irqdomain tree into one of the next/* branches as a
> dependency, which causes that particular branch to get delayed until Grant
> has got his patches upstream. If you send me a series for next/boards that
> depend on irqdomain, I would probably put that into a next/boards2 branch
> or into a next/irqdomain branch in case I get similar things from multiple
> people. If Grant's patches are already upstream by the time I get to send
> out the next/boards branch to Linus, I would probably merge next/boards2
> into next/boards and send all of it together.

Ok, we will be able to give you AT91 subsequent development based on
both next/cleanup2 and the future next/irqdomain. So you can forget the
other pull request I have sent some days ago:
"[GIT PULL] at91: irqdomain and device tree for AIC and GPIO"
I will rebase it once you will publish the two branches cited above.

Thanks for your patience and understanding. Best regards,
-- 
Nicolas Ferre
