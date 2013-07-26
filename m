From: christian.ruppert@abilis.com (Christian Ruppert)
Date: Fri, 26 Jul 2013 11:26:01 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
Message-ID: <20130726092601.GA1909@ab42.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:37:52AM +0200, Linus Walleij wrote:
> On Sun, Jul 21, 2013 at 5:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> > Actually, a better way to do (c) might be to just add an extra "op" to
> > struct pinmux_ops; something like validate_gpio_mux(), passing in
> > information such as whether a mux function is in effect on that pin,
> > whether the pin is already claimed as a GPIO, and whether the function
> > is being called to check a GPIO-claim or mux-claim operation . If the op
> > is missing, no "dual claim" is allowed. If the op is present, the code
> > in the op validates whether the particular GPIO is allowed to be claimed
> > while the particular mux function is active.
> >
> > That way, I think any driver that doesn't want to allow dual-claim
> > doesn't have to do anything, but the few drivers that do can code up
> > whatever algorithm they want; for Tegra, I'd just allow everything for
> > simplicity, but we could always enhance that later if we want.
> 
> You are right, this would be an elegant solution.
> 
> Christian, are you interested in coding this up?

When thinking about it, we require the same mechanism the other way
round: If a GPIO is claimed first we need a mechanism to forbid
incompatible reconfiguration of other functionalities until that GPIO is
free again.

I like Stephen's proposal (in another mail) to claim GPIOs from the
pinctrl drivers but instead of modifying the callback prototypes I
suggest to add the following functions:

/*
 * Claim GPIO pin (in the sense: forbid acutal GPIO usage)
 */
int claim_gpios(struct pinctrl_dev *pctl, unsigned *pins
                unsigned port_selector, unsigned func_selector);

/* allow GPIO usage of the given pins */
void unclaim_gpios(struct pinctrl_dev *pctl, unsigned *pins);

Claiming could be fully dynamic. This way, driver authors don't need to
implement additional callbacks or modify their existing ones. In the
simplest case they do nothing. The entire conflict-checking logic is
confined inside the core.

Alternatively, a similar set of functions could make the use of GPIOs
exclusive with other functions for a given set of pins. This would work
very well with the proposal below and would be easier to manage for most
driver authors: The configuration would be static in most cases.
(We just have to discuss about the default mode, do we want to keep the
backward-compatible inclusive default or change everything to exclusive
by default?).

A last point I would like to address before passing on to implementation
is to introduce the notion of interfaces: I think it is important to
introduce some orthogonality between unrelated interfaces which happen
to be muxed on the same port and ideally we implement this coherently
with the above.

I would like to know your opinion if the following proposal is generic
enough or if it encodes too much chip-specific logic into the core:

- We extend the notion of pin groups to represent either ports (as it is
  currently the case) or interfaces. No need to use name pin groups in
  both cases, I'm open to proposals for better terminology.
- Functions are associated either to one port or a set of interfaces.
- Functions continue to apply to an entire port but they only claim the
  pins of the interfaces they are associated with.
- A client can request either a function or an interface from the
  pinctrl core. In the second case, the core will figure out if the
  request is coherent with previous requests (i.e. if there is a
  function providing all requested interfaces) and call the driver
  accordingly.

We'll have to figure out a few details but I would like to have an
agreement on fundamentals before spending time on implementation.

Greetings,
  Christian

-- 
  Christian Ruppert              ,          <christian.ruppert@abilis.com>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr?-Fleuri
                             _// | bilis Systems   CH-1228 Plan-les-Ouates
