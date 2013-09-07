From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 07 Sep 2013 13:56:39 +0200
Subject: [PATCH v4 5/5] clk: dt: binding for basic gate clock
In-Reply-To: <20130904175909.GB31541@atomide.com>
References: <1377150793-27864-1-git-send-email-mturquette@linaro.org>
 <CAD6h2NSr0cM_SWqniC30pYm0mCeziBOzVg-46-814qPMxUwDCQ@mail.gmail.com>
 <20130904175909.GB31541@atomide.com>
Message-ID: <3912118.JkfesUOyv3@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 04 of September 2013 10:59:09 Tony Lindgren wrote:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [130903 20:11]:
> > We can see that it'll try to find static mapping. What's the static
> > mapping? If we define iotable in machine driver, we have the static
> > mapping, just like debug_ll. If we parse everything from DTS file,
> > it'll always get a new virtual address from vm area. So it always
> > create a new page mapping even for one register.
> 
> I may not follow you here.. But it seems that you've missing something
> with the static mapping: It's found based on the physical address. So
> if you create static mappings for your SoC with iotable_init(), those
> mappings will be available everywhere including drivers when you do
> ioremap().

The thing is that today we are moving in favour of fully dynamic mapping, 
based on data from device tree, with as little as possible (or even no) 
static mapping based on hardcoded values.

So, back to the original problem, we end up doing multiple dynamic 
mappings of the same physical page, because there is no refcounting in 
ioremap and, if it doesn't find a static mapping containing the region 
we're interested in, it simply creates a new mapping.

Best regards,
Tomasz
