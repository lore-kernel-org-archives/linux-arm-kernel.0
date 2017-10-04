From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 12:50:08 +0200
Subject: [PATCH v3 02/22] dt-bindings: arm: add support for ARM System
 Control and Management Interface(SCMI) protocol
In-Reply-To: <1506604306-20739-3-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a2-7NJTukWaf3=oB9dC+b3uuOGiN+Kc95FS_YBGGHz3ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> +
> +The SCMI is intended to allow agents such as OSPM to manage various functions
> +that are provided by the hardware platform it is running on, including power
> +and performance functions.
> +
> +This binding is intended to define the interface the firmware implementing
> +the SCMI as described in ARM document number ARM DUI 0922B ("ARM System Control
> +and Management Interface Platform Design Document")[0] provide for OSPM in
> +the device tree.
> +
> +Required properties:
> +
> +The scmi node with the following properties shall be under the /firmware/ node.
> +
> +- compatible : shall be "arm,scmi"
> +- mboxes: List of phandle and mailbox channel specifiers. It should contain
> +         exactly one or two mailboxes, one for transmitting messages("tx")
> +         and another optional for receiving the notifications("rx") if
> +         supported.
> +- mbox-names: shall be "tx" or "rx"

The example below does not have the mbox-names property. If you require
exactly two mailboxes, why do you need the names anyway?

However, your example does have a #addresss-cells/#size-cells
property that are not documented here. Please add them here as either
optional or required, and describe what the permitted values are and
how the address is interpreted.

> +- shmem : List of phandle pointing to the shared memory(SHM) area as per
> +         generic mailbox client binding.
> +
> +See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
> +about the generic mailbox controller and client driver bindings.
> +
> +The mailbox is the only permitted method of calling the SCMI firmware.
> +Mailbox doorbell is used as a mechanism to alert the presence of a
> +messages and/or notification.

This looks odd: why not make the message itself part of the mailbox
protocol here, and leave the shmem as a implementation detail of the
mailbox driver?

> +Each protocol supported shall have a sub-node with corresponding compatible
> +as described in the following sections. If the platform supports dedicated
> +communication channel for a particular protocol, the 3 properties namely:
> +mboxes, mbox-names and shmem shall be present in the sub-node corresponding
> +to that protocol.
> +
> +Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
> +------------------------------------------------------------
> +
> +This binding uses the common clock binding[1].
> +
> +Required properties:
> +- #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.
> +

How does the OS identify the fact that a subnode uses the clock binding?
Do you need to look for the #clock-cells property, or is this based on the
unit address?

          Arnd
