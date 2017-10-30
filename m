From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 30 Oct 2017 09:48:10 +0000
Subject: [PATCH] drivers/firmware: psci_checker: Add missing
 destroy_timer_on_stack()
In-Reply-To: <CAK8P3a1A_Nf=xzPwnW7SCaOumr7Mv5Y7kXCd=b=+-nNdAdG6GA@mail.gmail.com>
References: <1508857353-3602-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAK8P3a1A_Nf=xzPwnW7SCaOumr7Mv5Y7kXCd=b=+-nNdAdG6GA@mail.gmail.com>
Message-ID: <20171030094810.GA14561@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 10:17:54AM +0100, Arnd Bergmann wrote:
> On Tue, Oct 24, 2017 at 5:02 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The PSCI checker suspend_test_thread() function (ie executed for the
> > suspend test) requires an on-stack timer to carry out the test it
> > executes; it sets it up through the setup_timer_on_stack() API.
> >
> > setup_timer_on_stack() requires its counterpart destroy_timer_on_stack()
> > to be called when the timer is disposed of but the PSCI checker code is
> > currently missing that call, leaving the timer object in an incosistent
> > state when the PSCI checker stops the thread executing the suspend
> > test.
> >
> > Add the missing destroy_timer_on_stack() call to fix the omission.
> >
> > Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reported-by: Kees Cook <keescook@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Hi Lorenzo,
> 
> You addressed the patch 'To: arm at kernel.org', but I'm not entirely
> sure what to do with it, it would be nice to be a little more explicit whether
> you want us to apply the patch directly or just review it, and which trees
> you want it to get merged into.

Yes, I was about to reply to you - I should have added some comments
to the patch itself, apologies.

> As you are fixing a regression against v4.10, I would assume you want
> it merged into v4.14 with a 'cc: stable' tag to have it backported into v4.13,
> correct?

Yes it is correct - since the PSCI checker went through ARM SoC I expect
fixes to go through ARM SoC too please (but I should have mentioned the
summary you correctly wrote up above myself).

Thanks,
Lorenzo
