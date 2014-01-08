From: robherring2@gmail.com (Rob Herring)
Date: Wed, 8 Jan 2014 11:28:01 -0600
Subject: [RFC 04/18] driver core & of: Mark of_nodes of added device as
 populated
In-Reply-To: <1387815830-8794-5-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-5-git-send-email-pawel.moll@arm.com>
Message-ID: <CAL_JsqJGQFstgFu=tpho91C0iv4eH9XSCAVKfXXQO4Z+yD-0tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 10:23 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> In "Device Tree powered" systems, platform devices are usually
> massively populated with of_platform_populate() call, executed
> at some level of initcalls, either by generic architecture
> or by platform-specific code.
>
> There are situations though where certain devices must be
> created (and bound with drivers) before all the others.
> This presents small challenge in DT-driven systems, as
> devices explicitly created in early code would be created
> again by of_platform_populate().

Isn't this already at least partially solved with the aux data
support? I'm guessing the difference here is how the early device is
created.

> This patch tries to solve that issue in a generic way,
> adding a "populated" flag which is set in the device_node
> structure when a device is being created in the core.
> Later, of_platform_populate() skips such nodes (and
> its children) in a similar way to the non-available ones.

Couldn't you store a struct device ptr in struct device_node instead?

In any case I'd like to see this contained within the DT code. I don't
see why the driver core needs to be modified for a DT specific
problem.

Rob
