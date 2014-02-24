From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 23 Feb 2014 16:01:53 -0800
Subject: [PATCH v2] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <20140223234150.GA5343@localhost>
References: <1392054179-28830-1-git-send-email-gregory.clement@free-electrons.com>
 <530A420B.5050207@gmail.com> <20140223212040.22529.18650@quantum>
 <20140223234150.GA5343@localhost>
Message-ID: <20140224000153.22529.70067@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ezequiel Garcia (2014-02-23 15:41:51)
> Tomasz, Mike:
> 
> On Sun, Feb 23, 2014 at 01:20:40PM -0800, Mike Turquette wrote:
> > Quoting Tomasz Figa (2014-02-23 10:46:35)
> > > On 10.02.2014 18:42, Gregory CLEMENT wrote:
> > > > Until now the clock providers were initialized in the order found in
> > > > the device tree. This led to have the dependencies between the clocks
> > > > not respected: children clocks could be initialized before their
> > > > parent clocks.
> > > >
> > > > Instead of forcing each platform to manage its own initialization order,
> > > > this patch adds this work inside the framework itself.
> > > >
> > > > Using the data of the device tree the of_clk_init function now delayed
> > > > the initialization of a clock provider if its parent provider was not
> > > > ready yet.
> > > 
> > > In general this is really great. It's a first step towards sorting out 
> > > dependencies between clock providers correctly. I have some comments 
> > > inline, though.
> > 
> > Just to add in here, I think the approach is good but agree with Tomasz'
> > review comments.
> > 
> 
> I'm wondering if any of you has followed the discussion that Greg,
> Emilio and I had about the need of this change.
> 
> If so, can you point out *why* we need to sort out registration
> dependency?

I went through the V1 thread and the "[PATCH 0/4] clk: mvebu: fix clk
init order" thread, and I agree that the driver does create something
like a false dependency by calling of_clk_get() against the parent in
mvebu_clk_gating_setup().

However, there have been issues with clk registration order before. The
orphan list helped out with some but sometimes it is just easier to
enforce registration order. The mvebu and armada problems that surfaced
this merge window may not be the best reason to merge this feature in,
but I do believe it's just going to keep coming up later, if not sooner.

Additionally, I fscking hate the use of strings to link children to
their parents in the core clock code. This was designed by me before DT
came to the ARM world and I took some hints from clkdev, but I shouldn't
have done it that way... This patch helps to reduce the dependency on
the orphan list mechanism (with its evil strcmp) for the DT case at
least.

Please let me know if you still disagree or if I have interpreted the
usefulness of the patch incorrectly.

Regards,
Mike

> -- 
> Ezequiel Garc?a, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com
