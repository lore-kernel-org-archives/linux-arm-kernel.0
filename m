From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 16 Mar 2013 00:34:45 +0100
Subject: [PATCH v2 0/2] refactoring for mask_cache
In-Reply-To: <20130315212545.GT21478@lunn.ch>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
 <20130315212545.GT21478@lunn.ch>
Message-ID: <20130315233445.GP21620@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 10:25:45PM +0100, Andrew Lunn wrote:
> On Fri, Mar 15, 2013 at 08:36:13PM +0100, Gerlando Falauto wrote:
> > Hi everyone,
> > here is a 2-patch set to address the issue found with Orion,
> > hoping I understood correctly what Thomas meant.
> > Even though I'm also providing changes for mvebu, I only
> > tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
> > We currently do not have a working 3.6+ configuration for our Kirkwood
> > boards (3.6 is apparently where this mvebu gpio driver was introduced),
> > so I would be glad if someone could give it a try.
> 
> Hi Garlando
> 
> Could you describe how to reproduce the issue, so i can test it on
> Kirkwood. I have a kirkwood with one GPIO button which i can use for
> tests.

Hi Andrew,

Maybe you could add debugfs entries to the GPIO drivers plat-orion and
gpio-mvebu, in order to allow to dump the GPIO registers. It could even
be reusable for other purposes.

With this debug informations, you can:

1 - Register a level interrupt for GPIO A. This GPIO could be unused.
    Maybe you can do that from some board setup code, once that the
    GPIO subsystem is initialized.
2 - Register an edge interrupt for GPIO B. To do that, you could simply
    load the gpio-key driver. It should eat your GPIO button.
3 - Check the GPIO edge mask register (via debugfs). With the issue,
    GPIO A and GPIO B are unmasked.

Or alternatively, I guess there is a more straightforward way:

1 - Disable the GPIO key driver.
2 - Register a level interrupt for the GPIO button.
3 - Register an edge interrupt for an unused GPIO (take care about
    the active state).
4 - Push and release the button. With the issue, your system should
    freeze. The edge interrupt for the GPIO button is asserted and is
    never acknowledged.

If you want, I can take care of testing the patches.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130316/06196c25/attachment.sig>
