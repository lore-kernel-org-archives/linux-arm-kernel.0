From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Dec 2012 23:40:11 +0000
Subject: CoreSight framework and drivers
In-Reply-To: <50D3972E.4030607@ti.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com> <50D1F37E.6000804@ti.com>
 <20121219212431.GC23594@pratikp-linux.qualcomm.com> <50D34EE5.8090407@ti.com>
 <20121220195127.GA14877@pratikp-linux.qualcomm.com> <50D3972E.4030607@ti.com>
Message-ID: <20121220234011.GE14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 04:54:38PM -0600, Jon Hunter wrote:
> On 12/20/2012 01:51 PM, Pratik Patel wrote:
> > Ok, so are you referring to making CoreSight devices register
> > with AMBA bus instead of platform bus keeping everything else
> > intact?
> 
> Yes exactly. However, please note I am not saying that we should do
> this, and I asking what direction does the community want us to take
> here? Platform bus or AMBA bus?

One of the issues which worries me about mixing peripheral drivers on
random different buses is... what happens when we end up with a SoC
which gates the APB clock at bus level (there are SoCs which gate the
APB clock at peripheral level.)  In other words, an APB bus only gets
clocked upon request.

We can deal with that with the infrastructure we have in place in the
AMBA bus layer, but not with the platform bus - we'd have to teach the
platform bus driver about the special APB clock instead of having it
handled primerily at the bus layer.

At least the coresight ETM peripherals make use of the APB bus.  They
have a whole pile of registers on the APB bus, and they have the
primecell IDs stored in the last words of the peripheral, again just
like the other primecell devices we have using the AMBA bus layer.

What I'd say is... why stick it on a different bus type from the other
peripherals which might make things harder in the future?
