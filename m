From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 19 Feb 2014 14:10:51 -0700
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <3905203.TvF8RmfLsz@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <3312083.odPX4th7oi@wuerfel>
 <CAErSpo5PCTyZ5jzumJxD=CCN+-t-Z31Cw+9ejT_oTQ4fFQePag@mail.gmail.com>
 <3905203.TvF8RmfLsz@wuerfel>
Message-ID: <20140219211051.GA17826@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 09:48:48PM +0100, Arnd Bergmann wrote:

> Hmm, we'll have to think about that. From a DT perspective, we try
> to keep things local to the node using it, so listing only the
> registers we are allowed to access is more natural.

If I understand the restriction properly, in a modern PCI-E world it
boils down to a limition on the configuration of each PCI-PCI root
port bridge (eg, a limited range of valid bus values, and apertures)

AFAIK it comes from the hidden per-socket routing registers that the
firwmare configures. Range X->Y (bus #, IO and MMIO) will be routed to
a specific physical socket, and then the PCI-E bridges in that socket
claim the transatcion based on their local config to select the
ultimate egress port.

So describing and restricting the bridge DT node itself, under a
single top level PCI domain stanza seems pretty reasonable.

As does containing the restrictions in a HW driver with knowledge of
the hidden registers, especially for firmware-less embedded. This is
part of what mvebu is doing already.

Jason
