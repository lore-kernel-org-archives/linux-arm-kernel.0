From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 10:21:23 +0200
Subject: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <20131022223504.GA19819@core.coreip.homeip.net>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
 <20131021155927.GB4255@core.coreip.homeip.net>
 <20131022114947.30dc9c07@ipc1.ka-ro>
 <20131022223504.GA19819@core.coreip.homeip.net>
Message-ID: <20131023082123.GC7404@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 03:35:05PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 22, 2013 at 11:49:47AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > > On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
> > > >  
> > > > +	if (ts->of)
> > > > +		return tsc2007_get_pendown_state_dt(ts);
> > > > +
> > > >  	if (!ts->get_pendown_state)
> > > >  		return true;
> > > 
> > > Instead of special casing "if (ts->of)" all over the place why don't you
> > > set up the device structure as:
> > > 
> > > 	if (<configuring_tsc2007_form_dt>)
> > > 		ts->get_pendown_state = tsc2007_get_pendown_state_dt;
> > > 
> > > and be done with it?
> > >
> > I also thought about that, but the existing function does not have any
> > parameters, while the DT version of get_pendown_state() requires to get
> > the GPIO passed to it somehow.
> 
> You can always have tsc2007_get_pendown_state_platform() wrapping the
> call. Or we just go and fix board code.

I used to have a patch which did exactly that but never got around to
submitting it. Essentially what it did was add a void * parameter to the
.get_pendown_state() and .clear_penirq() callbacks, along with a new
.callback_data field that the driver could set. At the same time there
was some code to unify code for boards that merely use a simple GPIO as
pendown.

I'm attaching what I think is the latest version. I no longer have
access to the hardware so I can't test this, but perhaps it can serve as
an example of how this could work. Sorry this isn't in the form of a
proper patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: tsc2007.patch
Type: text/x-diff
Size: 9863 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/771afff9/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/771afff9/attachment-0001.sig>
