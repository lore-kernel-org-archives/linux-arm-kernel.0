From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 04 Apr 2016 17:11:47 +0200
Subject: [PATCH 0/2] Embedding Position Independent Executables
In-Reply-To: <20160404095757.GR19428@n2100.arm.linux.org.uk>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160404095757.GR19428@n2100.arm.linux.org.uk>
Message-ID: <16404629.c8PaLD68yt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 4. April 2016, 10:57:57 schrieb Russell King - ARM Linux:
> [Manually reformatted your email so I can reply to it sensibly - please
> don't make me have to do this again, next time I'll ignore your message
> as it's too much effort, thanks]
> 
> On Sun, Apr 03, 2016 at 09:23:52AM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > This series tries to revive the many series trying to achieve the same
> > thing.
> > 
> > I've tried numerous approaches and while using the kernel module loader
> > is actually quite convenient from a relocation point of view it is quite
> > overkill and also it is quite often too late as a lot of the arch
> > specific PM code assume that it is running at boot time, befor having
> > access to any filesystem.
> > 
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

I'm not 100% sure if my try at an explanation will actually help things, but 
I'll try to provide some thoughts.

The series is a continuation of Russ Dill's series from 2013 [0] and Doug's 
try from 2014 [1].

The main issue being on Rockchip that right now on the rk3288 with a 
reasonable amount of assembly we can achieve only a very light suspend mode 
(saving a tiny amount of energy). To save more we need to reinit the ddr 
controller as well as some regulators on resume with code that needs to run 
in sram needing a quite bigger amount of code.

Earlier Rockchip SoCs don't even support that lighter suspend, so get none 
currently at all, as they 

Same reasoning for ddr frequency changes, as they also need a bigger amount 
of code that will very much easier to handle when written in c than in 
assembly.

So this solution is meant to provide the means to achieve all this.



[0] https://lwn.net/Articles/567051/
[1] https://lkml.org/lkml/2014/12/1/617
