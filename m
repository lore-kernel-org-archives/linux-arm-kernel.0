From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Aug 2012 11:40:06 +0100
Subject: [PATCH 1/9] ARM: PMU: Add runtime PM Support
In-Reply-To: <CACVXFVMg5Acx4_KGT5jn1JgO3JsXAjZzU8virR=B3+pBrT4o_A@mail.gmail.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-2-git-send-email-will.deacon@arm.com>
 <CACVXFVMg5Acx4_KGT5jn1JgO3JsXAjZzU8virR=B3+pBrT4o_A@mail.gmail.com>
Message-ID: <20120813104006.GA20537@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 04:09:51PM +0100, Ming Lei wrote:
> On Sat, Aug 11, 2012 at 1:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> > +       pm_runtime_put_sync(&pmu_device->dev);
> 
> One question, each pmu is just inside one cpu core and should be
> suspended individually, but looks the above don't support it, do it?

I'll let Jon elaborate, but I'm not sure that suspending the individual PMUs
makes much sense if one of them is being used (other than taking the whole
CPU offline). Given that tasks can migrate and perf-events can be across
multiple CPUs, it makes it a lot easier to treat them as a single entity. It
also allows us to implement mutual exclusion using the same hooks and to
manage any common IP (e.g. CTI) at the same time, without having to keep
track of things like the last man standing.

So, unless Jon has some ideas here, it's not something that I consider to be
a real problem.

Will
