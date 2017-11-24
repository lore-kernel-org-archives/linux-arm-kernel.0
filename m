From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 24 Nov 2017 11:52:40 +0100
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new
 generic binding
In-Reply-To: <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
Message-ID: <20171124105240.GB3792@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 11:19:52AM +0100, Linus Walleij wrote:
> On Mon, Nov 13, 2017 at 2:25 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> 
> > So far all the Allwinner pinctrl drivers provided a table in the
> > kernel to describe all the pins and the link between the pinctrl functions
> > names (strings) and their respective mux values (register values).
> >
> > Extend the binding to put those mappings in the DT, so that any SoC can
> > describe its pinctrl and GPIO data fully there instead of relying on
> > tables.
> > This uses a generic compatible name, to be prepended with an SoC
> > specific name in the node.

This seems backwards to me. I'm not sure if Rob has any hard rules on
this, but in the past I've seen a lot of drivers stick this kind of data
into drivers. I personally also prefer that approach because the data is
completely static and there's no way for any specific board to customize
it. So the tables are in fact implied completely by the SoC compatible
string.

Moving all of this data into device tree has a number of disadvantages:

  * Existing boards already use the static tables in the driver, and the
    device trees don't contain any data, so you can't get rid of any of
    the existing tables because it would break ABI.

  * Moving the table into the DT doesn't actually solve anything because
    the driver would have to validate the DT description to make sure it
    contains valid data. And in order to validate DT content, the driver
    would need a copy of the table anyway.

I don't think you're going to do yourself any favours by pushing this. I
also don't see the commit description give any reason why you want to
move the table into device tree. Do you see any advantages in doing so?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171124/70f02bb4/attachment.sig>
