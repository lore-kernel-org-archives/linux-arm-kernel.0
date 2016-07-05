From: daniel@0x0f.com (Daniel Palmer)
Date: Wed, 6 Jul 2016 02:33:52 +0900
Subject: sh-eth.c writes to non-existent register on RZ/A1
Message-ID: <CAFr9PXniO=qPUpok1dVHzjrEpKVo6t3koc2n=UCjWrdD_DL+5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not sure if this is the right list or not. Please CC me as I'm not subscribed.

I've been working on getting Linux running on the GR Peach board
(https://developer.mbed.org/platforms/Renesas-GR-PEACH/).
It has the Renesas RZ/A1H chip and it's ethernet controller is supported by
drivers/net/ethernet/sh_eth.c.
There seem to be a few different controllers that are roughly the same
and used in Renesas chips that are supported by the driver and there
are a few tables to handle differing locations for the registers.
There also seem to be controllers that have a "tsu" and some that
don't.

The controller in the RZ/A1 has a tsu but is missing one of the
registers that is called "TSU_POST1" in the tables for other chips.
This register doesn't exist according to the hardware manual for the
RZ/A1.

The problem is that the sh_eth driver doesn't handle that and in
sh_eth_tsu_enable_cam_entry_post() uses the offset table for the RZ/A1
which doesn't have an offset to TSU_POST1 to find the register and
then writes outside of the memory range that has been mapped and
crashes the kernel.

Commenting out the register write stops the kernel crashing and the
ethernet seems to work.

There is a function in sh_eth.c called sh_eth_is_rz_fast_ether() that
seems to be for working around slight differences with this version of
the controller and I considered submitting a patch with the contents
of sh_eth_tsu_enable_cam_entry_post() wrapped with if(sh_eth_is...)
but I have next to no knowledge of how the hardware actually works so
I'm looking for someone that does to chime in.

Cheers,

Daniel
