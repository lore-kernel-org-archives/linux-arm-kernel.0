From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 27 Aug 2014 09:58:44 -0600
Subject: [PATCH v7 3/8] cpufreq: kirkwood: Remove use of the clk provider
 API
In-Reply-To: <20140826233008.5251.50447@quantum>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-4-git-send-email-tomeu.vizoso@collabora.com>
 <20140820225513.5251.284@quantum> <53F5A587.9030200@collabora.com>
 <20140821133825.GH8608@lunn.ch> <20140822192933.5251.53733@quantum>
 <20140822201112.GH17277@lunn.ch>
 <20140826214631.5251.66177@quantum> <20140826223637.GA5324@lunn.ch>
 <20140826233008.5251.50447@quantum>
Message-ID: <20140827155844.GA911@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 04:30:08PM -0700, Mike Turquette wrote:

> 2) for the kexec-kernel-case, the responsibility is on the first kernel
> to set things up in a good state for the second kernel, with the
> exception of using kexec to debug/examime/recover from a kernel crash,
> in which case you likely don't care about this stuff as much

FWIW, we frequently use a kexec flow on Kirkwood for development here
- and I have not been able to get the initial kernel to cleanly shut
down before kexec'ing the second kernel.

The flow we've had to use involved including a pre-kernel stub in the
kexec flow that goes around and cleans up all the registers enough so
that the 2nd kernel will work properly. Critically it does things like
turn off ethernet DMA, because the initial kernel won't even do that
:|

There is some kind of support for doing this, but I ran out of time
unraveling the mess of config options to actually turn it on for
kirkwood.. It is tied to PM support which was/is missing elements on
Kirkwood..

Jason
