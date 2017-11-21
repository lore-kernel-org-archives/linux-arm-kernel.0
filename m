From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Nov 2017 13:11:03 -0600
Subject: [PATCH 1/2] usb: xhci: add relaxed timing quirk bit
In-Reply-To: <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
 <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
Message-ID: <20171121191103.5oczqvrlo4gtwjqc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 12:18:09PM -0500, Adam Wallis wrote:
> Certain systems may run with CPUs at a very slow frequency. This
> patch adds a quirk bit that can be used to relax certain timings, etc.
> 
> This quirk might be needed for other fields in the future, but
> initially, it will be used only on the IRQ control register to allow
> firmare to control the value of the register. This can prevent an

s/firmare/firmware/

By firmware control, you mean the register is initialized on boot and 
then not touched by the kernel? What if the XHCI block is reset? Not 
sure if that's possible.

> "interrupt storm" effect on certain systems.

So now we have 2 ways to deal with this? The existing MediaTek quirk and 
now this one. 

I think you should change the existing quirk to a value and set the 
value based on compatible strings.

> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
>  drivers/usb/host/xhci.c                            | 25 +++++++++++++++-------
>  drivers/usb/host/xhci.h                            |  1 +
>  3 files changed, 19 insertions(+), 8 deletions(-)
