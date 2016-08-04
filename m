From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 4 Aug 2016 18:15:18 +0200
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <32e4f4c5-81d1-4a84-69af-e1b05d564bd7@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160804153835.GY1041@n2100.armlinux.org.uk>
 <32e4f4c5-81d1-4a84-69af-e1b05d564bd7@codeaurora.org>
Message-ID: <39afe8fb-4356-b6a3-9e17-5b60abf10040@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2016 06:08 PM, Sinan Kaya wrote:
[...]
> The other way is I can feed this information to what Dave just introduced
> as part of the callback mechanism and not touch this.

Use the callback mechanism. It is a lot easier to implement correctly than
the tx_status() mechanism.

> The main discussion here is that 
> 
> "tx_status does not indicate whether the final transaction is successful or
> not" whether the driver has the capability to determine error or not.

tx_status() is supposed to be able to indicate whether a transfer failed or
not. But in my opinion this feature is broken by design and implementing it
correctly is very difficult without creating memory leaks. Which is probably
why so few drivers actually implement it.
