From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jun 2018 14:21:19 +0200
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <20180618074556.6944-1-linus.walleij@linaro.org>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 9:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This is a proposal for how to handle the non-discoverable
> 96boards plug-in expansion boards called "mezzanines" in the
> Linux kernel. It is a working RFC series meant for discussion
> at the moment.
>
> The RFC was done on the brand new Ultra96 board from Xilinx
> with a Secure96 mezzanine expansion board. The main part
> is in patch 4, the rest is enabling and examples.
>
> The code can be obtained from here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=ultra96
>
> You can for example probably augment the DTS file for any
> upstream-supported 96board and get the Secure96 going with
> it with minor efforts.

Hi Linus,

Thanks for your work on solving this long-standing problem. I've just
read through your patches briefly and have a few thoughts:

- I really like the idea of having C code deal with the mezzanine
  connector itself, acting as an intermediate to tie a number of
  boards to a number of add-on cards, this seems much simpler than
  trying to do everything with overlays or one of the other more
  generic mechanisms.

- I don't like the idea of having the bus driver contain a list of possible
  add-ons, this seems to go against our usual driver model. What
  I think we want instead is to make the connector itself a proper
  bus_type, to allow drivers to register against it as loadable modules,
  and devices (maybe limited to one device) being created as probed
  from DT or some other method as you describe.

- You export symbols in the mezzanine_* namespace, which I think
   is a bit too generic and should perhaps contain something related
   to  96boards in its name to make it less ambiguous. I suspect we
   would add a number of further connectors for hats, capes, lures etc,
   which could all be described as mezzanines. One open question
   is how we structure the commonality between the various
   connectors, but we can defer that until we have more than one
   or two of them.

          Arnd
