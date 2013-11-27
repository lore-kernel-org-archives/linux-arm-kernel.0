From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Nov 2013 13:53:10 -0800
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131124213651.59750C402C3@trevor.secretlab.ca>
References: <20131123004334.GJ10023@atomide.com>
 <20131124213651.59750C402C3@trevor.secretlab.ca>
Message-ID: <20131127215310.GC26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@linaro.org> [131124 13:37]:
> 
> I actually like the idea of completely allocating the resource structure
> but leaving some entries empty. However, I agree with rmk that putting
> garbage into a resource structure is a bad idea. What about changing the
> value of flags to 0 or some other value to be obviously an empty
> property and give the follow up parsing some context about which ones it
> needs to attempt to recalculate?

If we want to play it safe, we should probably introduce something like
this to ioport.h:

+#define IORESOURCE_IRQ_DEFERRED	(1<<6)

Then we can populate IRQ resources initially with that. And later on
during the driver probe, we know it's safe to populate the resource
if res->flags & IORESOURCE_IRQ_DEFERRED.

That fixes the $Subject bug, and gets us a little bit further for
making more changes later on.

Regards,

Tony
