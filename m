From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jun 2014 15:42:06 -0600
Subject: [PATCH v1 1/9] of: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <1403072180-4944-2-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
 <1403072180-4944-2-git-send-email-abrestic@chromium.org>
Message-ID: <53AB422E.4040707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
> Add device-tree bindings for the Tegra XUSB mailbox which will be used
> for communication between the Tegra XHCI controller and the host.

Sorry for the slow review.

> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt

> +NVIDIA Tegra XUSB mailbox
> +=========================
> +
> +The Tegra XUSB mailbox is used by the Tegra XHCI controller's firmware to
> +communicate with the host.

Isn't the mailbox an internal implementation detail of the XUSB controller.

In other words, I'd naively think that there isn't a standalone generic
mailbox that can be used by anything, but we just happen to want to use
for XUSB. Rather, there's an XUSB controller, and part of the interface
to that controller is a mailbox.

As such, I don't think we want a standalone mailbox node in DT. Rather,
we should add the required reg and interrupt values into the XUSB DT node.

The driver for that XUSB HW module can either:

a) Register as both a mailbox driver and an EHCI driver.

b) Spawn a child device to instantiate the mailbox driver.

Perhaps (b) could be assisted by using the MFD framework?
