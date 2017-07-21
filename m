From: johan@kernel.org (Johan Hovold)
Date: Fri, 21 Jul 2017 09:46:01 +0200
Subject: [PATCH 2/4] gpio: davinci: Handle the return value of
 davinci_gpio_irq_setup function
In-Reply-To: <02965359-ecf1-b934-6b7a-87162d7d00a4@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-3-git-send-email-j-keerthy@ti.com>
 <20170719111000.GX29638@localhost>
 <cbea9082-3799-281b-1364-50e442f5362f@ti.com>
 <cc66dfaf-05c5-8d55-03a6-556ec83c4487@ti.com>
 <20170720095047.GA2729@localhost>
 <47055927-5102-b39f-fdbb-b5d89cb14632@ti.com>
 <20170720100509.GB2729@localhost>
 <02965359-ecf1-b934-6b7a-87162d7d00a4@ti.com>
Message-ID: <20170721074601.GC2729@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 04:34:42PM -0500, Grygorii Strashko wrote:
> 
> 
> On 07/20/2017 05:05 AM, Johan Hovold wrote:
> > On Thu, Jul 20, 2017 at 03:32:27PM +0530, Keerthy wrote:
> >> On Thursday 20 July 2017 03:20 PM, Johan Hovold wrote:
> >>> On Thu, Jul 20, 2017 at 02:40:37PM +0530, Keerthy wrote:
> >>>> On Thursday 20 July 2017 12:14 PM, Keerthy wrote:
> >>>>> On Wednesday 19 July 2017 04:40 PM, Johan Hovold wrote:
> > 
> >>>>>> There's a separate but related bug here too as the clk_prepare_enable()
> >>>>>> in davinci_gpio_irq_setup() is never balanced on driver unbind.
> >>>>>
> >>>>> Yes Johan. I will send that as a separate patch.
> >>>>
> >>>> This is already fixed in the latest kernel:
> >>>>
> >>>> commit 6dc0048cff988858254fcc26becfc1e9753efa79
> >>>> Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >>>> Date:   Tue May 23 14:48:57 2017 +0530
> >>>
> >>> That change only handles errors in davinci_gpio_irq_setup() (i.e. during
> >>> probe) and not the imbalance at driver unbind that I was referring to.
> >>
> >> Okay got it. One more clk_unprepare_disable() call needs to be there in
> >> probe err path.
> > 
> > No, you need to balance it on driver unbind, that is, in a new remove()
> > callback.
> > 
> 
> Sry, but manual driver unbind for this driver is really smth unexpected ;(

It certainly wouldn't be something often used (e.g. besides during
development) but that doesn't mean it should not be implemented.

> So, I'm not sure if it need to be implemented and even yes - it should not be
> a part of this patch.

That's why I said "separate, but related" above.

> Probably, smth like "convert driver to be a module".
>
> By the way, I've tried to unbind gpio-omap, result - failure (expected),
> as unbind does not take into account module refcnt state.

Indeed. We also have CONFIG_DEBUG_TEST_DRIVER_REMOVE which would try to
unbind this driver during probe if enabled.

Getting into the habit of properly cleaning up allocated and enabled
resources is only a good thing; it shows that the author has thought
this through and serves as documentation of what needs to be released in
both probe error paths and driver unbind callbacks.

Assumptions also change over time (e.g. deferred probe and
CONFIG_DEBUG_TEST_DRIVER_REMOVE), and by not taking such shortcuts we
are also preventing incomplete code from being copied and reproduced in
other drivers (e.g. on hotpluggable buses).

So, just add the remove callback (in a separate patch) and everything is
good.

Thanks,
Johan
