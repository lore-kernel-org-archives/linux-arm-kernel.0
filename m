From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Jul 2017 10:52:13 -0700
Subject: [PATCH] kbuild: modpost: Warn about references from rodata to
 __init text
In-Reply-To: <CAK7LNAQ6y-budCyzFpHubqEtHGwtARNdGa3O3Wacs+55R87dMg@mail.gmail.com>
References: <20170630225822.25349-1-sboyd@codeaurora.org>
 <CAF6AEGuSwgyqf7pb15M0Pg1SJrQu9TVX76FV9jL=i5LNjFcdtA@mail.gmail.com>
 <CAK7LNAQ6y-budCyzFpHubqEtHGwtARNdGa3O3Wacs+55R87dMg@mail.gmail.com>
Message-ID: <20170720175213.GB3291@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Masahiro Yamada wrote:
> Hi Stephen, Rob,
> 
> 2017-07-01 8:59 GMT+09:00 Rob Clark <robdclark@gmail.com>:
> > On Fri, Jun 30, 2017 at 6:58 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> If we have a structure that's marked const it will be placed
> >> into the .rodata section but it could reference an init section
> >> function. Include the read only data section in the check we have
> >> for read/write data sections referencing init sections so we can
> >> find this class of problems. This exposes quite a few places
> >> where const marked structures are referencing __init functions and
> >> __init data that we were previously ignoring.
> >>
> >> Cc: Rob Clark <robdclark@gmail.com>
> >> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >> ---
> >>
> >> Making this change leads to quite a few other errors even on the
> >> multi_v7_defconfig for ARM[1]. I still need to do a build of the
> >> allmodconfig to see how many other errors there, but it seems to
> >> be quite a few. I suppose those will need to be fixed before we can
> >> merge this?
> >
> > thanks.. the explosions you get with these mistakes when building
> > drivers as modules in a distro kernel config are quite "fun" to
> > debug..
> >
> > I'm not quite sure about the rules for whether merging this would
> > count as a regression, but I would argue those drivers are already
> > broken, just no one noticed yet.  Similar to when a new gcc gets more
> > clever about detecting bugs.  So I wouldn't be against merging this
> > first to force drivers to fix their crap ;-)
> 
> I applied this, but this way seems unacceptable.
> I cannot send a pull-req for this
> unless most of the warnings are fixed.
> 
> Is there any activity for driver fixes?

Sorry, no. I've only had a little time to look at the errors
reported. Some of them seem to be noise, because there are
structures that have a handful of members where one of the
members points to an __init function or piece of data that is
only used in __init code. We would need to mark these structures
as __ref or write more complicated section mismatch checking code
to be silent in these cases.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
