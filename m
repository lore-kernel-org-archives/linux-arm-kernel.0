From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 28 Nov 2016 09:54:28 -0800
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2016 07:50 AM, Jerome Brunet wrote:
> This patchset fixes an issue with the OdroidC2 board (DWMAC + RTL8211F).
> The platform seems to enter LPI on the Rx path too often while performing
> relatively high TX transfer. This eventually break the link (both Tx and
> Rx), and require to bring the interface down and up again to get the Rx
> path working again.
> 
> The root cause of this issue is not fully understood yet but disabling EEE
> advertisement on the PHY prevent this feature to be negotiated.
> With this change, the link is stable and reliable, with the expected
> throughput performance.
> 
> The patchset adds options in the generic phy driver to disable EEE
> advertisement, through device tree. The way it is done is very similar
> to the handling of the max-speed property.
> 
> Patch 4 is provided here for testing purpose only. Please don't merge
> patch 4, this change will go through the amlogic's tree.

Sorry, but I really don't like the route this is going, and I should
have made myself clearer before on that, I really think utilizing a PHY
fixup is more appropriate here than an extremely generic DT property.
The fixup code can be in the affected PHY driver, or it can be somewhere
else, your call. There is no shortage of option on how to implement it,
and this would be something easy to enable/disable for known good
configurations (ala PCI/USB fixups).

If we start supporting generic "enable", "disable" type of properties
with values that map directly to register definitions of the HW, we
leave too much room for these properties to be utilized to implement a
specific policy, and this is not acceptable.
-- 
Florian
