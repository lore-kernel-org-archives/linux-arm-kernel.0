From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 22:50:29 +0100
Subject: [PATCH 05/15] musb: Do not use musb_read[b|w] / _write[b|w]
 wrappers in generic fifo functions
In-Reply-To: <1425933628-9672-6-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <1425933628-9672-6-git-send-email-hdegoede@redhat.com>
Message-ID: <4821047.1nqnop93Xh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 21:40:18 Hans de Goede wrote:
> The generic fifo functions already use non wrapped accesses in various
> cases through the iowrite#_rep functions, and all platforms which override
> the default musb_read[b|w] / _write[b|w] functions also provide their own
> fifo access functions, so we can safely drop the unnecessary indirection
> from the fifo access functions.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 

The patch looks reasonably, but the description seem misleading.
I believe the real reason why it's ok to use __raw_writew for the
FIFO is that a FIFO by definition is using CPU endian access for
copying byte streams from memory, which is unlike any other MMIO
register that requires fixed-endian accessors.

	Arnd
