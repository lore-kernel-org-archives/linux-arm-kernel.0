From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 16:43:38 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150902225008.GQ21084@n2100.arm.linux.org.uk>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, Sep 2, 2015 at 3:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Never copy the of_node from one device to another.  That allows the
> bus matching to unintentionally match the of_node against the wrong
> driver.

Can you be more specific about what problems you'd expect.  It seems
like a terribly common practice to do this, but maybe I'm
misunderstanding:

On today's next, I do a simple:
  git grep 'dev.of_node = '

...and I find lots of hits:

drivers/i2c/busses/i2c-at91.c:  dev->adapter.dev.of_node = pdev->dev.of_node;
drivers/i2c/busses/i2c-axxia.c: idev->adapter.dev.of_node = pdev->dev.of_node;
drivers/i2c/busses/i2c-bcm-iproc.c:     adap->dev.of_node = pdev->dev.of_node;
drivers/i2c/busses/i2c-bcm-kona.c:      adap->dev.of_node = pdev->dev.of_node;
drivers/i2c/busses/i2c-bcm2835.c:       adap->dev.of_node = pdev->dev.of_node;
drivers/i2c/busses/i2c-brcmstb.c:       adap->dev.of_node = pdev->dev.of_node;
...

So unless I'm mistaken, the code I'm suggesting is a common practice.
Perhaps there is a latent bug that's waiting to bite us.  If so then
that bug should be reported and fixed.  ...but without seeing some
concrete problem (or some reason that the code I'm suggesting is
different than everyone else's code) it seems best to take it and to
later fix it (along with all the other code) if/when we find some
problem.

Objections?

-Doug
