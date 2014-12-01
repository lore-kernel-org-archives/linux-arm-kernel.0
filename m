From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 1 Dec 2014 09:22:19 -0800
Subject: [PATCH v2 1/3] power: reset: read priority from device tree
In-Reply-To: <20141201171126.GB22708@leverpostej>
References: <1417453389-1588-1-git-send-email-stefan@agner.ch>
 <1417453389-1588-2-git-send-email-stefan@agner.ch>
 <20141201171126.GB22708@leverpostej>
Message-ID: <20141201172219.GA24692@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:11:26PM +0000, Mark Rutland wrote:
> On Mon, Dec 01, 2014 at 05:03:07PM +0000, Stefan Agner wrote:
> > This patch adds an optional property which allows to specify the
> > reset source priority. This priority is used by the kernel restart
> > handler call chain to sort out the proper reset/restart method.
> > Depending on the power design of a board or other machine/board
> > specific peculiarity, it is not possible to pick a generic priority.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  Documentation/devicetree/bindings/power/reset/syscon-reboot.txt | 3 +++
> >  drivers/power/reset/syscon-reboot.c                             | 5 ++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> > index 1190631..ee41d9c 100644
> > --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> > @@ -11,6 +11,9 @@ Required properties:
> >  - offset: offset in the register map for the reboot register (in bytes)
> >  - mask: the reset value written to the reboot register (32 bit access)
> >  
> > +Optional properties:
> > +- priority: define the priority of the reset (0-255, defaults to 128)
> > +
> 
> NAK. This is a leak of Linux-internal details.
> 
> What is this necessary for?
> 
It establishes which restart handler to use if there more than one means
to reset the system. See documentation to register_restart_handler() in
kernel/reboot.c.

Guenter
