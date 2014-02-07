From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Feb 2014 17:43:31 +0000
Subject: [PATCH RFC 2/2] drivers/base: declare phandle DT nodes as
 components
In-Reply-To: <9f8bbe28b00160cab2cedffa3f8fb42121035964.1391793068.git.moinejf@free.fr>
References: <cover.1391793068.git.moinejf@free.fr>
 <9f8bbe28b00160cab2cedffa3f8fb42121035964.1391793068.git.moinejf@free.fr>
Message-ID: <20140207174330.GF26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 05:53:27PM +0100, Jean-Francois Moine wrote:
> At system startup time, some devices depends on the availability of
> some other devices before starting. The infrastructure for componentised
> subsystems permits to handle this dependence, each driver defining
> its own role.
> 
> This patch does an automatic creation of the lowest components in
> case of DT. This permits simple devices to be part of complex
> componentised subsystems without any specific code.

A component with no operations makes precisely no sense - with that,
there's no way for the component to be a stand-alone driver.  Your
approach forces your ideas onto every DT device that is referenced
as a phandle.  That's extremely restrictive.

I don't want the component stuff knowing anything about OF.  I don't
want it knowing about driver matching.  I don't want it knowing about
ACPI either.  That's the whole point behind it - it is 100% agnostic
about how that stuff works.

The model is quite simply this:

- a master device is the covering component for the "card"
  - the master device knows what components to expect by some means.
    In the case of DT, that's by phandle references to the components.
  - the master device handles the component independent setup of the
    "card", creating the common resources that are required.  When it's
    ready, it asks for the components to be bound.
  - upon removal of any component, the master component is unbound,
    which triggers the removal of the "card" from the subsystem.
  - as part of the removal, sub-components are unbound.
  - the master device should have as /little/ knowledge about the
    components as possible to permit component re-use.

- a component driver should be independent of it's master.
  - A component which is probed from the device model should simply
    register itself using component_add() with an appropriate operations
    structure, and a removal function which deletes itself.
  - When the driver is ready to be initialised (when the "card" level
    resources have been set in place) the "bind" method will be called.
    At this point, the component does everything that a classical driver
    model driver would do in it's probe callback.
  - unbind is the same as remove in the classical driver model.

So, please, no DT stuff in the component support - it's simply not
required.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
