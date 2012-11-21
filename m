From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 22:38:59 +0000
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121121205424.GA25470@core.coreip.homeip.net>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpo=B_7rVwePziyNe0rTMokcib_FgEN28cy4nByAzbUyaqg@mail.gmail.com>
 <20121121204324.21126.99677@nucleus>
 <20121121205424.GA25470@core.coreip.homeip.net>
Message-ID: <20121121223859.GQ3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 12:54:24PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 21, 2012 at 12:43:24PM -0800, Mike Turquette wrote:
> > Quoting Viresh Kumar (2012-11-20 02:13:55)
> > > On 20 November 2012 14:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > We'll need to invoke clk_unprepare() via a pointer in our devm_*
> > > > conversion so let's uninline the pair.
> > > 
> > > Sorry, but you aren't doing this :(
> > > This routine is already uninlined as it is in clk.c
> > > 
> > > Instead you are just moving clk_prepare(), etc calls within
> > > #ifdef CONFIG_HAVE_CLK
> > > #else
> > > #endif
> > > 
> > > I doubt why they have been added under #ifdef CONFIG_HAVE_CLK_PREPARE
> > > earlier. Can they exist without CONFIG_HAVE_CLK
> > > 
> > > @Mike: ?
> > > 
> > 
> > HAVE_CLK logically wraps HAVE_CLK_PREPARE.  There is no point in
> > selecting HAVE_CLK_PREPARE without HAVE_CLK.
> > 
> > Looking through the code I see that this used to be the case.  Commit
> > 93abe8e "clk: add non CONFIG_HAVE_CLK routines" moved the
> > clk_(un)prepare declarations outside of #ifdef CONFIG_HAVE_CLK.  That
> > commit was authored by you.  Can you elaborate on why that aspect of the
> > patch was needed?
> > 
> 
> BTW, it looks like the only place where we select HAVE_CLK_PREPARE is
> IMX platform and it also selects COMMON_CLK so I think HAVE_CLK_PREPARE
> can be removed now.

You've checked non-ARM architectures too?
