From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 23 Apr 2016 00:49:58 +0200
Subject: [PATCH 0/2] Embedding Position Independent Executables
In-Reply-To: <20160404095757.GR19428@n2100.arm.linux.org.uk>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160404095757.GR19428@n2100.arm.linux.org.uk>
Message-ID: <20160422224958.GD17051@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/04/2016 at 10:57:57 +0100, Russell King - ARM Linux wrote :
> [Manually reformatted your email so I can reply to it sensibly - please
> don't make me have to do this again, next time I'll ignore your message
> as it's too much effort, thanks]
> 

Well, I fixed my editor configuration so it doesn't happen anymore.

> On Sun, Apr 03, 2016 at 09:23:52AM +0200, Alexandre Belloni wrote:
> > I've chosen to be less generic than what Russ did and only handle ARM.
> > I reused the API he defined but I actually went closer to his first
> > implementation by compiling and embedding a real PIE that doesn't
> > actually need relocations (gcc seems to be better at it thanks to ASLR).
> > 
> > In this series, I'm also converting the AT91 suspend code to use that
> > infrastructure as it is quite simple but I also toyed with more complex
> > functions.
> > 
> > The current limitation is that is doesn't actually tries to handle big
> > endian and I didn't test thumb (and this will probably require more work
> > to get that working reliably).
> > 
> > Also, to be more useful prppoer handling of a stack has to be added
> > (this is not too difficult and is planned) and will be enough to get
> > rk3288 suspend/resume and DDR timing changes working.
> 
> Provided there is no linking back to the kernel image (which is enforced
> by the --no-undefined flag), this at first glance looks okay, but what
> is the motivation behind this change?  Just because there's "many series
> trying to do this" isn't really a justification or a reason why we should
> include this in the mainline kernel.
> 

I think Heiko clarified it but there are actually multiple platforms
that will benefit from this infrastructure. I can name at least at91,
rockchip, sunxi and am335x. On am335x, this has been solved by running
that code on the cortex M3 instead of doing that from Linux but it
forces to compile and load a firmware on the cortex M3 so it is not
available for anything else.

For now, I must admit that the code I'm converting is simple enough and
may stay assembly but the final goal is to have DDR reconfiguration done
using that infrastructure, allowing to write the code in C which I
believe many maintainers find more readable.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
