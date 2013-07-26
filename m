From: christian.ruppert@abilis.com (Christian Ruppert)
Date: Fri, 26 Jul 2013 11:26:00 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <51EEA58A.30206@wwwdotorg.org>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org> <20130722083535.GA19685@ab42.lan>
 <51EEA58A.30206@wwwdotorg.org>
Message-ID: <20130726092559.GB7207@ab42.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 08:47:22AM -0700, Stephen Warren wrote:
> On 07/22/2013 01:35 AM, Christian Ruppert wrote:
> > On Sat, Jul 20, 2013 at 09:44:10PM -0600, Stephen Warren wrote:
> >> On 07/20/2013 04:44 PM, Linus Walleij wrote:
> > [...]
> > [ An introductory note on terminology: in the following, "port" refers
> > to a set of pins who's mux is controlled through the same bit field in
> > the same register,
> 
> I believe that's exactly what a "pingroup" is in pinctrl subsystem
> terminology. Where there is already an existing name for something, it'd
> be best to use that so that every person doesn't use a different name
> for everything.

Actually, I use this terminology because in my head a pingroup is "just"
an abstract data structure (i.e. a named list of pins). I think one of
our points of discussion is if this data structure should be used only
to represent what I call ports or if it can also represent things like
interfaces, gpio-ranges etc. Thus, we need a terminology to talk about
the "physical equivalents"...

> > "interface" refers to the set of pins comprising a
> > functional unit, e.g. SCL and SDA of an I2C interface or the four pins
> > of an SPI interface ]
> > 
> > In my understanding, the problem stems from the fact that we always
> > claim an entire port instead of just the pins required for a given
> > functionality.
> 
> Yes.
> 
> > The pinctrl core is already well equipped to manage
> > claiming interfaces instead of ports and thus a fourth alternative would
> > be to
> 
> I would argue that's not the case. pinctrl knows absolutely nothing
> about "interfaces"; there is no data structure defines that describes
> interfaces at all.

Well, pin groups are perfectly capable of representing interfaces
instead of ports (see my remark above).

> That's not saying such a thing could not be added; I'm simply arguing
> that "well equipped" doesn't seem to be true at the moment.

Intuitively, I would implement this by adding a second level of
semantics on top of pin groups (at the same level as the "functions" we
already have).

Alternatively, one could add the notion of interfaces to functions (a
function provides one or more interfaces) but I'm a bit afraid that this
encodes tb10x-specific logic into the core...

> > d) implement gpio/pin conflict management in the already existing
> > callbacks inside the driver: Today, both enable and gpio_request_enable
> > exist (and can refuse a request for a configuration/pin).
> > If we only claim the pins used by a given interface instead of the
> > entire port, conflict management becomes natural (see
> > http://lkml.indiana.edu/hypermail/linux/kernel/1306.2/00749.html and the
> > following).
> 
> OK, that's basically the same as my proposal to add a new callback; it's
> simply re-using and existing driver callback rather than creating a new
> one solely for conflict checking.
> 
> Re-using the existing callback(s) seems fine, with appropriate prototype
> modification to pass back the list of pins that can-or-can't be
> dual-claimed I suppose.

I like this proposal but I would rather add a set of functions to the
core than modifying the prototype (more details in a separate email in
response to LinusW).

> > IMHO, the pinctrl drivers are the right place for everything but the
> > most basic pin conflict management since constraints on what can be
> > muxed at the same time are highly hardware implementation dependent. One
> > could e.g. imagine an implementation where a GPIO can override and snoop
> > a pin's output value in one mux configuration, just snoop the pin value
> > in another and do neither in a third.
> > 
> > I see two (independent) ways to enhance the pinctrl core in order to
> > support drivers in this task:
> > a) Add two functions pin_is_claimed and gpio_is_claimed which allow the
> > pinctrl driver to query if a given pin/gpio is available for muxing.
> > b) Add four functions lock_gpio/unlock_gpio and lock_pin/unlock_pin
> > which allow the pinctrl driver to prevent the core from granting
> > requests on GPIOs/pins.
> 
> Yes, either of those are basically what I proposed in my followup to the
> email you're replying to.

Actually what I was thinking of was the inverse of your suggestion: In
your suggestion the *_is_claimed functions were part of each driver, in
mine they were part of the core.

Greetings,
  Christian

-- 
  Christian Ruppert              ,          <christian.ruppert@abilis.com>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr?-Fleuri
                             _// | bilis Systems   CH-1228 Plan-les-Ouates
