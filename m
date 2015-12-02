From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Dec 2015 16:41:36 -0800
Subject: [PATCH 05/10] ARM: OMAP2+: Disable GPIO softreset for dm81xx
In-Reply-To: <CAALWOA-Cy7MUUE-6i7sovSQLj8g86E1gZu06+45oB20QGGQweA@mail.gmail.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-6-git-send-email-tony@atomide.com>
 <CAALWOA-Cy7MUUE-6i7sovSQLj8g86E1gZu06+45oB20QGGQweA@mail.gmail.com>
Message-ID: <20151202004136.GW23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [151201 16:11]:
> On 2 December 2015 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> > Looks like GPIO softreset status bit on both dm8168 and dm8148
> > is broken and only goes high initially. After writing to sysc
> > softreset bit, the resetdone bit never goes high again.
> 
> The resetdone bit works fine, but it needs all clocks active to come
> up. You're neglecting to enable the debounce clock to the GPIO module:
> 
> > # mw.l 0x4818155c 0x2
> 
> That should write 0x102 instead.

It seems to work only once based on what I've seen :) If you try it
after it's powered it never works. Could be I'm doing something wrong
of course..

> You can disable the debounce clock after resetting the module if you
> don't need it, though I doubt there's any significant power savings
> there. (More likely it exists as a separate bit to allow it to stay
> enabled even if the module isn't, for wakeup on debounced inputs.)

Hmm I tried setting HWMOD_CONTROL_OPT_CLKS_IN_RESET flag like we
have for many SoCs to enable also sysclk18_ck but no luck. I can
recheck that.

Regards,

Tony
