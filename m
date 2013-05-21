From: w@1wt.eu (Willy Tarreau)
Date: Tue, 21 May 2013 21:38:03 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130521193803.GA20882@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, May 21, 2013 at 12:33:25PM +0200, Thomas Petazzoni wrote:
(...)
> As it was explained above, we unfortunately can't read the
> current base address of the internal register window, so we need a
> different mechanism to know if the bootloader has done the remapping
> at 0xF1000000 (new generation bootloader) or has left the internal
> registers at 0xD0000000 (old generation bootloader).

Just out of curiosity, what happens if you touch the register at the
wrong address ? I mean, if you blindly write to the 0xD0xxxxxx address
that you want the registers to be mapped at 0xF1xxxxxx. Will the chip
hang, will it silently ignore the sequence ? Because maybe you don't
need to detect using CP15 whether the remapping was done, you could
simply perform it unconditionally. Another point would be that if the
boot loader is the only one to know whether the registeres were remapped,
then maybe it could put something into the atags or DT about this. And
maybe we'll simply find that DT-enabled boot loaders are remapped and
that non-DT ones are not.

Just a few ideas since you feel a bit worried about the fragility of
the CP15 bit :-)

Willy
