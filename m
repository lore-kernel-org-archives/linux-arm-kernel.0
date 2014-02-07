From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 7 Feb 2014 19:42:04 +0100
Subject: [PATCH RFC 0/2] drivers/base: simplify simple DT-based components
In-Reply-To: <20140207173326.GD26684@n2100.arm.linux.org.uk>
References: <cover.1391793068.git.moinejf@free.fr>
 <20140207173326.GD26684@n2100.arm.linux.org.uk>
Message-ID: <20140207194204.4d4326bd@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Feb 2014 17:33:26 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Feb 07, 2014 at 06:11:08PM +0100, Jean-Francois Moine wrote:
> > This patch series tries to simplify the code of simple devices in case
> > they are part of componentised subsystems, are declared in a DT, and
> > are not using the component bin/unbind functions.
> 
> I wonder - I said earlier today that this works absolutely fine without
> modification with DT, so why are you messing about with it adding DT
> support?
> 
> This is totally the wrong approach.  The idea is that this deals with
> /devices/ and /devices/ only.  It groups up /devices/.
> 
> It's up to the add_component callback to the master device to decide
> how to deal with that.
> 
> > Jean-Francois Moine (2):
> >   drivers/base: permit base components to omit the bind/unbind ops
> 
> And this patch has me wondering if you even understand how to use
> this...  The master bind/unbind callbacks are the ones which establish
> the "card" based context with the subsystem.
> 
> Please, before buggering up this nicely designed implementation, please
> /first/ look at the imx-drm rework which was posted back in early January
> which illustrates how this is used in a DT context - which is something
> I've already pointed you at once today already.

As I told in a previous mail, your code works fine in my DT-based
Cubox. I am rewriting the TDA988x as a normal encoder/connector, and,
yes, the bind/unbind functions are useful in this case.

But you opened a door. In a DT context, you know that the probe_defer
mechanism does not work correctly. Your work permits to solve delicate
cases: your component_add tells exactly when a device is available, and
the master bind callback is the green signal for the device waiting for
its resources. Indeed, your system was not created for such a usage,
but it works as it is (anyway, the component bind/unbind functions may
be empty...).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
